<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PublicarProducto.aspx.cs" Inherits="Electromarket.Productos.PublicarProducto" %>

<!DOCTYPE html>
<html lang="es">
<head runat="server">
    <meta charset="utf-8" />
    <title>Publicar Producto - ElectroMarket</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        :root {
            --morado: #6f42c1;
            --morado-hover: #59339d;
            --gris-borde: #dee2e6;
            --gris-fondo: #f8f9fa;
        }

        body {
            background-color: var(--gris-fondo);
            color: #000;
        }

        .card {
            border-radius: 12px;
            border: 1px solid var(--gris-borde);
        }

        .card-header {
            background-color: #fff;
            border-bottom: 2px solid var(--morado);
            color: #000;
        }

        .form-control:focus {
            border-color: var(--morado);
            box-shadow: 0 0 0 0.2rem rgba(111, 66, 193, 0.25);
        }

        .btn-morado {
            background-color: var(--morado);
            color: #fff;
            border: none;
        }

        .btn-morado:hover {
            background-color: var(--morado-hover);
            color: #fff;
        }

        .btn-outline-morado {
            border: 1px solid var(--morado);
            color: var(--morado);
            background-color: #fff;
        }

        .btn-outline-morado:hover {
            background-color: var(--morado);
            color: #fff;
        }

        .icon-black i {
            color: #000;
        }

        .contador {
            font-size: 0.85rem;
            color: #6c757d;
            text-align: right;
        }
    </style>
</head>

<body>
<form id="form1" runat="server" enctype="multipart/form-data">

    <!-- NAVBAR -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark py-3">
        <div class="container">
            <a class="navbar-brand fw-bold" href="../Dashboard.aspx">
                <i class="bi bi-lightning-charge-fill"></i> ElectroMarket
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#menu">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="menu">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="../Dashboard.aspx"><i class="bi bi-house-fill"></i> Inicio</a></li>
                    <li class="nav-item"><a class="nav-link" href="Productos.aspx"><i class="bi bi-box-seam"></i> Productos</a></li>
                    <li class="nav-item"><a class="nav-link" href="MisProductos.aspx"><i class="bi bi-box"></i> Mis Productos</a></li>
                    <li class="nav-item">
                        <asp:LinkButton ID="btnCerrarSesion" runat="server" CssClass="nav-link text-danger" OnClick="btnCerrarSesion_Click">
                            <i class="bi bi-box-arrow-right"></i> Cerrar Sesión
                        </asp:LinkButton>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- CONTENIDO -->
    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-lg-8 col-md-10">

                <div class="card shadow-sm">
                    <div class="card-header">
                        <h4 class="mb-0 fw-bold icon-black">
                            <i class="bi bi-plus-circle"></i> Publicar nuevo producto
                        </h4>
                    </div>

                    <div class="card-body p-4">

                        <!-- ERROR -->
                        <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="alert alert-danger">
                            <i class="bi bi-exclamation-triangle-fill"></i>
                            <asp:Label ID="lblError" runat="server"></asp:Label>
                        </asp:Panel>

                        <!-- TÍTULO -->
                        <div class="mb-4 icon-black">
                            <label class="form-label fw-bold">
                                <i class="bi bi-tag-fill"></i> Título del producto
                            </label>
                            <asp:TextBox ID="txtTitulo" runat="server"
                                CssClass="form-control form-control-lg"
                                MaxLength="200"
                                placeholder="Ej: Laptop Dell Core i7 16GB RAM"
                                required />
                            <small class="text-muted">Máx. 200 caracteres</small>
                        </div>

                        <!-- DESCRIPCIÓN -->
                        <div class="mb-4 icon-black">
                            <label class="form-label fw-bold">
                                <i class="bi bi-text-paragraph"></i> Descripción
                            </label>
                            <asp:TextBox ID="txtDescripcion" runat="server"
                                CssClass="form-control"
                                TextMode="MultiLine"
                                Rows="5"
                                MaxLength="800"
                                placeholder="Describe el estado, características y accesorios del producto"
                                onkeyup="contarCaracteres(this, 800)"
                                required />
                            <div class="contador">
                                <span id="contadorDesc">0</span>/800 caracteres
                            </div>
                        </div>

                        <!-- PRECIO -->
<div class="mb-4 icon-black">
    <label class="form-label fw-bold">
        <i class="bi bi-cash-coin"></i> Precio
    </label>

    <asp:TextBox 
    ID="txtPrecio"
    runat="server"
    CssClass="form-control"
    TextMode="Number"
    placeholder="Ej: 150000"
    required />


    <small class="text-muted">Ingresa el precio del producto</small>
</div>

                        <!-- IMÁGENES -->
                        <div class="mb-4 icon-black">
                            <label class="form-label fw-bold">
                                <i class="bi bi-image-fill"></i> Imágenes del producto
                            </label>
                            <asp:FileUpload ID="fileImagenes" runat="server"
                                CssClass="form-control"
                                AllowMultiple="true"
                                accept="image/*" />
                            <small class="text-muted">Máximo 5 imágenes (JPG, PNG)</small>
                        </div>

                        <!-- BOTONES -->
                        <div class="d-grid gap-3">
                            <asp:Button ID="btnPublicar" runat="server"
                                Text="Publicar producto"
                                CssClass="btn btn-morado btn-lg"
                                OnClick="btnPublicar_Click" />

                            <a href="MisProductos.aspx" class="btn btn-outline-morado btn-lg">
                                <i class="bi bi-x-circle"></i> Cancelar
                            </a>
                        </div>

                    </div>
                </div>

                <!-- CONSEJOS -->
                <div class="card mt-4 shadow-sm">
                    <div class="card-body">
                        <h6 class="fw-bold icon-black">
                            <i class="bi bi-lightbulb-fill"></i> Consejos para una buena publicación
                        </h6>
                        <ul class="mb-0 text-muted">
                            <li>Título claro y específico</li>
                            <li>Describe el estado real</li>
                            <li>Menciona accesorios incluidos</li>
                            <li>Sé honesto con defectos</li>
                            <li>Usa fotos claras</li>
                        </ul>
                    </div>
                </div>

            </div>
        </div>
    </div>

</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    function contarCaracteres(textarea, max) {
        document.getElementById("contadorDesc").innerText = textarea.value.length;
    }
</script>

</body>
</html>
