package Model;

import Utils.AbBean;
import Connect.ConnectDB;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

public class Log implements AbBean {
    int id;
    int level;
    int userID;
    String src;
    String content;
    Date createAt;
    int status;

    static Map<Integer, String> levelMapping = new HashMap<>();

    static {
        levelMapping.put(0, "INFO");
        levelMapping.put(1, "ALERT");
        levelMapping.put(2, "WARNING");
        levelMapping.put(3, "DANGER");
    }

    public static int INFO = 0;
    public static int ALERT = 1;
    public static int WARNING = 2;
    public static int DANGER = 3;

    public Log(int level, int userID, String src, String content, int status) {
        this.level = level;
        this.userID = userID;
        this.src = src;
        this.content = content;
        this.status = status;
    }

    public Log(int level, int userID, String src, int status) {
        this.level = level;
        this.userID = userID;
        this.src = src;
        this.status = status;
    }


    public Log(int id, int level, int userID, String src, String content, Date createAt, int status) {
        this.id = id;
        this.level = level;
        this.userID = userID;
        this.src = src;
        this.content = content;
        this.createAt = createAt;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getSrc() {
        return src;
    }

    public void setSrc(String src) {
        this.src = src;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Date createAt) {
        this.createAt = createAt;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public static Map<Integer, String> getLevelMapping() {
        return levelMapping;
    }

    public static void setLevelMapping(Map<Integer, String> levelMapping) {
        Log.levelMapping = levelMapping;
    }

    public String getNameStatus() {
        return this.status == 1 ? "Hoạt động" : "";
    }

    @Override
    public boolean insert(Connection connect) throws SQLException {
        String sqlUpdate = "INSERT INTO log(`level`, `idUser`,src,content,`status`) values(?,?,?,?,?)";
        Connection conn = ConnectDB.getConnect();
        PreparedStatement pstmt = conn.prepareStatement(sqlUpdate);
        pstmt.setInt(1, this.level);
        pstmt.setObject(2, this.userID == -1 ? null : this.userID);
        pstmt.setString(3, this.src);
        pstmt.setString(4, this.content);
        pstmt.setInt(5, this.status);
        int rowAffected = pstmt.executeUpdate();
        return rowAffected == 1;
    }

}
