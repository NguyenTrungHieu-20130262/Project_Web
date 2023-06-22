package DAO;

import Utils.AbBean;
import Connect.ConnectDB;
import Model.Log;
//import org.springframework.security.access.prepost.PreAuthorize;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class LogDAO {
    public static boolean insert(AbBean bean) throws SQLException {
        return bean.insert(ConnectDB.getConnect());
    }
    public static List<Log> getAllLog() throws SQLException {
        List<Log> list = new ArrayList<>();
        Connection c = ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("select * from log");
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            list.add(new Log(rs.getInt(1),rs.getInt(2),rs.getInt(3),rs.getString(4),rs.getString(5),rs.getDate(6),rs.getInt(7)));
        }
        return list;
    }
//    @PreAuthorize("hasPermission('USER', 'READ')")
    public static int getTest(){
        return 1;
    }

    public static void main(String[] args) throws SQLException {
        getTest();
    }
}
