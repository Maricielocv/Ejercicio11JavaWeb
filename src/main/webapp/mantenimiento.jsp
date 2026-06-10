<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.sistema.model.Usuario" %>
<%
    Usuario user = (Usuario) session.getAttribute("userLogueado");
    if (user == null || !user.getPermisos().equals("Administrador")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Study Space - Mantenimiento</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #faf7f2;
            color: #4a4a4a;
            font-family: 'Plus Jakarta Sans', 'Segoe UI', sans-serif;
            min-height: 100vh;
        }
        .admin-card {
            background-color: #ffffff;
            border: 1px solid #f0eae1;
            border-radius: 20px;
        }
        .btn-pink {
            background-color: #f472b6;
            color: white;
            border: none;
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .btn-pink:hover {
            background-color: #ec4899;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(236, 72, 153, 0.2);
        }
        .form-control, .form-select {
            background-color: #fffafb;
            border: 1px solid #f3e8eb;
            border-radius: 10px;
        }
        .modal-content {
            border-radius: 20px;
            border: none;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
        }
        .table-aesthetic {
            border-collapse: separate;
            border-spacing: 0 8px;
        }
        .table-aesthetic tr {
            background-color: #fffafb;
            box-shadow: 0 2px 5px rgba(0,0,0,0.01);
        }
        .table-aesthetic th {
            background-color: transparent;
            border: none;
            color: #db2777;
            font-size: 0.85rem;
            text-transform: uppercase;
        }
        .table-aesthetic td {
            border: none;
            padding: 12px;
            vertical-align: middle;
        }
        .table-aesthetic tr:first-child td {
            border-top-left-radius: 10px;
            border-bottom-left-radius: 10px;
        }
        .table-aesthetic tr:last-child td {
            border-top-right-radius: 10px;
            border-bottom-right-radius: 10px;
        }
    </style>
</head>
<body>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-10">
            <div class="card admin-card p-4 shadow-sm">
                <div class="card-body">

                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h4 class="fw-bold m-0" style="color: #db2777;"> Mantenimiento de Usuarios</h4>
                        <div>
                            <button class="btn btn-pink btn-sm px-3 me-2" data-bs-toggle="modal" data-bs-target="#modalAgregar">+ Agregar Usuario</button>
                            <a href="principal.jsp" class="btn btn-light btn-sm rounded-3 border px-3">Regresar</a>
                        </div>
                    </div>

                    <p class="text-muted small">Sesión de administración activa de <strong><%= user.getNombres() %></strong>.</p>

                    <% if (request.getAttribute("msg") != null) { %>
                        <div class="alert alert-success border-0 bg-success bg-opacity-10 text-success py-2 small rounded-3" role="alert">
                            <%= request.getAttribute("msg") %>
                        </div>
                    <% } %>

                    <div class="table-responsive mt-4">
                        <table class="table table-aesthetic">
                            <thead>
                                <tr>
                                    <th>ID Correlativo</th>
                                    <th>Usuario</th>
                                    <th>Nombres</th>
                                    <th>Rol / Permisos</th>
                                    <th>Estado</th>
                                    <th>En Línea</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><span class="badge bg-light text-dark border">100000001</span></td>
                                    <td class="fw-bold">@<%= user.getUsuario() %></td>
                                    <td><%= user.getNombres() %></td>
                                    <td><span class="badge bg-danger bg-opacity-10 text-danger rounded-pill px-2.5">Administrador</span></td>
                                    <td><span class="badge bg-success bg-opacity-10 text-success rounded-pill px-2.5">Activo</span></td>
                                    <td><span class="p-1 bg-success rounded-circle d-inline-block me-1"></span> Sí</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modalAgregar" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content p-3">
            <div class="modal-header border-0 pb-0">
                <h5 class="fw-bold m-0" style="color: #db2777;"> Registrar Nuevo Usuario</h5>
                <button type="button" class="btn-close" data-bs-with="modal" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="UsuarioServlet" method="post">
                    <input type="hidden" name="accion" value="guardar">

                    <div class="mb-3">
                        <label class="form-label text-muted small fw-semibold">Nombre de Usuario</label>
                        <input type="text" name="txtNewUser" class="form-control" placeholder="ej: ana_sistemas" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label text-muted small fw-semibold">Contraseña Inicial</label>
                        <input type="password" name="txtNewPass" class="form-control" placeholder="••••••••" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label text-muted small fw-semibold">Nombres Completos</label>
                        <input type="text" name="txtNewName" class="form-control" placeholder="Ana María" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label text-muted small fw-semibold">Rol en el Sistema</label>
                        <select name="txtNewPermiso" class="form-select">
                            <option value="Usuario normal">Usuario normal</option>
                            <option value="Administrador">Administrador</option>
                        </select>
                    </div>
                    <div class="text-end mt-4">
                        <button type="button" class="btn btn-light btn-sm rounded-3 border me-2" data-bs-dismiss="modal">Cancelar</button>
                        <button type="submit" class="btn btn-pink btn-sm px-4">Guardar Registro</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>