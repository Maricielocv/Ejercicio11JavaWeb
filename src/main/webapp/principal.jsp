<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.sistema.model.Usuario" %>
<%
    Usuario user = (Usuario) session.getAttribute("userLogueado");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Study Space - Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #faf7f2;
            color: #4a4a4a;
            font-family: 'Plus Jakarta Sans', 'Segoe UI', sans-serif;
            min-height: 100vh;
        }
        .navbar-aesthetic {
            background-color: #ffffff;
            border-bottom: 1px solid #f0eae1;
        }
        .main-card {
            background: #ffffff;
            border: 1px solid #f0eae1;
            border-radius: 20px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.02);
        }
        .btn-outline-pink {
            color: #db2777;
            border: 1px solid #fbc5d8;
            border-radius: 12px;
            font-weight: 500;
        }
        .btn-outline-pink:hover {
            background-color: #fff1f5;
            border-color: #db2777;
        }
        .btn-danger-soft {
            background-color: #fff1f2;
            color: #e11d48;
            border: none;
            border-radius: 12px;
            font-weight: 500;
        }
        .btn-danger-soft:hover {
            background-color: #ffe4e6;
        }
        .badge-online {
            background-color: #f0fdf4;
            color: #16a34a;
            border: 1px solid #bbf7d0;
            border-radius: 30px;
            padding: 6px 16px;
            font-size: 0.85rem;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        .dot {
            width: 8px;
            height: 8px;
            background-color: #16a34a;
            border-radius: 50%;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-aesthetic py-3">
    <div class="container">
        <span class="navbar-brand fw-bold m-0" style="color: #db2777;"> bienvenido, <span style="color: #4a4a4a;"><%= user.getNombres() %></span></span>
        <div class="d-flex">
            <% if(user.getPermisos().equals("Administrador")) { %>
                <a href="mantenimiento.jsp" class="btn btn-outline-pink me-2 btn-sm px-3 d-flex align-items-center">Mantenimiento</a>
            <% } %>
            <a href="LogoutServlet" class="btn btn-danger-soft btn-sm px-3 d-flex align-items-center">Cerrar Sesión</a>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card main-card p-5 text-center">
                <div class="card-body">
                    <span style="font-size: 3rem;"></span>
                    <h2 class="fw-bold mt-2 mb-1" style="color: #db2777;">Acceso Autorizado</h2>
                    <p class="text-muted mb-4">Rol activo en el espacio: <strong><%= user.getPermisos() %></strong></p>

                    <div class="my-4">
                        <div class="badge-online">
                            <span class="dot"></span>
                            <span>Mapeo exitoso: El campo <strong>Enlinea</strong> cambió a 1 en MySQL</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>