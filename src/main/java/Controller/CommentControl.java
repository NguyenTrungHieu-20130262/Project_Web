package Controller;

import Beans.JWT;
import Connect.ConnectDB;
import DAO.CommentDAO;
import Model.Comment;
import Model.Log;
import Model.RespJsonServlet;
import Model.User;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet("/postComment")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 50, // 2MB
        maxFileSize = 1024 * 1024 * 50,      // 50MB
        maxRequestSize = 1024 * 1024 * 100)  // 100MB
public class CommentControl extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        List<Comment> cmts = null;
        User user = (User) req.getSession().getAttribute("user");
        if (id != null) {
            try {
                cmts = (List<Comment>) CommentDAO.getListComment(Integer.valueOf(id));
                resp.getWriter().write(new Gson().toJson(cmts));
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String content = URLDecoder.decode(req.getParameter("content"), "UTF-8");
        resp.setContentType("application/json");
        User user = (User) req.getSession().getAttribute("user");
        int idPost = Integer.valueOf(req.getParameter("idPost"));
        int star = Integer.valueOf(req.getParameter("star"));
        if (user != null) {
            String token = JWT.createJWT(String.valueOf(user.getId()), 365);
            Map<String, ArrayList<String>> map = this.uploadFileVideo(req, token, getServletContext().getRealPath("/"));
            Comment comment = new Comment(idPost, user.getId(), star, 1);
            comment.setAvatar(user.getAvatar());
            try {
                if ((CommentDAO.insertComment(comment, content, map.get("listImg"), map.get("listVideo")) != 0)) {
                    resp.getWriter().println(new RespJsonServlet("ok").json());
                    Log log = new Log(Log.ALERT, user.getId(), this.getClass().getName(),"Thêm comment(Detail_Product)", 1);
                    log.insert(ConnectDB.getConnect());
                    resp.setStatus(200);
                } else {
                    resp.getWriter().println(new RespJsonServlet("not ok").json());
                    resp.setStatus(400);
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        } else {
            resp.getWriter().println(new RespJsonServlet("no user").json());
            resp.setStatus(200);
        }

    }

    public Map<String, ArrayList<String>> uploadFileVideo(HttpServletRequest req, String token, String realPath) throws ServletException, IOException {
        int countImage = 0;
        int countVideo = 0;
        Map<String, ArrayList<String>> map = new HashMap<>();
        map.put("listImg", new ArrayList<>());
        map.put("listVideo", new ArrayList<>());
        List<Part> filePartsImage = req.getParts().stream().filter(part -> "fileImage".equals(part.getName())).collect(Collectors.toList());
        List<Part> filePartsVideo = req.getParts().stream().filter(part -> "fileVideo".equals(part.getName())).collect(Collectors.toList());
        for (Part filePart : filePartsImage) {
            String fileName = filePart.getSubmittedFileName();
            if (fileName == null) {
                continue;
            }
            String newFileName = "image" + token + countImage + "_" + fileName;
            Path filePath = Paths.get(realPath, "Img/Comment", newFileName);
            Files.copy(filePart.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
            map.get("listImg").add("Img/Comment/" + newFileName);
            countImage++;
        }
        for (Part filePart : filePartsVideo) {
            String fileName = filePart.getSubmittedFileName();
            if (fileName == null) {
                continue;
            }
            String newFileName = "video" + token + countVideo + "_" + fileName;
            Path filePath = Paths.get(realPath, "Img/Comment", newFileName);
            Files.copy(filePart.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
            map.get("listVideo").add("Img/Comment/" + newFileName);
            countVideo++;
        }
        return map;
    }

}
