package Controller;

import Utils.HashSHA216;
import Connect.ConnectDB;
import DAO.UserDAO;
import Model.Log;
import Model.User;
import com.google.gson.Gson;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@WebServlet("/profile")
public class Profile extends HttpServlet {
    private void changleUser(HttpServletRequest req, HttpServletResponse res) throws IOException, SQLException, ClassNotFoundException {
        res.setContentType("text/html;charset=UTF-8");
        req.setCharacterEncoding("utf-8");
        User user = (User) req.getSession().getAttribute("user");

        Map<String, String[]> params = req.getParameterMap();
        String pass = null;
        try {
            pass = params.get("oldpass")[0];
        } catch (Exception e) {
        }
        if (pass != null) {
            String oldPass = HashSHA216.hash(pass);
            if (!UserDAO.checkLogin(user.getUserName(), oldPass)) {
                res.getWriter().println(-2);
                return;
            }
            user.setFullName(URLDecoder.decode(params.get("fullName")[0], "UTF-8"));
            user.setAddress( URLDecoder.decode(params.get("address")[0], "UTF-8"));
            user.setEmail(params.get("email")[0]);
            user.setPhone(params.get("phone")[0]);
            user.setPassWord(HashSHA216.hash(params.get("passnew")[0]));
            int rsUpdate = UserDAO.updateUserAndPass(user);
            if(rsUpdate == 1){
                saveSession(user, req);
                user.setPassWord(null);
                res.getWriter().println(new Gson().toJson(user));
                return;
            }
            res.getWriter().println(-1);
        } else {
            user.setFullName(URLDecoder.decode(params.get("fullName")[0], "UTF-8"));
            user.setAddress( URLDecoder.decode(params.get("address")[0], "UTF-8"));
            user.setEmail(params.get("email")[0]);
            user.setPhone(params.get("phone")[0]);
            int rsUpdate = UserDAO.updateUser(user);

            if (rsUpdate == 1) {
                Log log = new Log(Log.ALERT, user.getId(), this.getClass().getName(), "Chỉnh sửa hồ sơ user(Profile)", 1);
                log.insert(ConnectDB.getConnect());
                saveSession(user, req);
                user.setPassWord(null);
                res.getWriter().write(new Gson().toJson(user));
                return;
            }
            res.getWriter().println(-1);
        }
    }

    protected void changeAvatar(HttpServletRequest req, HttpServletResponse res, String user,User userU) throws ServletException, IOException, SQLException {
        DiskFileItemFactory fileItemFactory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(fileItemFactory);
        try {
            List<FileItem> fileItems = upload.parseRequest(req);
            for (FileItem fileItem : fileItems) {
                if (!fileItem.isFormField()) {
                    String nameimg = fileItem.getName();
                    if (!nameimg.equals("")) {
                        String dirUrl = req.getServletContext()
                                .getRealPath("") + File.separator + "Img/User";
                        File dir = new File(dirUrl);
                        if (!dir.exists()) {
                            dir.mkdir();
                        }
                        String fileImg = dirUrl + File.separator + user + ".jpg";
                        File file = new File(fileImg);
                        try {
                            fileItem.write(file);
                            int rs = UserDAO.uploadAvatar(user, "Img/User/" + user + ".jpg");
                            if (rs > 0) {
                                Log log = new Log(Log.ALERT, userU.getId(), this.getClass().getName(), "Chỉnh sửa avatar user(Profile)", 1);
                                log.insert(ConnectDB.getConnect());
                            }
                            saveSession(UserDAO.getUserByName(user), req);
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                }
            }
        } catch (FileUploadException e) {
            e.printStackTrace();
        }
        res.sendRedirect("/profile");
    }
    private void changeProfileCart(HttpServletRequest req,HttpServletResponse res) throws IOException, SQLException {
        User user = (User) req.getSession().getAttribute("user");
        Map<String, String[]> params = req.getParameterMap();
        System.out.println("----------------------------zxc");
        if(params.get("name") != null){
            user.setFullName(URLDecoder.decode(params.get("name")[0], "UTF-8"));
        }
        if(params.get("address") != null){
            user.setAddress(URLDecoder.decode(params.get("address")[0], "UTF-8"));
        }
        if(params.get("phone") != null){
            user.setPhone(params.get("phone")[0]);
        }
        int rsUpdate = UserDAO.updateUser(user);

        if (rsUpdate == 1) {
            Log log = new Log(Log.ALERT, user.getId(), this.getClass().getName(), "Chỉnh sửa hồ sơ user(Profile)", 1);
            log.insert(ConnectDB.getConnect());
            saveSession(user, req);
            user.setPassWord(null);
            res.getWriter().write(new Gson().toJson(user));
            return;
        }
        res.getWriter().write(-1);


    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        res.setContentType("text/html;charset=UTF-8");
        req.setCharacterEncoding("utf-8");
        String action = req.getParameter("action");
        User user = (User) req.getSession().getAttribute("user");

        if (action != null && action.equals("info")) {
            try {
                User userReq = UserDAO.getInfoByUserName(user.getUserName());
                res.getWriter().println(new Gson().toJson(userReq));
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            return;
        }
        if (user != null) {
            req.setAttribute("userInfo", user);
            req.setAttribute("statusLogin", user);
            req.getRequestDispatcher("/Page/Profile.jsp").forward(req, res);
        } else {
            res.setStatus(200);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        res.setContentType("text/html;charset=UTF-8");
        req.setCharacterEncoding("utf-8");
        User user = (User) req.getSession().getAttribute("user");
        String action = req.getParameter("action");
        if (action != null && action.equals("changeProfile")) {
            try {
                changleUser(req, res);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            } catch (ClassNotFoundException e) {
                throw new RuntimeException(e);
            }
            return;
        }
        if (action != null && action.equals("changeProfileCart")) {
            try {
                changeProfileCart(req, res);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }

            return;
        }
        if (action != null && action.equals("changeAvatar")) {
            try {
                changeAvatar(req, res, user.getUserName(),user);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }


    }

    public void saveSession(User user, HttpServletRequest req) {
        req.getSession().setAttribute("user", user);
    }
}
