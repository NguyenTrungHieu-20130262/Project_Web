package DAO;

import Connect.ConnectDB;
import Model.Company;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class CompanyDAO {



    public static Company getVendoById(int id) throws SQLException {
        Connection c = ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("select * from vendo where id = ?");
        stmt.setInt(1,id);
        ResultSet resultSet = stmt.executeQuery();
        while (resultSet.next()){
            return new Company(resultSet.getInt(1), resultSet.getString(2) , resultSet.getString(3));
        }
        return null;
    }
    public static ArrayList<Company> getAllCompany() throws SQLException {
        ArrayList<Company> companys = new ArrayList<>();
        Connection c = ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("select  * from vendo");
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            companys.add(new Company(
                    rs.getInt(1),
                    rs.getString(2),
                    rs.getString(3)));
        }
        return companys;
    }

    public static Company getIdByName(String name) throws SQLException {
        String query = "select * from vendo where name=?";
        PreparedStatement stmt = ConnectDB.getConnect().prepareStatement(query);
        stmt.setString(1, name);
        ResultSet resultSet = stmt.executeQuery();
        while (resultSet.next()) {
            return new Company(resultSet.getInt(1), resultSet.getString(2) , resultSet.getString(3));
        }
        return null;

    }

    public static void main(String[] args) throws SQLException {
        System.out.println(CompanyDAO.getAllCompany().size());
    }

}
