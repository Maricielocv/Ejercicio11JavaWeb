package com.sistema.controller;
import com.sistema.dao.UsuarioDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/UsuarioServlet")
public class UsuarioServlet extends HttpServlet {
    private final UsuarioDAO dao = new UsuarioDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");

        if ("guardar".equals(accion)) {
            String u = request.getParameter("txtNewUser");
            String p = request.getParameter("txtNewPass");
            String n = request.getParameter("txtNewName");
            String per = request.getParameter("txtNewPermiso");

            boolean insertado = dao.insertarUsuario(u, p, n, per);

            if (insertado) {
                request.setAttribute("msg", "¡Usuario @" + u + " registrado con éxito en la base de datos! ✨");
            } else {
                request.setAttribute("msg", "Error: El nombre de usuario ya existe.");
            }
            request.getRequestDispatcher("mantenimiento.jsp").forward(request, response);
        }
    }
}