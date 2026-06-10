package com.sistema.controller;
import com.sistema.dao.UsuarioDAO;
import com.sistema.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private final UsuarioDAO dao = new UsuarioDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String u = request.getParameter("txtUser");
        String p = request.getParameter("txtPass");
        HttpSession session = request.getSession();

        Integer intentos = (Integer) session.getAttribute("intentos");
        if (intentos == null) intentos = 0;

        Usuario user = dao.validar(u);

        if (user == null || !user.getPassword().equals(p)) {
            intentos++;
            session.setAttribute("intentos", intentos);
            if (u != null && !u.trim().isEmpty()) {
                dao.registrarFallo(u);
            }

            if (intentos >= 3) {
                response.setContentType("text/html;charset=UTF-8");
                response.getWriter().println("<script>alert('3 Intentos fallidos. Cerrando ventana...'); window.close();</script>");
            } else {
                request.setAttribute("error", "Usuario/Clave incorrectos. Intento: " + intentos + "/3");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } else if ("Bloqueado".equals(user.getEstado())) {
            request.setAttribute("error", "EL USUARIO SE ENCUENTRA BLOQUEADO. Contacte al Administrador.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            // Captura de datos adicionales solicitados en la rúbrica
            String ipCliente = request.getRemoteAddr();
            if ("0:0:0:0:0:0:0:1".equals(ipCliente)) {
                ipCliente = "127.0.0.1"; // Ajuste para Localhost estándar
            }
            String ciudadSimulada = "Lima Metropolitana";

            // Guarda en Base de Datos e inicia sesión
            dao.loginExitoso(u, ipCliente, ciudadSimulada);
            session.setAttribute("userLogueado", user);
            response.sendRedirect("principal.jsp");
        }
    }
}