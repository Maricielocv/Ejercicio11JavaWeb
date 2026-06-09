package com.sistema.config;
import java.sql.*;

public class Conexion {
    public static Connection getConexion() {
        Connection cn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            // PEGA AQUÍ TUS CREDENCIALES REALES DE RAILWAY (De la pestaña Connect)
            String host = "mysql.railway.internal";     // Ejemplo: viaduct.proxy.rlwy.net
            String puerto = "3306"; // Tu número de puerto público
            String db = "railway";
            String user = "root";
            String pass = "tlqEBVkVwzSbDFTWcaUjNwmVgUJMKBgy"; // Tu contraseña larga

            String url = "jdbc:mysql://" + host + ":" + puerto + "/" + db + "?useSSL=false&serverTimezone=UTC";
            cn = DriverManager.getConnection(url, user, pass);

            // AUTOMATIZACIÓN: Java creará la tabla si no existe en la nube
            try (Statement st = cn.createStatement()) {
                st.executeUpdate("CREATE TABLE IF NOT EXISTS Usuario (" +
                        "ItemAi INT AUTO_INCREMENT PRIMARY KEY, " +
                        "IdUsuario INT UNIQUE, " +
                        "Usuario VARCHAR(50) NOT NULL UNIQUE, " +
                        "Password VARCHAR(100) NOT NULL, " +
                        "Nombres VARCHAR(100), " +
                        "Permisos VARCHAR(30), " +
                        "Estado VARCHAR(20) DEFAULT 'Activo')");

                // Si la tabla está vacía, insertamos el usuario administrador de prueba automáticamente
                ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM Usuario WHERE Usuario = 'admin'");
                if (rs.next() && rs.getInt(1) == 0) {
                    st.executeUpdate("INSERT INTO Usuario (IdUsuario, Usuario, Password, Nombres, Permisos) " +
                            "VALUES (100000001, 'admin', 'admin123', 'Maricielo', 'Administrador')");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return cn;
    }
}