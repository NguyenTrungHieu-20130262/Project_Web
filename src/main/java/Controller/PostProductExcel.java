package Controller;

import DAO.CompanyDAO;
import DAO.ProductDAO;
import Model.Company;
import Model.Product;
import Model.RespJsonServlet;
import Model.User;
import Security.Authorizeds;
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
import java.util.stream.Collectors;

@MultipartConfig
@WebServlet("/postProductExcel")
public class PostProductExcel extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            try {
                String fieldsJson = req.getParameter("fields");
                ObjectMapper objectMapper = new ObjectMapper();
                JsonNode fieldsNode = objectMapper.readTree(fieldsJson);
                List<Part> filePartsImage = req.getParts().stream().filter(part -> "file_0_0".equals(part.getName())).collect(Collectors.toList());
                System.out.println(789);
                System.out.println(filePartsImage);

                saveFile(filePartsImage,getServletContext().getRealPath("/"));
                User user = (User) req.getSession().getAttribute("user");
//                for (JsonNode tmp : fieldsNode) {;
//                    ArrayList<String> list = objectMapper.convertValue(tmp.get("O"), ArrayList.class);
//                    ArrayList<String> listImgUploaded = (ArrayList<String>) uploadFileVideo(req, list, getServletContext().getRealPath("/"));
//                    System.out.println(918);
//                    System.out.println(listImgUploaded);
//                    String title = tmp.get("M").asText();
//                    String content = tmp.get("N").asText();
//                    Company idCompany = null;
//                    try {
//                        idCompany = CompanyDAO.getIdByName(tmp.get("A").asText());
//                    } catch (SQLException e) {
//                        throw new RuntimeException(e);
//                    }
//                    int year = Integer.valueOf(tmp.get("B").asText());
//                    String fuel = tmp.get("H").asText();
//                    Float price = Float.parseFloat(tmp.get("J").asText());
//                    String body = tmp.get("L").asText();
//                    int quantity = Integer.parseInt(tmp.get("K").asText());
//                    int height = Integer.parseInt(tmp.get("C").asText());
//                    int length = Integer.parseInt(tmp.get("D").asText());
//                    int width = Integer.parseInt(tmp.get("E").asText());
//                    int weight = Integer.parseInt(tmp.get("F").asText());
//                    Product pro = new Product(0, idCompany, title, content, body, year, fuel, price, null, listImgUploaded, height, length, width, weight);
//                    ProductDAO.insertProduct(user.getId(), pro, quantity);
//                }
                resp.getWriter().println(new RespJsonServlet("oke").json());
                resp.setStatus(200);
            }catch (Exception e){
                resp.sendError(401);
            }

    }
    public void saveFile(List<Part> filePartsVideo,String realPath) throws IOException {
        int countImage = 0;
        List<String> uploadedFiles = new ArrayList<>();
        for (Part filePart : filePartsVideo) {
            String fileName = filePart.getSubmittedFileName();
            if (fileName == null) {
                continue;
            }
            UUID uuid = UUID.randomUUID();
             ;
            String newFileName = "image" +countImage + "_" + fileName+uuid.toString();
            Path filePath = Paths.get(realPath, "Img/Product", newFileName);
            Files.copy(filePart.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
            uploadedFiles.add("Img/Comment/" + newFileName);
            countImage++;
        }
    }

    public List<String> uploadFileVideo(HttpServletRequest req, ArrayList<String> imagePaths, String realPath) throws ServletException, IOException {
        List<String> uploadedFiles = new ArrayList<>();
        for (String imagePath : imagePaths) {
            // Generate a unique file name
            String fileName = UUID.randomUUID().toString() + "-" + getFileNameFromPath(imagePath);

            // Specify the directory to save the uploaded file
            String uploadDir = realPath + "Img/Product";
            String dirSave="Img/Product/"+fileName;
            String filePath = uploadDir + File.separator + fileName;

            // Copy the file from the source path to the destination directory
            copyFile(imagePath, filePath);

            uploadedFiles.add(dirSave);
        }

        return uploadedFiles;
    }

    private String getFileNameFromPath(String path) {
        int lastSeparatorIndex = path.lastIndexOf(File.separator);
        return path.substring(lastSeparatorIndex + 1);
    }

    private void copyFile(String sourcePath, String destinationPath) throws IOException {
        Path source = Path.of(sourcePath);
        Path destination = Path.of(destinationPath);
        Files.copy(source, destination, StandardCopyOption.REPLACE_EXISTING);
    }
}
