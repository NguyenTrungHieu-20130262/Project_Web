package Connect;

    import com.zaxxer.hikari.HikariConfig;
    import com.zaxxer.hikari.HikariDataSource;

    import java.sql.*;

    public class ConnectDB {
        private static HikariDataSource dataSource = null;
        private String url = "jdbc:mysql://localhost:3306/qlyoto";
        private String user = "root";
        private String pass = "";
        private static Connection connection;

        private ConnectDB() {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
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

    }

