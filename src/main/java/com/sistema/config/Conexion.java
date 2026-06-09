package com.sistema.config;
import java.sql.*;

public class Conexion {
    public static Connection getConexion() {
        Connection cn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            // PEGA AQUÍ LOS DATOS QUE COPIASTE DE LA PESTAÑA "CONNECT"
            String host = "mysql.railway.internal";
            String puerto = "3306";
            String db = "railway";
            String user = "root";
            String pass = "tlqEBVkVwzSbDFTWcaUjNwmVgUJMKBgy";

            String url = "jdbc:mysql://" + host + ":" + puerto + "/" + db + "?useSSL=false&serverTimezone=UTC";
            cn = DriverManager.getConnection(url, user, pass);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return cn;
    }
}