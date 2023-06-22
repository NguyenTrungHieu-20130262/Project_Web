package Utils;

import java.sql.Connection;
import java.sql.SQLException;

public interface AbBean {
    public boolean insert(Connection connect) throws SQLException;
}
