package Controller;

import DAO.OderDAO;
import DAO.ProductDAO;
import DAO.RoleDAO;
import DAO.UserDAO;
import DTO.Orders;
import DTO.RoleDTO;
import Model.Oder;
import Model.OrderDetail;
import Model.Role;
import Model.User;
import Security.Authorizeds;
import Security.ReLogin;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/api/role")
public class RoleAPI extends HttpServlet {
    @Override
    protected  void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        res.setContentType("text/html;charset=UTF-8");
        req.setCharacterEncoding("utf-8");
        try {
            ArrayList<RoleDTO> roles = (ArrayList<RoleDTO>) RoleDAO.getAllRole();
            res.getWriter().println(new Gson().toJson(roles));
            return;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        res.setContentType("text/html;charset=UTF-8");
        req.setCharacterEncoding("utf-8");
        String action = req.getParameter("action");
        if(action == null){
            res.setStatus(404);
            return;
        }
        switch (action){
            case "insert" :
                if(Authorizeds.authorizeds(req, Authorizeds.ROLE_INSERT))
                try {
                    roleInsert(req,res);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                else{
                    res.setStatus(401);
                }
                break;
            case "update" :
                if(Authorizeds.authorizeds(req, Authorizeds.ROLE_UPDATE))
                    try {
                        roleUpdate(req,res);
                    } catch (SQLException e) {
                        throw new RuntimeException(e);
                    }
                else{
                    res.setStatus(401);
                }
                break;
            case "set_role" :
                if(Authorizeds.authorizeds(req, Authorizeds.USER_UPDATE))
                    try {
                        setRole(req,res);
                    } catch (SQLException e) {
                        throw new RuntimeException(e);
                    }
                else{
                    res.setStatus(401);
                }
                break;
            case "get_account" :
                try {
                    getAccount(req,res);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                break;
            case "delete_role" :
                if(Authorizeds.authorizeds(req, Authorizeds.ROLE_DELETE))
                    try {
                        roleDelete(req,res);
                    } catch (SQLException e) {
                        throw new RuntimeException(e);
                    }
                else{
                    res.setStatus(401);
                }
                break;
            default:

        }
    }

    private void setRole(HttpServletRequest req, HttpServletResponse res) throws SQLException, IOException {
        String idUser = req.getParameter("idUser");
        String idRole = req.getParameter("idRole");
        if(idUser != null && idRole != null){
            UserDAO.changleRoleByUser(Integer.valueOf(idUser),Integer.valueOf(idRole));
            User user = UserDAO.getUserById(Integer.valueOf(idUser));
           res.getWriter().println(1);
           ReLogin.arrReLogin.add(user.getUserName());
           return;
        }
        res.getWriter().println(-1);
    }

    private void getAccount(HttpServletRequest req, HttpServletResponse res) throws SQLException, IOException {
        ArrayList<User> users = (ArrayList<User>) UserDAO.getAllAccount();
        System.out.println(users.size() + "getAccount");
        res.getWriter().println(new Gson().toJson(users));
    }

    private void roleUpdate(HttpServletRequest req, HttpServletResponse res) throws SQLException, IOException {
        String permissions = req.getParameter("idPermissions");
        String name = req.getParameter("name");
        String id = req.getParameter("id");
        if(name != null && id != null && permissions != null){
            int[] idPermissions = new Gson().fromJson(permissions, int[].class);
            int idNumber = Integer.valueOf(id);
            RoleDAO.editNameRole(idNumber, name);

            RoleDAO.deleteRole_Permission(idNumber);
            RoleDAO.addRolePermission(idPermissions, idNumber);
            RoleDTO role = RoleDAO.getRoleById(idNumber);
            ArrayList<User> users = UserDAO.getUserByRole(role.getId());
            for (User tmp: users) {
                ReLogin.arrReLogin.add(tmp.getUserName());
            }
            res.getWriter().println(new Gson().toJson(role));
            return;
        }
        res.getWriter().println(-1);
    }

    private void roleDelete(HttpServletRequest req, HttpServletResponse res) throws SQLException, IOException {
        String idRole = req.getParameter("id");
        if(idRole != null){
            int id = Integer.valueOf(idRole);
            ArrayList<User> users = UserDAO.getUserByRole(id);
            for (User tmp: users) {
                ReLogin.arrReLogin.add(tmp.getUserName());
            }
            UserDAO.changleRoleAllUser(id, 21);
            int rs = RoleDAO.deleteRole(id);
            res.getWriter().println(1);
            return;
        }
        res.getWriter().println(0);

    }

    private void roleInsert(HttpServletRequest req, HttpServletResponse res) throws SQLException, IOException {
        String name = req.getParameter("name");
        int[] numbers = new Gson().fromJson(req.getParameter("idPermissions"), int[].class);
        if (numbers != null && numbers.length > 0) {
            int idRole = RoleDAO.insertRole(name);
           int add = RoleDAO.addRolePermission(numbers,idRole);
            res.getWriter().println(1);
            return;
        }
        res.getWriter().println(0);
    }

}