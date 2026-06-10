package com.sistema.config;
import java.sql.*;

public class Conexion {
    public static Connection getConexion() {
        Connection cn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            // PEGA AQUÍ TUS CREDENCIALES REALES DE RAILWAY (De la pestaña Connect)
            String host = "acela.proxy.rlwy.net";
            String puerto = "46275";
            String db = "railway";
            String user = "root";
            String pass = "tlqEBVkVwzSbDFTWcaUjNwmVgUJMKBgy"; String url = "jdbc:mysql://" + host + ":" + puerto + "/" + db + "?useSSL=false&serverTimezone=UTC";

            cn = DriverManager.getConnection(url, user, pass);

            // AUTOMATIZACIÓN: Java creará la tabla si no existe en la nube
            try (Statement st = cn.createStatement()) {
                st.executeUpdate("CREATE TABLE IF NOT EXISTS Usuario (" +
                        "ItemAi INT AUTO_INCREMENT PRIMARY KEY, " +
                        "IdUsuario INT UNIQUE, " +
                        "CodUsuario VARCHAR(20) UNIQUE, " +
                        "Usuario VARCHAR(50) NOT NULL UNIQUE, " +
                        "Password VARCHAR(100) NOT NULL, " +
                        "Nombres VARCHAR(100), " +
                        "Apellidos VARCHAR(100), " +
                        "Email VARCHAR(100), " +
                        "Permisos VARCHAR(30), " +
                        "Estado VARCHAR(20) DEFAULT 'Activo', " +
                        "Enlinea INT DEFAULT 0, " +
                        "Num_Ingresos INT DEFAULT 0, " +
                        "Fec_Creacion DATE, " +
                        "Hora_Creacion TIME, " +
                        "Fec_UltimoAcceso DATE, " +
                        "Hora_UltimoAcceso TIME, " +
                        "Ip_Conexion VARCHAR(45), " +
                        "Ciudad_Conexion VARCHAR(50)" +
                        ")");
                // Si la tabla está vacía, insertamos el usuario administrador de prueba automáticamente
                ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM Usuario WHERE Usuario = 'admin'");
                if (rs.next() && rs.getInt(1) == 0) {
                    st.executeUpdate("INSERT INTO Usuario (IdUsuario, Usuario, Password, Nombres, Permisos, Estado, Fec_Creacion, Hora_Creacion) " +
                            "VALUES (100000001, 'admin', 'admin123', 'Maricielo', 'Administrador', 'Activo', CURDATE(), CURTIME())");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return cn;
    }
}