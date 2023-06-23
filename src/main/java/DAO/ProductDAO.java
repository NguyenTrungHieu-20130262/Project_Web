package DAO;

import Connect.ConnectDB;
import DTO.ProductDTO;
import Model.Company;
import Model.ImgProduct;
import Model.ImportProduct;
import Model.Product;
import com.google.gson.Gson;
import org.springframework.ui.Model;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;

public class ProductDAO {
    //    int quantity;
    public static ArrayList<Product> getProducts() {
        ArrayList<Product> products = new ArrayList<>();
        String query = "SELECT product.*, sum(quantity) as quantity, vendo.name as nameVendo, vendo.srcImg, GROUP_CONCAT(imgproduct.srcImg) as imgUrls\n" +
                "FROM importproduct\n" +
                "JOIN product ON importproduct.idProduct = product.id\n" +
                "JOIN vendo ON product.idVendo = vendo.id\n" +
                "LEFT JOIN imgproduct ON product.id = imgproduct.idProduct\n" +
                "GROUP BY product.id, vendo.name, vendo.srcImg\n" +
                "\n";
        try {
            PreparedStatement preparedStatement = ConnectDB.getConnect().prepareStatement(query);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Company vendo = new Company(resultSet.getInt(2), resultSet.getString("nameVendo"), resultSet.getString("srcImg"));
                String[] imgUrls = resultSet.getString("imgUrls").split(",");
                ArrayList<String> list = new ArrayList<String>();

                for (String s : imgUrls) {
                    list.add(s);
                }

                ProductDTO prod = new ProductDTO(resultSet.getInt(1),
                        vendo,
                        resultSet.getString(3),
                        resultSet.getString(4),
                        resultSet.getString(5),
                        resultSet.getInt(6),
                        resultSet.getString(7),
                        resultSet.getDouble(8),
                        resultSet.getDate(9),
                        resultSet.getInt(14),
                        list
                );
                prod.setQuantity(resultSet.getInt("quantity"));
                products.add(prod);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return products;
    }
//    int quantity;


    public static ArrayList<Product> getProduct() {
        ArrayList<Product> products = new ArrayList<>();
        String query = "SELECT product.*, sum(quantity) as quantity, vendo.name as nameVendo, vendo.srcImg, GROUP_CONCAT(imgproduct.srcImg) as imgUrls\n" +
                "FROM importproduct\n" +
                "JOIN product ON importproduct.idProduct = product.id\n" +
                "JOIN vendo ON product.idVendo = vendo.id\n" +
                "LEFT JOIN imgproduct ON product.id = imgproduct.idProduct\n" +
                "GROUP BY product.id, vendo.name, vendo.srcImg\n" +
                "HAVING quantity > 0;\n";
        try {
            PreparedStatement preparedStatement = ConnectDB.getConnect().prepareStatement(query);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Company vendo = new Company(resultSet.getInt(2), resultSet.getString("nameVendo"), resultSet.getString("srcImg"));
                String[] imgUrls = resultSet.getString("imgUrls").split(",");
                ArrayList<String> list = new ArrayList<String>();

                for (String s : imgUrls) {
                    list.add(s);
                }

                ProductDTO prod = new ProductDTO(resultSet.getInt(1),
                        vendo,
                        resultSet.getString(3),
                        resultSet.getString(4),
                        resultSet.getString(5),
                        resultSet.getInt(6),
                        resultSet.getString(7),
                        resultSet.getDouble(8),
                        resultSet.getDate(9),
                        resultSet.getInt(14),
                        list
                );
                prod.setQuantity(resultSet.getInt("quantity"));
                products.add(prod);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return products;
    }

    public static int countProduct() {
        String query = "SELECT COUNT(*) AS count FROM product";
        try {
            Statement statement = ConnectDB.getConnect().createStatement();
            PreparedStatement preparedStatement = statement.getConnection().prepareStatement(query);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                return resultSet.getInt("count");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    public static ArrayList<Product> getProductsWithOffset(int offset, int RECORDS_PER_PAGE) {
        String query = "SELECT product.*, sum(quantity) as quantity, vendo.name as nameVendo, vendo.srcImg, GROUP_CONCAT(imgproduct.srcImg) as imgUrls\n" +
                "FROM importproduct\n" +
                "JOIN product ON importproduct.idProduct = product.id\n" +
                "JOIN vendo ON product.idVendo = vendo.id\n" +
                "LEFT JOIN imgproduct ON product.id = imgproduct.idProduct\n" +
                "GROUP BY product.id, vendo.name, vendo.srcImg\n" +
                "HAVING quantity > 0 LIMIT ?, ?";
        ArrayList<Product> products = new ArrayList<Product>();
        try {
            Statement statement = ConnectDB.getConnect().createStatement();
            PreparedStatement preparedStatement = statement.getConnection().prepareStatement(query);
            preparedStatement.setInt(1, offset);
            preparedStatement.setInt(2, RECORDS_PER_PAGE);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Company vendo = new Company(resultSet.getInt(2), resultSet.getString("nameVendo"), resultSet.getString("srcImg"));
                String[] imgUrls = resultSet.getString("imgUrls").split(",");
                ArrayList<String> list = new ArrayList<String>();

                for (String s : imgUrls) {
                    list.add(s);
                }

                ProductDTO prod = new ProductDTO(resultSet.getInt(1),
                        vendo,
                        resultSet.getString(3),
                        resultSet.getString(4),
                        resultSet.getString(5),
                        resultSet.getInt(6),
                        resultSet.getString(7),
                        resultSet.getDouble(8),
                        resultSet.getDate(9),
                        resultSet.getInt(14),
                        list
                );
                prod.setQuantity(resultSet.getInt("quantity"));
                products.add(prod);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return products;
    }

    public static ArrayList<Product> filterProduct(HttpServletRequest req) {
        String name = req.getParameter("name");
        String year = req.getParameter("year");
        String company = req.getParameter("company");
        String priceMin = req.getParameter("priceMin");
        String priceMax = req.getParameter("priceMax");
        String fuel = req.getParameter("fuel");

        String query = "SELECT product.*, sum(quantity) as quantity, vendo.name as nameVendo, vendo.srcImg, GROUP_CONCAT(imgproduct.srcImg) as imgUrls\n" +
                "FROM importproduct\n" +
                "JOIN product ON importproduct.idProduct = product.id\n" +
                "JOIN vendo ON product.idVendo = vendo.id\n" +
                "LEFT JOIN imgproduct ON product.id = imgproduct.idProduct\n" +
                "GROUP BY product.id, vendo.name, vendo.srcImg\n" +
                "HAVING quantity > 0 " +
                "&& product.name like '%" + name.trim() + "%'";
        if (!year.trim().equals("")) {
            query += "&& product.yearOfManuFacture = " + Integer.valueOf(year.trim());
        }
        if (!company.trim().equals("")) {
            query += "&& product.idVendo = " + Integer.valueOf(company.trim());
        }
        query += "&& product.price <= " + Integer.valueOf(priceMax.trim());
        query += "&& product.price >= " + Integer.valueOf(priceMin.trim());
        if (fuel.trim().equals("xang")) {
            query += "&& product.fuel = " + 1;
        }
        if (fuel.trim().equals("dien")) {
            query += "&& product.fuel = " + 2;
        }
        ArrayList<Product> products = new ArrayList<Product>();
        try {
            Statement statement = ConnectDB.getConnect().createStatement();
            PreparedStatement preparedStatement = statement.getConnection().prepareStatement(query);

            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Company vendo = new Company(resultSet.getInt(2), resultSet.getString("nameVendo"), resultSet.getString("srcImg"));
                String[] imgUrls = resultSet.getString("imgUrls").split(",");
                ArrayList<String> list = new ArrayList<String>();

                for (String s : imgUrls) {
                    list.add(s);
                }

                ProductDTO prod = new ProductDTO(resultSet.getInt(1),
                        vendo,
                        resultSet.getString(3),
                        resultSet.getString(4),
                        resultSet.getString(5),
                        resultSet.getInt(6),
                        resultSet.getString(7),
                        resultSet.getDouble(8),
                        resultSet.getDate(9),
                        resultSet.getInt(14),
                        list
                );
                prod.setQuantity(resultSet.getInt("quantity"));
                products.add(prod);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return products;
    }

    public static ArrayList<Product> filterProductAndPage(int offset, int RECORDS_PER_PAGE, HttpServletRequest req) {
        String name = req.getParameter("name");
        String year = req.getParameter("year");
        String company = req.getParameter("company");
        String priceMin = req.getParameter("priceMin");
        String priceMax = req.getParameter("priceMax");
        String fuel = req.getParameter("fuel");
        String query = "SELECT product.*, sum(quantity) as quantity, vendo.name as nameVendo, vendo.srcImg, GROUP_CONCAT(imgproduct.srcImg) as imgUrls\n" +
                "FROM importproduct\n" +
                "JOIN product ON importproduct.idProduct = product.id\n" +
                "JOIN vendo ON product.idVendo = vendo.id\n" +
                "LEFT JOIN imgproduct ON product.id = imgproduct.idProduct\n" +
                "GROUP BY product.id, vendo.name, vendo.srcImg\n" +
                "HAVING quantity > 0 " +
                "&& product.name like '%" + name.trim() + "%'";
        if (!year.trim().equals("")) {
            query += "&& product.yearOfManuFacture = " + Integer.valueOf(year.trim());
        }
        if (!company.trim().equals("")) {
            query += "&& product.idVendo = " + Integer.valueOf(company.trim());
        }
        query += "&& product.price <= " + Integer.valueOf(priceMax.trim());
        query += "&& product.price >= " + Integer.valueOf(priceMin.trim());
        if (fuel.trim().equals("xang")) {
            query += "&& product.fuel = " + 1;
        }
        if (fuel.trim().equals("dien")) {
            query += "&& product.fuel = " + 2;
        }
        query += " LIMIT ?, ?";
        ArrayList<Product> products = new ArrayList<Product>();
        try {
            Statement statement = ConnectDB.getConnect().createStatement();
            PreparedStatement preparedStatement = statement.getConnection().prepareStatement(query);
            preparedStatement.setInt(1, offset);
            preparedStatement.setInt(2, RECORDS_PER_PAGE);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Company vendo = new Company(resultSet.getInt(2), resultSet.getString("nameVendo"), resultSet.getString("srcImg"));
                String[] imgUrls = resultSet.getString("imgUrls").split(",");
                ArrayList<String> list = new ArrayList<String>();

                for (String s : imgUrls) {
                    list.add(s);
                }

                ProductDTO prod = new ProductDTO(resultSet.getInt(1),
                        vendo,
                        resultSet.getString(3),
                        resultSet.getString(4),
                        resultSet.getString(5),
                        resultSet.getInt(6),
                        resultSet.getString(7),
                        resultSet.getDouble(8),
                        resultSet.getDate(9),
                        resultSet.getInt(14),
                        list
                );
                prod.setQuantity(resultSet.getInt("quantity"));
                products.add(prod);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return products;
    }

    public static int countProductByFilter(HttpServletRequest req) {
        String name = req.getParameter("name");
        String year = req.getParameter("year");
        String company = req.getParameter("company");
        String priceMin = req.getParameter("priceMin");
        String priceMax = req.getParameter("priceMax");
        String fuel = req.getParameter("fuel");

        String query = "SELECT COUNT(*) as count FROM  product where  " +
                "product.name like '%" + name.trim() + "%' ";
        if (!year.trim().equals("")) {
            query += "&& product.yearOfManuFacture = " + Integer.valueOf(year.trim());
        }
        if (!company.trim().equals("")) {
            query += "&& product.idVendo = " + Integer.valueOf(company.trim());
        }
        query += "&& product.price <= " + Integer.valueOf(priceMax.trim());
        query += "&& product.price >= " + Integer.valueOf(priceMin.trim());
        if (fuel.trim().equals("xang")) {
            query += "&& product.fuel = " + 1;
        }
        if (fuel.trim().equals("dien")) {
            query += "&& product.fuel = " + 2;
        }
        System.out.println(query);
        ArrayList<Product> products = new ArrayList<Product>();
        try {
            Statement statement = ConnectDB.getConnect().createStatement();
            PreparedStatement preparedStatement = statement.getConnection().prepareStatement(query);

            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                return resultSet.getInt("count");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }


    public static ArrayList<Product> getProductAll() {
        ArrayList<Product> products = new ArrayList<>();
        String query = "SELECT product.*, sum(quantity) as quantity, vendo.name as nameVendo, vendo.srcImg, GROUP_CONCAT(imgproduct.srcImg) as imgUrls\n" +
                "FROM importproduct\n" +
                "JOIN product ON importproduct.idProduct = product.id\n" +
                "JOIN vendo ON product.idVendo = vendo.id\n" +
                "LEFT JOIN imgproduct ON product.id = imgproduct.idProduct\n" +
                "GROUP BY product.id, vendo.name, vendo.srcImg";
        try {
            Statement statement = ConnectDB.getConnect().createStatement();
            PreparedStatement preparedStatement = statement.getConnection().prepareStatement(query);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
//                int quantity = getQuantityByID(resultSet.getInt(1));
                Company vendo = new Company(resultSet.getInt(2), resultSet.getString("nameVendo"), resultSet.getString("srcImg"));
                String[] imgUrls = resultSet.getString("imgUrls").split(",");
                ArrayList<String> list = new ArrayList<String>();

                for (String s : imgUrls) {
                    list.add(s);
                }

                ProductDTO prod = new ProductDTO(resultSet.getInt(1),
                        vendo,
                        resultSet.getString(3),
                        resultSet.getString(4),
                        resultSet.getString(5),
                        resultSet.getInt(6),
                        resultSet.getString(7),
                        resultSet.getDouble(8),
                        resultSet.getDate(9),
                        resultSet.getInt(14),
                        list
                );
                prod.setQuantity(resultSet.getInt("quantity"));
                products.add(prod);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return products;
    }

    public static int getQuantityProductById(int id) {
        String query = "SELECT product.*, sum(quantity) as quantity FROM importproduct join product on importproduct.idProduct = product.id GROUP by product.id HAVING quantity > 0 AND id = ?";
        try {
            Statement statement = ConnectDB.getConnect().createStatement();
            PreparedStatement preparedStatement = statement.getConnection().prepareStatement(query);
            preparedStatement.setInt(1, id);

            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                return resultSet.getInt("quantity");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return -1;
    }

    public static ArrayList<Product> getNewProducts() {
        ArrayList<Product> newProducts = new ArrayList<>();
        String query = "SELECT product.*, sum(quantity) as quantity, vendo.name as nameVendo, vendo.srcImg, GROUP_CONCAT(imgproduct.srcImg) as imgUrls\n" +
                "FROM importproduct\n" +
                "JOIN product ON importproduct.idProduct = product.id\n" +
                "JOIN vendo ON product.idVendo = vendo.id\n" +
                "LEFT JOIN imgproduct ON product.id = imgproduct.idProduct\n" +
                "GROUP BY product.id, vendo.name, vendo.srcImg\n" +
                "ORDER BY product.yearOfManuFacture DESC LIMIT 12";
        try {
            Statement statement = ConnectDB.getConnect().createStatement();
            PreparedStatement preparedStatement = statement.getConnection().prepareStatement(query);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Company vendo = new Company(resultSet.getInt(2), resultSet.getString("nameVendo"), resultSet.getString("srcImg"));
                String[] imgUrls = resultSet.getString("imgUrls").split(",");
                ArrayList<String> list = new ArrayList<String>();

                for (String s : imgUrls) {
                    list.add(s);
                }

                ProductDTO prod = new ProductDTO(resultSet.getInt(1),
                        vendo,
                        resultSet.getString(3),
                        resultSet.getString(4),
                        resultSet.getString(5),
                        resultSet.getInt(6),
                        resultSet.getString(7),
                        resultSet.getDouble(8),
                        resultSet.getDate(9),
                        resultSet.getInt(14),
                        list
                );
                newProducts.add(prod);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return newProducts;
    }

    public static ArrayList<Product> getTrendProducts() {
        ArrayList<Product> trendProducts = new ArrayList<>();
        String query = "select  pp.id, pp.idVendo, pp.name, pp.content, pp.body, pp.yearOfManuFacture, pp.fuel, pp.price, pp.height, NOW() as createAt, pp.length, pp.width, pp.weight, pp.status, pp.quantity,  pp.srcImg, pp.imgUrls, nameVendo, COUNT(pp.id) as count from orderdetail join (SELECT product.*, sum(quantity) as quantity, vendo.name as nameVendo, vendo.srcImg, GROUP_CONCAT(imgproduct.srcImg) as imgUrls FROM importproduct JOIN product ON importproduct.idProduct = product.id JOIN vendo ON product.idVendo = vendo.id LEFT JOIN imgproduct ON product.id = imgproduct.idProduct  GROUP BY product.id, vendo.name, vendo.srcImg) as pp on pp.id = orderdetail.idProduct  GROUP BY pp.id, pp.idVendo, pp.name, pp.content, pp.body, pp.yearOfManuFacture, pp.fuel, pp.price, pp.height, pp.length, pp.width, pp.weight, pp.status, pp.quantity,  pp.srcImg, pp.imgUrls ORDER BY count DESC LIMIT 12;";
        try {
            Statement statement = ConnectDB.getConnect().createStatement();
            PreparedStatement preparedStatement = statement.getConnection().prepareStatement(query);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Company vendo = new Company(resultSet.getInt(2), resultSet.getString("nameVendo"), resultSet.getString("srcImg"));
                String[] imgUrls = resultSet.getString("imgUrls").split(",");
                ArrayList<String> list = new ArrayList<String>();

                for (String s : imgUrls) {
                    list.add(s);
                }

                ProductDTO prod = new ProductDTO(resultSet.getInt(1),
                        vendo,
                        resultSet.getString(3),
                        resultSet.getString(4),
                        resultSet.getString(5),
                        resultSet.getInt(6),
                        resultSet.getString(7),
                        resultSet.getDouble(8),
                        resultSet.getDate(9),
                        resultSet.getInt(14),
                        list
                );
                trendProducts.add(prod);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return trendProducts;
    }

    public static ArrayList<String> getImagesByID(int idProduct) {
        ArrayList<String> images = new ArrayList<>();
        String query = "SELECT srcImg FROM imgproduct where idProduct = ?";

        try {
            Statement statement = ConnectDB.getConnect().createStatement();
            PreparedStatement preparedStatement = statement.getConnection().prepareStatement(query);
            preparedStatement.setInt(1, idProduct);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                images.add(resultSet.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return images;
    }

//    public static ArrayList<String> getImportByID(int idProduct) {
//        ArrayList<String> imports = new ArrayList<>();
//        String query = "SELECT importproduct.quantity FROM importproduct where idProduct = ?";
//
//        try {
//            Statement statement = ConnectDB.getConnect().createStatement();
//            PreparedStatement preparedStatement = statement.getConnection().prepareStatement(query);
//            preparedStatement.setInt(1, idProduct);
//            ResultSet resultSet = preparedStatement.executeQuery();
//            while (resultSet.next()) {
//                imports.add(resultSet.getInt(1));
//            }
//        } catch (SQLException e) {
//            throw new RuntimeException(e);
//        }
//        return imports;
//    }


    public static ArrayList<Product> getProductOut() {
        ArrayList<Product> posts = new ArrayList<>();
        String query = "SELECT p.*, COALESCE(ip.quantity, 0) - COALESCE(od.quantity, 0) AS quantity_on_hand FROM product p LEFT JOIN orderdetail od ON p.id = od.idProduct LEFT JOIN importproduct ip ON p.id = ip.idProduct WHERE COALESCE(ip.quantity, 0) - COALESCE(od.quantity, 0) <= 0;;";
        try {
            Statement statement = ConnectDB.getConnect().createStatement();
            PreparedStatement preparedStatement = statement.getConnection().prepareStatement(query);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Company vendo = CompanyDAO.getVendoById(resultSet.getInt(2));
                posts.add(new Product(resultSet.getInt(1),
                        vendo,
                        resultSet.getString(3),
                        resultSet.getString(4),
                        resultSet.getString(5),
                        resultSet.getInt(6),
                        resultSet.getString(7),
                        resultSet.getDouble(8),
                        resultSet.getDate(9),
                        resultSet.getInt(10),
                        getImagesByID(resultSet.getInt(1))
                ));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return posts;
    }

    public static int newImgProduct(ImgProduct tmp) {
        int resultSet = 0;
        for (String img : tmp.getArr()) {
            String query = "INSERT INTO imgproduct(idproduct,srcImg, status) VALUES (?,?,?); ";
            try {
                PreparedStatement stmt = ConnectDB.getConnect().prepareStatement(query);
                stmt.setInt(1, tmp.getIdProduct());
                stmt.setString(2, img);
                stmt.setInt(3, tmp.getStatus());
                resultSet = stmt.executeUpdate();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        return resultSet;
    }


    public static Product getProductById(int id) {
        System.out.println("ID Post ================ " + id);
        Product product = null;
        String query = "SELECT p.*, COALESCE(ip.quantity, 0) - COALESCE(od.quantity, 0) AS quantity_on_hand FROM product p LEFT JOIN orderdetail od ON p.id = od.idProduct LEFT JOIN importproduct ip ON p.id = ip.idProduct WHERE p.id=?";
        try {
            Statement statement = ConnectDB.getConnect().createStatement();
            PreparedStatement preparedStatement = statement.getConnection().prepareStatement(query);
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Company vendo = CompanyDAO.getVendoById(resultSet.getInt(2));
                product = new Product(resultSet.getInt(1),
                        vendo,
                        resultSet.getString(3),
                        resultSet.getString(4),
                        resultSet.getString(5),
                        resultSet.getInt(6),
                        resultSet.getString(7),
                        resultSet.getDouble(8),
                        resultSet.getDate(9),
                        resultSet.getInt(14),
                        getImagesByID(resultSet.getInt(1))
                );
                product.setHeight(resultSet.getInt("height"));
                product.setWidth(resultSet.getInt("width"));
                product.setLength(resultSet.getInt("length"));
                product.setWeight(resultSet.getInt("weight"));

            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return product;
    }

    public void getProductByID(int id) {

    }

    public static int getQuantityProduct(int idProduct) throws SQLException {
        Connection c = ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("SELECT (SELECT  SUM(orderdetail.quantity) FROM (`order` JOIN orderdetail on `order`.id = orderdetail.idOrder) WHERE orderdetail.idProduct = ? ) as SLB, (SELECT  SUM(importproduct.quantity) FROM importproduct WHERE importproduct.idProduct = ?) AS SLN");
        stmt.setInt(1, idProduct);
        stmt.setInt(2, idProduct);
        ResultSet resultSet = stmt.executeQuery();
        int rs = 0;
        while (resultSet.next()) {
            rs = resultSet.getInt(2) - resultSet.getInt(1);

        }
        return rs;
    }

    public static int deleteProduct(int idPost) throws SQLException {
        Statement statement = ConnectDB.getConnect().createStatement();
        String q1 = "SET FOREIGN_KEY_CHECKS=0";
        PreparedStatement preparedStatement = statement.getConnection().prepareStatement(q1);
        preparedStatement.executeUpdate();
        String query = "DELETE FROM `product` WHERE id=? ";
        preparedStatement = statement.getConnection().prepareStatement(query);
        preparedStatement.setInt(1, idPost);
        int resultSet = preparedStatement.executeUpdate();
        String q2 = "SET FOREIGN_KEY_CHECKS=1";
        preparedStatement = statement.getConnection().prepareStatement(q1);
        preparedStatement.executeUpdate();
        return resultSet;
    }

    public static float getPriceRevenue() throws SQLException {
        float count = 0;
        Connection c = ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("SELECT DISTINCT idProduct FROM importproduct; ");
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            int id = rs.getInt("idProduct");
            int quantity = getQuantityProduct(id);
            if (quantity == 0) {
                count++;
            }

        }
        return count;
    }

    public static int getCountPOut() throws SQLException {
        int count = 0;
        Connection c = ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("SELECT DISTINCT idProduct FROM importproduct;");
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            int id = rs.getInt("idProduct");
            int quantity = getQuantityProduct(id);
            if (quantity == 0) {
                count++;
            }
        }
        return count;
    }

    public static int insertProduct(int idUser, Product pro, int quantity) {
        String query = "INSERT INTO product(idVendo,name,content,body,yearOfManuFacture,fuel,price,height, length, width, weight,status) VALUES (?,?,?,?,?,?,?,?,?,?,?,?); ";
        int productId = -1;
        int resultSet = 0;
        try {
            PreparedStatement stmt = ConnectDB.getConnect().prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, pro.getVendo().getId());
            stmt.setString(2, pro.getName());
            stmt.setString(3, pro.getContent());
            stmt.setString(4, pro.getBody());
            stmt.setInt(5, pro.getYearOfManuFacture());
            stmt.setString(6, pro.getFuel());
            stmt.setDouble(7, pro.getPrice());
            stmt.setInt(8, pro.getHeight());
            stmt.setInt(9, pro.getLength());
            stmt.setInt(10, pro.getWidth());
            stmt.setInt(11, pro.getWeight());
            stmt.setInt(12, 1);
            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                ResultSet generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    productId = generatedKeys.getInt(1);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        ImgProduct imgProduct = new ImgProduct(productId, pro.getImages(), 1);
        newImgProduct(imgProduct);
        newImportProduct(new ImportProduct(idUser, productId, quantity, 1));
        return resultSet;
    }

    public static void newImportProduct(ImportProduct importProduct) {
        String query = "INSERT INTO importproduct(idUser,idProduct,quantity,status) VALUES (?,?,?,?); ";
        try {
            PreparedStatement stmt = ConnectDB.getConnect().prepareStatement(query);
            stmt.setInt(1, importProduct.getIdUser());
            stmt.setInt(2, importProduct.getIdProduct());
            stmt.setInt(3, importProduct.getQuantity());
            stmt.setInt(4, importProduct.getStatus());
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public static int getCountProduct() throws SQLException {
        return getProduct().size();
    }

    public static int updateProduct(int idpost, String title, String content, String body, String made, int gear, int idCompany, int year, int status, String fuel, float price, int quantity) throws SQLException {
        String q1 = "SET FOREIGN_KEY_CHECKS=0";
        PreparedStatement stmt = ConnectDB.getConnect().prepareStatement(q1);
        stmt.executeUpdate();
        String query = "UPDATE product set title =?,content=?,body=?,made=?,gear =?,idCompany=?,yearofmanufacture=?,status=?,fuel=?,price=?,quantity=? where idpost = ? ";
        try {
            stmt = ConnectDB.getConnect().prepareStatement(query);
            stmt.setString(1, title);
            stmt.setString(2, content);
            stmt.setString(3, body);
            stmt.setString(4, made);
            stmt.setInt(5, gear);
            stmt.setInt(6, idCompany);
            stmt.setInt(7, year);
            stmt.setInt(8, status);
            stmt.setString(9, fuel);
            stmt.setFloat(10, price);
            stmt.setInt(11, quantity);
            stmt.setInt(12, idpost);

            int resultSet = stmt.executeUpdate();
            String q2 = "SET FOREIGN_KEY_CHECKS=1";
            stmt = ConnectDB.getConnect().prepareStatement(q2);
            stmt.executeUpdate();
            return resultSet;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static int updateQuantity(int id, int quantity) throws SQLException {
        String query = "UPDATE importproduct set quantity = ? where idProduct = ?  ";
        PreparedStatement stmt = ConnectDB.getConnect().prepareStatement(query);
        stmt.setInt(1,quantity);
        stmt.setInt(2,id);
       return  stmt.executeUpdate();

    }
    public static int updateProductAdmin(int idpost, String title, String content, String body, int idCompany, int year, String fuel, float price, int quantity,int height,int length,int width,int weight) throws SQLException {
        String query = "UPDATE product set name =?,content=?,body=?,idVendo=?,yearofmanufacture=?,fuel=?,price=?,height=?,length=?,width=?,weight=? where id = ? ";
        PreparedStatement stmt = ConnectDB.getConnect().prepareStatement(query);
        try {
            stmt.setString(1, title);
            stmt.setString(2, content);
            stmt.setString(3, body);
            stmt.setInt(4, idCompany);
            stmt.setInt(5, year);
            stmt.setString(6, fuel);
            stmt.setFloat(7, price);
            stmt.setInt(8, height);
            stmt.setInt(9, length);
            stmt.setInt(10, width);
            stmt.setInt(11, weight);
            stmt.setInt(12, idpost);

            int resultSet = stmt.executeUpdate();
            ProductDAO.updateQuantity(idpost, quantity/4);

            return resultSet;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public static void main(String[] args) {
//        System.out.println(productDAO.getNewProducts());
//        System.out.println(productDAO.getProductByVendo("BMW"));
    }
}




