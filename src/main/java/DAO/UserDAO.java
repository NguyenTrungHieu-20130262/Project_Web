package DAO;

import Connect.ConnectDB;
import Model.Role;
import Model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class UserDAO {
    public static boolean checkLogin(String username, String pass) throws SQLException {
        Connection c = ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("select * from user where username=? and password=? and status=?");
        stmt.setString(1, username);
        stmt.setString(2, pass);
        stmt.setInt(3, 1);
        ResultSet rs = stmt.executeQuery();
        return rs.next();
    }

    public static boolean checkByEmail(String email) throws SQLException {
        Connection c = ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("select email from user where email=?");
        stmt.setString(1, email);
        ResultSet rs = stmt.executeQuery();
        return rs.next();
    }

    public static boolean checkByUsername(String username) throws SQLException {
        Connection c = ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("select username from user where username=?");
        stmt.setString(1, username);
        ResultSet rs = stmt.executeQuery();
        return rs.next();
    }

    public static int getCountUser() throws SQLException {
        Connection c = ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("select count(*) from user where role=0 ");
        ResultSet rs = stmt.executeQuery();
        rs.next();
        int countRow = rs.getInt(1);
        System.out.println(countRow);
        return countRow;
    }

    public static User getUserByName(String name) throws SQLException {
        Connection c = ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("select * from user where username=?");
        stmt.setString(1, name);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            int idUser = rs.getInt("id");
            String userName = rs.getString("username");
            String fullName = rs.getString("fullname");
            String email = rs.getString("email");
            String pass = rs.getString("password");
            String phone = rs.getString("phone");
            String address = rs.getString("address");
            String avatar = rs.getString("avatar");
            int role = Integer.valueOf(rs.getString("role"));
            int status = Integer.valueOf(rs.getString("status"));
            int statusLogin = rs.getInt("statusLogin");

            User user = new User(userName, pass, fullName, email, phone, avatar, address, RoleDAO.getRole(role), status, statusLogin);
            user.setId(idUser);
            return user;
        }
        ;
        return null;

    }
    public static ArrayList<User> getUserByRole(int id) throws SQLException {
        ArrayList<User> users = new ArrayList<>();
        Connection c = ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("select username from user where role=?");
        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            User user = new User();
            user.setUserName(rs.getString("username"));
            users.add(user) ;
        }
        return users;

    }
    public static int changleRoleAllUser(int idRole, int idRoleNew) throws SQLException {
        Connection c = ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("update user set role = ? where role = ?;");
        stmt.setInt(1, idRoleNew);
        stmt.setInt(2, idRole);

        return  stmt.executeUpdate();


    }
    public static int changleRoleByUser(int idUser, int idRole) throws SQLException {
        Connection c = ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("update user set role = ? where id = ?;");
        stmt.setInt(1, idRole);
        stmt.setInt(2, idUser);

        return  stmt.executeUpdate();


    }
    public static User getInfoByUserName(String username) throws SQLException {
        Connection c = ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("select userName,fullname,email,phone,address  from user where userName=?");
        stmt.setString(1, username);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            String userName = rs.getString("userName");
            String fullName = rs.getString("fullname");
            String email = rs.getString("email");
            String phone = rs.getString("phone");
            String address = rs.getString("address");
            User user = new User();
            user.setUserName(userName);
            user.setFullName(fullName);
            user.setEmail(email);
            user.setPhone(phone);
            user.setAddress(address);

            return user;
        }
        ;
        return null;

    }
    public static User getUserById(int id) throws SQLException {
        Connection c = ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("select * from user where id=?");
        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            int idUser = rs.getInt("id");
            String userName = rs.getString("username");
            String fullName = rs.getString("fullname");
            String email = rs.getString("email");
            String pass = rs.getString("password");
            String phone = rs.getString("phone");
            String address = rs.getString("address");
            String avatar = rs.getString("avatar");
            int role = Integer.valueOf(rs.getString("role"));
            int status = Integer.valueOf(rs.getString("status"));
            int statusLogin = rs.getInt("statusLogin");
            User user = new User(userName, pass, fullName, email, phone, avatar, address, RoleDAO.getRole(role), status, statusLogin);
            user.setId(idUser);
            return user;
        }
        return null;

    }
    public static int getUserIdByUsename(String username) throws SQLException {
        Connection c = ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("select id from user where username=?");
        stmt.setString(1, username);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            int idUser = rs.getInt("id");

            return idUser;
        }

        return -1;

    }
    public static int insertUser(User user) throws SQLException, ClassNotFoundException {
        Connection c = ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("insert into user (username,password,fullname,email,phone,address,role,status,statusLogin) value(?,?,?,?,?,?,?,?,?)");
        stmt.setString(1, user.getUserName());
        stmt.setString(2, user.getPassWord());
        stmt.setString(3, user.getFullName());
        stmt.setString(4, user.getEmail());
        stmt.setString(5, user.getPhone());
        stmt.setString(6, user.getAddress());
        stmt.setInt(7, 4);
        stmt.setInt(8, user.getStatus());
        stmt.setInt(9, user.getStatusLogin());
        int rs = stmt.executeUpdate();
        return rs;
    }
    public static int updateStatus(String username, int status) throws SQLException {
        Connection c = ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("UPDATE user\n" +
                "SET  status = ? " +
                "WHERE username = ?");
        stmt.setInt(1, status);
        stmt.setString(2,username);
        int rs = stmt.executeUpdate();
        return rs;
    }


    public static int uploadAvatar(String user, String linkAvatar) throws SQLException, ClassNotFoundException {
        Connection c = ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("UPDATE `user`" +
                "SET avatar = ? WHERE username = ?");
        stmt.setString(1, linkAvatar);
        stmt.setString(2, user);
        int rs = stmt.executeUpdate();
        return rs;
    }
    public static int updateUserAdmin(int id,String userName,int phoneNumber,String address ) throws SQLException {
        System.out.println(userName);
        Connection c = ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("UPDATE user SET  fullname = ?, phone = ?,address=? WHERE id = ?");
        stmt.setString(1, userName);
        stmt.setInt(2, phoneNumber);
        stmt.setString(3, address);
        stmt.setInt(4, id);
        int rs = stmt.executeUpdate();
        return rs;
    }
    public static int updateUser(String username, String pass, String fullname, String email, String phone, String address) throws SQLException, ClassNotFoundException {
        Connection c = ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("UPDATE user\n" +
                "SET password = ?, fullname = ?,email = ?, phone = ?, address = ?\n" +
                "WHERE username = ?");
        stmt.setString(1, pass);
        if (fullname.equals("null")) {
            stmt.setNull(2, Types.INTEGER);
        } else {
            stmt.setString(2, fullname);
        }

        if (email.equals("null")) {
            stmt.setNull(3, Types.INTEGER);
        } else {
            stmt.setString(3, email);
        }

        if (phone.equals("null")) {
            stmt.setNull(4, Types.INTEGER);
        } else {
            stmt.setString(4, phone);
        }
        if (address.equals("null")) {
            stmt.setNull(5, Types.INTEGER);
        } else {
            stmt.setString(5, address);
        }
        stmt.setString(6, username);
        int rs = stmt.executeUpdate();
        return rs;
    }
    public static boolean checkAdmin(int id) throws SQLException {
        Connection c = ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("select * from user where id=?");
        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();
        if (rs.next() && rs.getInt("role") == 1) {
            return true;
        }
        return false;
    }
    public static List<User> getAllUser() throws SQLException {
        List<User> list = new ArrayList<>();
        Connection c = ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("select * from user where role!=3");
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {

            list.add(new User(rs.getInt("id"),rs.getString("username"), rs.getString("fullname"), rs.getString("email"), rs.getString("phone"), rs.getString("avatar"), rs.getString("address"), RoleDAO.getRole(rs.getInt("role")), rs.getInt("status"), rs.getInt("statusLogin")));
        }
        return list;
    }
    public static List<User> getAllAccount() throws SQLException {
        List<User> list = new ArrayList<>();
        Connection c = ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("select * from user  ");
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            list.add(new User(rs.getInt("id"),rs.getString("username"), rs.getString("fullname"), rs.getString("email"), rs.getString("phone"), rs.getString("avatar"), rs.getString("address"), RoleDAO.getRoleInfo(rs.getInt("role")), rs.getInt("status"), rs.getInt("statusLogin")));
        }
        return list;
    }
    public Role getRole(int idRole) throws SQLException {
        Connection c = ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("select * from role where id=?");
        stmt.setInt(1,idRole);
        ResultSet rs = stmt.executeQuery();
        while (rs.next()){
            return new Role(rs.getString(2),rs.getInt(3));
        }
        return null;
    }
    public static int changeStatus(int id, int status) throws SQLException {
        Connection c = ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("UPDATE user SET status =? WHERE id = ?");
        stmt.setInt(1,status);
        stmt.setInt(2,id);
        int rs = stmt.executeUpdate();
        return rs;
    }
    public static int updateColUser( String username, String col, String value, String type) throws SQLException {

        Connection c = ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("UPDATE user\n" +
                "SET  "+col+" = ? " +
                "WHERE username = ?");
        if(type.toLowerCase().trim().equals("int")){
            stmt.setInt(1, Integer.valueOf(value));
        }
        if(type.toLowerCase().trim().equals("string")){
            stmt.setString(1, value);
        }
        stmt.setString(2, username);

        int rs = stmt.executeUpdate();
        return rs;
    }

    public static int changePassword(String pass,int id) throws SQLException {
        Connection c = ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("UPDATE user\n" +
                "SET  password = ? " +
                "WHERE id = ?");
        stmt.setString(1, pass);
        stmt.setInt(2, id);
        int rs = stmt.executeUpdate();
        return rs;
    }


}
