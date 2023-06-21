package Connect;

import DAO.ProductDAO;
import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import java.sql.*;
import java.util.Date;
import java.util.concurrent.TimeUnit;

public class ConnectDB {
    private static HikariDataSource dataSource = null;
    private static String url = "jdbc:mysql://localhost:3306/qlyoto";
    private static String user = "root";
    private static String pass = "";
    private static Connection connection;

    private ConnectDB() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            HikariConfig config = new HikariConfig();
            config.setJdbcUrl(url);
            config.setUsername(user);
            config.setPassword(pass);
            config.addDataSourceProperty("minimumIdle", "5");
            config.addDataSourceProperty("maximumPoolSize", "25");
            config.addDataSourceProperty("idleTimeout", "0");
            dataSource = new HikariDataSource(config);
            connection = dataSource.getConnection();
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public static Connection getConnect() {
        if (connection == null){
            new ConnectDB();
        }
        return connection;
    }

        public static void main(String[] args) throws SQLException {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                HikariConfig config = new HikariConfig();
                config.setJdbcUrl(url);
                config.setUsername(user);
                config.setPassword(pass);
                config.addDataSourceProperty("minimumIdle", "5");
                config.addDataSourceProperty("maximumPoolSize", "25");
                config.addDataSourceProperty("idleTimeout", "0");
                dataSource = new HikariDataSource(config);
                connection = dataSource.getConnection();
            } catch (ClassNotFoundException | SQLException e) {
                throw new RuntimeException(e);
            }



        }

    }

