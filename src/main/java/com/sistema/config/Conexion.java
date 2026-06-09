package com.sistema.config;
import java.sql.*;

public class Conexion {
    public static Connection getConexion() {
        Connection cn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Reemplaza esto con los datos reales de texto que veas en tu Railway:
            String host = "viaduct.proxy.rlwy.net"; // Reemplázalo si tu dominio público es otro
            String puerto = "TU_PUERTO_PÚBLICO";    // El número que venga en tu MYSQL_PUBLIC_URL
            String db = "railway";
            String user = "root";
            String pass = "";                       // Déjalo vacío si no te generó contraseña

            String url = "jdbc:mysql://" + host + ":" + puerto + "/" + db + "?useSSL=false&serverTimezone=UTC";
            cn = DriverManager.getConnection(url, user, pass);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return cn;
    }
}