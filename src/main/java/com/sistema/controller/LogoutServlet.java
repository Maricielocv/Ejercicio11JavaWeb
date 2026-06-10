package com.sistema.controller;
import com.sistema.dao.UsuarioDAO;
import com.sistema.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            Usuario user = (Usuario) session.getAttribute("userLogueado");
            if (user != null) {
                UsuarioDAO dao = new UsuarioDAO();
                dao.cerrarSesion(user.getUsuario());
            }
            session.invalidate();
        }
        response.sendRedirect("login.jsp");
    }
}
