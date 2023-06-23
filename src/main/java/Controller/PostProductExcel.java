package Controller;

import DAO.CompanyDAO;
import DAO.ProductDAO;
import Model.Company;
import Model.Product;
import Model.RespJsonServlet;
import Model.User;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@MultipartConfig
@WebServlet("/postProductExcel")
public class PostProductExcel extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        try {
            String fieldsJson = req.getParameter("fields");
            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode fieldsNode = objectMapper.readTree(fieldsJson);
            User user = (User) req.getSession().getAttribute("user");
            for (JsonNode tmp : fieldsNode) {
                ;
                ArrayList<String> list = objectMapper.convertValue(tmp.get("O"), ArrayList.class);
                String title = tmp.get("M").asText();
                String content = tmp.get("N").asText();
                Company idCompany = null;
                try {
                    idCompany = CompanyDAO.getIdByName(tmp.get("A").asText());
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                int year = Integer.valueOf(tmp.get("B").asText());
                String fuel = tmp.get("H").asText();
                Float price = Float.parseFloat(tmp.get("J").asText());
                String body = tmp.get("L").asText();
                int quantity = Integer.parseInt(tmp.get("K").asText());
                int height = Integer.parseInt(tmp.get("C").asText());
                int length = Integer.parseInt(tmp.get("D").asText());
                int width = Integer.parseInt(tmp.get("E").asText());
                int weight = Integer.parseInt(tmp.get("F").asText());
                Product pro = new Product(0, idCompany, title, content, body, year, fuel, price, null, list, height, length, width, weight);
                ProductDAO.insertProduct(user.getId(), pro, quantity);
            }
            resp.getWriter().println(new RespJsonServlet("oke").json());
            resp.setStatus(200);
        } catch (Exception e) {
            resp.sendError(401);
        }

    }

}
