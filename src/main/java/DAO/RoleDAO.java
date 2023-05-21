package DAO;

import Connect.ConnectDB;
import DTO.Permission;
import DTO.RoleDTO;
import Model.Role;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RoleDAO {
    public static List<RoleDTO> getAllRole() throws SQLException {
        List<RoleDTO> list=new ArrayList<>();
        Connection c = ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("select * from role");
        ResultSet rs = stmt.executeQuery();
        while  (rs.next()) {
            RoleDTO role = getRoleDTO(rs.getInt(1));
            role.setName(rs.getString(2));
            list.add(role);
        }
        return list;
    }

    public static Role getRole(int id) throws SQLException {
        Connection c = ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("select * from role_permission where role_id = ?");
        stmt.setInt(1,id);
        ResultSet rs = stmt.executeQuery();
        Role role = new Role();
        while  (rs.next()) {
            role.setId(rs.getInt(1));

            role.addPermission(rs.getInt(2));
        }
        return role;
    }
    public static RoleDTO getRoleDTO(int id) throws SQLException {
        Connection c = ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("select * from role_permission where role_id = ?");
        stmt.setInt(1,id);
        ResultSet rs = stmt.executeQuery();
        RoleDTO role = new RoleDTO();
        while  (rs.next()) {
            role.setId(rs.getInt(1));
            role.addPermission(getPermission(rs.getInt(2)));
        }
        return role;
    }
    public static Permission getPermission(int id) throws SQLException {
        Connection c = ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("select * from permission where id = ?");
        stmt.setInt(1,id);
        ResultSet rs = stmt.executeQuery();
        while  (rs.next()) {
            Permission permission = new Permission(rs.getInt(1), rs.getString(2));
            return permission;

        }
        return null;
    }
    public static void main(String[] args) throws SQLException {
        System.out.println(RoleDAO.getRole(3));
    }
}
