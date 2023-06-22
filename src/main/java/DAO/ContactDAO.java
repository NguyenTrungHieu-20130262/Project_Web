package DAO;

import Connect.ConnectDB;
import Model.Log;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ContactDAO {
    public static int sendForm(String name, String email, String phone, String descrition) throws SQLException {
        Connection c = ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("insert into contact (name, email, phone, description) values (?, ?, ?, ?)");
        stmt.setString(1,name);
        stmt.setString(2,email);
        stmt.setString(3,phone);
        stmt.setString(4,descrition);
        return stmt.executeUpdate();

    }
}
