<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Study Space - Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #fdfbf7 0%, #fbc5d8 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            font-family: 'Plus Jakarta Sans', 'Segoe UI', sans-serif;
        }
        .aesthetic-card {
            background: rgba(255, 255, 255, 0.85);
            backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.6);
            border-radius: 24px;
            box-shadow: 0 10px 30px rgba(244, 63, 94, 0.08);
            color: #4a4a4a;
        }
        .form-control {
            background-color: #fffafb;
            border: 1px solid #f3e8eb;
            border-radius: 12px;
            color: #4a4a4a;
        }
        .form-control:focus {
            background-color: #fff;
            border-color: #fbc5d8;
            box-shadow: 0 0 0 4px rgba(251, 197, 216, 0.25);
        }
        .btn-aesthetic {
            background: #f472b6;
            border: none;
            border-radius: 12px;
            color: white;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .btn-aesthetic:hover {
            background: #ec4899;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(236, 72, 153, 0.2);
        }
        .title-brand {
            color: #db2777;
            letter-spacing: -0.5px;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-4">
            <div class="card aesthetic-card p-4">
                <div class="card-body">
                    <div class="text-center mb-4">
                        <h3 class="fw-bold m-0 title-brand">utp</h3>
                        <p class="text-muted small m-0 mt-1">Soluciones Informáticas • Capas & Sesiones</p>
                    </div>

                    <% if (request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger border-0 bg-danger bg-opacity-10 text-danger text-center mb-3 py-2 small rounded-3" role="alert">
                            <%= request.getAttribute("error") %>
                        </div>
                    <% } %>

                    <form action="LoginServlet" method="post">
                        <div class="mb-3">
                            <label class="form-label text-muted small fw-semibold">Usuario</label>
                            <input type="text" name="txtUser" class="form-control py-2" placeholder="@usuario" required>
                        </div>
                        <div class="mb-4">
                            <label class="form-label text-muted small fw-semibold">Contraseña</label>
                            <input type="password" name="txtPass" class="form-control py-2" placeholder="••••••••" required>
                        </div>
                        <button type="submit" class="btn btn-aesthetic w-100 py-2.5">Ingresar al espacio</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>