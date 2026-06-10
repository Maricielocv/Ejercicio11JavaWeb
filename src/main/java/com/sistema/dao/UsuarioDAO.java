package com.sistema.dao;
import com.sistema.config.Conexion;
import com.sistema.model.Usuario;
import java.sql.*;

public class UsuarioDAO {

    public Usuario validar(String user) {
        Usuario u = null;
        String sql = "SELECT * FROM Usuario WHERE Usuario=?";
        try (Connection cn = Conexion.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, user);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    u = new Usuario();
                    u.setUsuario(rs.getString("Usuario"));
                    u.setPassword(rs.getString("Password"));
                    u.setPermisos(rs.getString("Permisos"));
                    u.setEstado(rs.getString("Estado"));
                    u.setNombres(rs.getString("Nombres"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return u;
    }

    public void registrarFallo(String user) {
        // Incrementa los intentos fallidos
        String sqlUpdate = "UPDATE Usuario SET Num_Ingresos = Num_Ingresos + 1 WHERE Usuario=?";
        // Si llega a 3 fallos, bloquea y guarda fecha/hora de la modificación (auditoría)
        String sqlBlock = "UPDATE Usuario SET Estado='Bloqueado', Fec_Modificacion=CURDATE(), Hora_Modificacion=CURTIME(), Modificado_Por='Sistema' WHERE Usuario=? AND Num_Ingresos>=3";

        try (Connection cn = Conexion.getConexion()) {
            try (PreparedStatement ps1 = cn.prepareStatement(sqlUpdate)) {
                ps1.setString(1, user);
                ps1.executeUpdate();
            }
            try (PreparedStatement ps2 = cn.prepareStatement(sqlBlock)) {
                ps2.setString(1, user);
                ps2.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public boolean insertarUsuario(String user, String pass, String nombres, String permisos) {
        String sql = "INSERT INTO Usuario (Usuario, Password, Nombres, Permisos, Estado, Fec_Creacion, Hora_Creacion) VALUES (?, ?, ?, ?, 'Activo', CURDATE(), CURTIME())";
        try (Connection cn = com.sistema.config.Conexion.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, user);
            ps.setString(2, pass);
            ps.setString(3, nombres);
            ps.setString(4, permisos);
            int filas = ps.executeUpdate();
            return filas > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public void loginExitoso(String user, String ip, String ciudad) {
        // Resetea intentos, pone Enlinea en 1 y actualiza TODOS los campos de auditoría de acceso requeridos
        String sql = "UPDATE Usuario SET Enlinea=1, Num_Ingresos=0, " +
                "Fec_UltimoAcceso=CURDATE(), Hora_UltimoAcceso=CURTIME(), " +
                "Ip_Conexion=?, Ciudad_Conexion=? WHERE Usuario=?";
        try (Connection cn = Conexion.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, ip);
            ps.setString(2, ciudad);
            ps.setString(3, user);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void cerrarSesion(String user) {
        // Vuelve el estado de sesión a inactivo (0)
        String sql = "UPDATE Usuario SET Enlinea=0 WHERE Usuario=?";
        try (Connection cn = Conexion.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, user);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}