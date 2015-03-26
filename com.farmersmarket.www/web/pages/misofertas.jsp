<%-- 
    Document   : plantilla
    Created on : 27/02/2015, 12:22:03 PM
    Author     : kennross
--%>

<%@page import="co.modulo.ofertas.dtos.PromocionDto"%>
<%@page import="co.modulo.ofertas.FOferta"%>
<%@page import="co.modulo.ofertas.dtos.OfertaDto"%>
<%@page import="co.modulo.usuarios.FUsuario"%>
<%@page import="co.modulo.usuarios.dtos.PermisoDto"%>
<%@page import="co.modulo.usuarios.daos.PermisoDao"%>
<%@page import="co.modulo.usuarios.dtos.RolDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="co.modulo.usuarios.dtos.UsuarioDto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    HttpSession miSesion = request.getSession(false);
    HttpSession miSesionRoles = request.getSession(false);

    UsuarioDto actualUsuario;
    ArrayList<RolDto> rolesActuales;

    actualUsuario = (UsuarioDto) miSesion.getAttribute("usuarioEntro");
    rolesActuales = (ArrayList<RolDto>) miSesionRoles.getAttribute("roles");

    if (actualUsuario == null) {
        response.sendRedirect("../index.jsp?msg=<strong><i class='glyphicon glyphicon-exclamation-sign'></i> ¡Ups!</strong> Inicie Sesión Primero.&tipoAlert=info");
    } else {
        RolDto primerRol = rolesActuales.get(0);

        FUsuario faUsu = new FUsuario();
        FOferta faOfer = new FOferta();
        String pagActual = "misofertas.jsp";

        // Validación para poder entrar
        boolean poderEntrar = false;

        for (RolDto rol : rolesActuales) {
            if (rol.getIdRol() == 1) {
                poderEntrar = true;
            }
        }

        if (poderEntrar) {

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" href="../img/favicon.ico">
        <link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="../css/font-awesome.css">
        <script type="text/javascript" src="../js/jquery-1.11.2.js"></script>
        <script type="text/javascript" src="../js/bootstrap.js"></script>
        <script type="text/javascript" src="../js/ajax.js"></script>
        <script type="text/javascript" src="../js/validaciones.js"></script>
        <title>Mis Ofertas - Farmer's Market</title>
    </head>
    <body>
        <div class="container">
            <!-- Banner Farmer's Market -->
            <div class="row">
                <div class="col-md-12">
                    <img src="../img/banner.jpg" alt="Banner de Farmer's Market" width="1000px">
                </div>
            </div>
            <!-- Fin del Banner  -->

            <!-- Contenedor Principal de la Página -->
            <div class="row">
                <!-- Dashboard -->
                <div class="col-md-2" style="background: #FAFAFA; border-radius: 3px">
                    <!-- Información del Rol iniciado -->
                    <div class="media">
                        <div class="media-left">
                            <a href="#" data-toggle="modal" data-target="#modalSubirFoto">
                                <img class="media-object img-circle" width="50" 
                                     <% if (actualUsuario.getImagen() != null) {
                                             out.print("src='../" + actualUsuario.getImagen() + "'");
                                         } else {
                                             out.print("src='../img/avatars/user.png'");
                                             out.print("data-toggle='tooltip' data-original-title='Presion clic para subir una foto'");
                                         }
                                     %>
                                     alt="Mi foto de perfil">
                            </a>
                        </div>
                        <div class="media-body">
                            <p></p>
                            <h4 class="media-heading">
                                <select onchange="getPermisos(this.value);" name="idRol">
                                    <%
                                        for (RolDto r : rolesActuales) {
                                    %>
                                    <option value="<%= r.getIdRol()%>"><%= r.getNombre()%></option>
                                    <%
                                        }
                                    %>                                                                        
                                </select>
                            </h4>
                            <%= actualUsuario.getNombres() + " " + actualUsuario.getApellidos()%>
                        </div>
                    </div>
                    <!-- Fin del rol iniciado -->
                    <hr>

                    <!-- Menú de navegación -->
                    <ul class="nav nav-pills nav-stacked" id="sesionPermisos">
                        <%
                            ArrayList<PermisoDto> listaPermisos;
                            listaPermisos = (ArrayList<PermisoDto>) faUsu.obtenerPermisosPorRol(primerRol.getIdRol());
                            for (PermisoDto temPermiso : listaPermisos) {
                        %>
                        <li role="presentation" class="
                            <% if (temPermiso.getUrl().equals(pagActual)) {
                                    out.print("active ");
                                }
                            %>
                            text-left">
                            <a href="<%= temPermiso.getUrl()%>"><%= temPermiso.getNombre() + " " + temPermiso.getIcon()%></a>
                        </li>
                        <%
                            }
                        %>
                    </ul>
                    <!-- Fin del menú de navegación -->

                </div>
                <!-- Fin de la Dashboard -->


                <!-- Contenedor de Segundo-->
                <div class="col-md-10">
                    <!-- Menú de Sesion, buscar, idiomas y info -->
                    <nav class="navbar navbar-default">
                        <div class="container-fluid">
                            <div class="navbar-header">
                                <a href="#" class="navbar-brand text-success">
                                    Pedidos <span class="badge info">4</span> 
                                </a>
                                <a href="#" class="navbar-brand text-success">
                                    Ofertas <span class="badge">18</span>
                                </a>
                            </div>
                            <!-- Collect the nav links, forms, and other content for toggling -->
                            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                                <ul class="nav navbar-nav navbar-right">                                    
                                    <li><a href="#"><img src="../img/flag/ing/flag-ingles-16.png" alt="Cambiar idioma a Inglés" title="Cambiar idioma a Inglés"></a></li>
                                    <li><a href="#"><img src="../img/flag/spa/flag-spanis16.png" alt="Cambiar idioma a Español" title="Cambiar idioma a Español"></a></li>
                                    <li class="dropdown">
                                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"> <%= actualUsuario.getNombres() + " " + actualUsuario.getApellidos()%> <span class="fa fa-chevron-down"></span></a>
                                        <ul class="dropdown-menu" role="menu">
                                            <li class="text-center"><a href="../GestionSesiones?op=salir">Cerrar Sesión</a></li>
                                            <li class="divider"></li>
                                            <li class="text-center"><a href="perfil.jsp">Mi Perfil</a></li>
                                            <li class="divider"></li>
                                            <li class="text-center"><a href="#" data-toggle="modal" data-target="#modalCambiarClave">Cambiar Contraseña</a></li>
                                            <li class="divider"></li>
                                            <li class="text-center"><a href="#">Ayuda <i class="fa fa-exclamation-circle"></i></a></li>
                                        </ul>
                                    </li>
                                </ul>
                                <form class="navbar-form navbar-right" role="search">
                                    <div class="form-group">
                                        <div class="input-group">                                            
                                            <input type="text" class="form-control" placeholder="¿Qué está buscando?...">
                                            <span class="input-group-btn">
                                                <button class="btn btn-default" type="submit">Buscar!</button>
                                            </span>
                                        </div>
                                    </div>
                                </form>

                                <ul class="navbar-form navbar-toggle">                                                                                
                                    <button class="btn btn-success navbar-brand" type="button">
                                        Pedidos <span class="badge">4</span>
                                    </button>
                                </ul>
                            </div>
                        </div>
                    </nav>
                    <!-- Fin de menú de sesión, buscar, idiomas y info -->

                    <!-- Miga de pan -->
                    <ol class="breadcrumb">
                        <li><a href="indexp.jsp">Inicio</a></li>
                        <li><a href="misofertas.jsp">Mis Ofertas</a></li>                        
                    </ol>
                    <!-- Fin de miga de pan -->

                    <!-- Mensajes de alertas -->
                    <%
                        if (request.getParameter("msg") != null && request.getParameter("tipoAlert") != null) {
                    %>
                    <div class="alert alert-<%= request.getParameter("tipoAlert")%>" role="alert">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <p class="text-center"><%= request.getParameter("msg")%></p>
                    </div>
                    <%
                        }
                    %>            
                    <!-- Fin de mensajes de alertas -->

                    <!-- Contenedor de contenido especifico -->
                    <div class="container-fluid">
                        <div class="row">                            
                            <div class="col-md-9">
                                <div class="page-header">
                                    <h1 class="text-center lead">Mis Ofertas <i class="fa fa-shopping-cart"></i> <small>Tiene disponibles <%= 5 - faOfer.obtenerCuposOferta(actualUsuario.getIdUsuario())%> cupos</small></h1>
                                </div>
                                <!-- Formato de una oferta -->
                                <%
                                    ArrayList<OfertaDto> misOfertas;
                                    misOfertas = (ArrayList<OfertaDto>) faOfer.obtenerOfertasProducto(actualUsuario.getIdUsuario());
                                    if (misOfertas.size() != 0) {
                                        for (OfertaDto of : misOfertas) {
                                %>
                                <div class="panel panel-info">
                                    <div class="panel-heading">
                                        <h2 class="panel-title">
                                            <span class="lead">Fecha de Publicación </span> <%= of.getFechaInicio()%> <small class="pull-right">Caduca en <%= faOfer.obtenerDiasCaducacionOferta(of.getIdOferta())%> día(s)</small>
                                        </h2>
                                    </div>
                                    <div class="panel-body">
                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <th>Código Oferta</th>
                                                    <th>Producto</th>
                                                    <th>Cantidad</th>
                                                    <th>Precio de venta</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td><%= of.getIdOferta()%></td>
                                                    <td><%= faOfer.obNombreCategoriaPorIDPA(of.getIdProductoAsociado())%></td>
                                                    <td><%= of.getCantidadDisponible()%> Kilos Disponibles</td>
                                                    <td>$<%= of.getPrecioCompra()%></td>
                                                </tr>                                                
                                            </tbody>                                            
                                        </table>

                                        <div class="col-sm-4 pull-left">
                                            <h4>
                                                <span class="label label-info">
                                                    <%
                                                        if (of.getEstado() == 1) {
                                                            out.print("Publicada <i class='fa fa-check'></i>");
                                                        }
                                                    %>
                                                </span>
                                            </h4>
                                        </div>
                                        <%
                                            PromocionDto tempPromo;
                                            tempPromo = faOfer.obtenerPromocionPorOferta(of.getIdOferta());
                                            if (tempPromo.getIdPromocion() != 500) {
                                        %>
                                        <p>
                                            <strong>Descuento: </strong> <%= tempPromo.getDetalle()%> % <br>
                                            <%= tempPromo.getDescripcion()%>
                                        </p>
                                        <%
                                            }
                                        %>                                        
                                    </div>
                                    <div class="panel-footer">
                                        <h3 class="panel-title">
                                            <!-- Novedades -->
                                            <!-- link para modal para agregar novedad -->
                                            <%
                                                if (tempPromo.getIdPromocion() == 500) {
                                            %>
                                            <a href="#" data-toggle="modal" data-target="#modalAgregarPromocion">
                                                <i class="fa fa-plus pull-left"></i> <span class="pull-left text-success">Agregar Promoción</span>
                                            </a>                                                                                        
                                            <div class="modal fade bs-example-modal-sm" id="modalAgregarPromocion" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-sm">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                            <h4 class="modal-title text-center" id="myModalLabel">Agregar una Promoción</h4>
                                                        </div>
                                                        <div class="modal-body">
                                                            <form method="POST" action="../GestionOfertas" id="formAgregarPromo">
                                                                <div class="input-group">
                                                                    <span class="input-group-addon">Descuento del: </span>
                                                                    <input type="number" name="opaDetalle" class="form-control" aria-label="Amount (to the nearest dollar)">
                                                                    <span class="input-group-addon">.%</span>
                                                                </div>
                                                                <br>
                                                                <textarea class="form-control" rows="3" name="opaDescripcionPromocion" maxlength="140" placeholder="Una breve descripción de la promoción (Máx 140 carácteres)"></textarea>
                                                                <input type="hidden" name="idOferta" value="<%= of.getIdOferta()%>">
                                                                <input type="hidden" name="opaEnviar" value="Agregar">
                                                            </form>

                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                                                            <button type="button" class="btn btn-primary" onclick="enviarFormulario('formAgregarPromo');">Agregar</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <%
                                            } else {
                                            %>
                                            <a href="#">
                                                <i class="fa fa-plus pull-left"></i> <span class="pull-left text-success">Editar Promoción</span>
                                            </a>
                                            <%
                                                }
                                            %>                                            

                                            <!-- link para eliminar la oferta -->
                                            <a href="../GestionOfertas?op=eliofer&idOferta=<%= of.getIdOferta()%>">
                                                <i class="fa fa-remove pull-right"> </i> <span class="pull-right text-danger">&nbsp;&nbsp; Eliminar Oferta</span>
                                            </a>                                                                                        
                                            <!-- Fin link para eliminar la oferta -->
                                            
                                            <!-- link para modal para editar la oferta -->
                                            <a href="../GestionOfertas?op=eliofer&idOferta=<%= of.getIdOferta()%>">
                                                <i class="fa fa-pencil pull-right"> </i> <span class="pull-right text-primary">Editar Oferta</span>
                                            </a>                                                                                        
                                            <!-- Fin link para modal para editar la oferta -->
                                            &nbsp;
                                        </h3>
                                    </div>
                                </div>
                                <!-- Fin de formato de una oferta -->
                                <%                                    }
                                } else {
                                %>
                                <div class="col-md-12">
                                    <div class="alert alert-info text-center">
                                        <p>
                                            <strong>No tiene ofertas publicadas</strong> <br>Por lo tanto no tendrá pedidos
                                            <strong><a href="misproductos.jsp"> Ir a Mis Productos</a></strong> para publicar ofertas
                                        </p>
                                    </div>
                                </div>
                                <%
                                    }
                                %>                                
                            </div>
                            <div class="col-md-3">
                                <img src="../img/publicidad.jpg" alt="..." class="img-thumbnail">
                            </div>
                        </div>
                    </div>
                    <!-- Fin de contenedor de contenido especifico -->


                    <!-- Ventanas Modales -->
                    <div class="container-fluid">
                        <!-- Cambiar Contraseña -->
                        <div>
                            <div class="modal fade" id="modalCambiarClave" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                            <h4 class="modal-title text-center" id="myModalLabel">Cambiar Contraseña</h4>
                                        </div>
                                        <div class="modal-body">

                                            <form class="form-horizontal" method="POST" action="../GestionUsuarios" id="formCambiarClave">
                                                <div class="form-group has-feedback" id="inpClaveAntigua">
                                                    <label for="ccClaveAntigua" class="col-sm-4 control-label">Contraseña Antigua</label>
                                                    <div class="col-sm-7">
                                                        <input type="password" class="form-control" 
                                                               id="ccClaveAntigua" placeholder="Ingrese la contraseña antigua"
                                                               name="ccClaveAntigua" onblur="validarClaveEnCambiar(this)">
                                                        <!-- Al momento de validar, se le manda la class a la i para agregar icon-->
                                                        <i id="iconFeedbackClaveCambiar"></i>
                                                    </div>
                                                </div>

                                                <div class="form-group has-feedback" id="inpClaveNuevaCambiar">
                                                    <label for="ccClaveNueva" class="col-sm-4 control-label">Nueva Contraseña</label>
                                                    <div class="col-sm-7">                                                        
                                                        <input type="password" class="form-control" 
                                                               id="ccClaveNueva" placeholder="Ingrese una nueva contraseña"
                                                               name="ccClaveNueva" onblur="validarClaveNuevaEnCambiar(this)">
                                                        <!-- Al momento de validar, se le manda la class a la i para agregar icon-->
                                                        <i id="iconFeedbackClaveNuevaCambiar"></i>
                                                    </div>
                                                </div>

                                                <div class="form-group has-feedback" id="inpClaveRepetidaCambiar">
                                                    <label for="ccClaveRepetida" class="col-sm-4 control-label">Repetir Contraseña</label>
                                                    <div class="col-sm-7">
                                                        <input type="password" class="form-control" 
                                                               id="ccClaveRepetida" placeholder="Ingrese una nueva contraseña"
                                                               name="ccClaveRepetida" onblur="validarRepetirClaveNuevaEnCambiar(this)">
                                                        <!-- Al momento de validar, se le manda la class a la i para agregar icon-->
                                                        <i id="iconFeedbackClaveNuevaCambiar2"></i>
                                                    </div>
                                                </div>                                                

                                                <input hidden="true" name="ccViene" value="indexp">
                                                <input hidden="true" name="ccDocumento" id="ccDocumento" value="<%= actualUsuario.getIdUsuario()%>">
                                                <input hidden="true" name="formCambiarClave" id="formCambiarClave" value="ok">
                                            </form>                                                                                        
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                                            <button type="button" id="botonEnviarCambiarClave" class="btn btn-success"  onclick="enviarFormulario('formCambiarClave')">Cambiar Contraseña</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Fin de Cambiar Contraseña -->

                        <!-- Formulario de Contáctenos -->
                        <div>
                            <div class="modal fade" id="modalContactenos" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                            <h4 class="modal-title text-center" id="myModalLabel">Contáctenos | Farmer's Market</h4>
                                        </div>
                                        <div class="modal-body">
                                            <form class="form-horizontal" method="POST" action="../GestionUsuarios" id="formContactenos">
                                                <div class="form-group">
                                                    <label for="mcNombre" class="col-sm-2 control-label">Nombre</label>
                                                    <div class="col-sm-10">
                                                        <input type="text" class="form-control" name="mcNombre"
                                                               id="mcNombre" placeholder="Ingrese su nombre">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="mcCorreo" class="col-sm-2 control-label">Correo</label>
                                                    <div class="col-sm-10">
                                                        <input type="text" class="form-control" name="mcCorreo"
                                                               id="mcCorreo" placeholder="Ingrese su correo electrónico">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="inputPassword3" class="col-sm-2 control-label">Mensaje</label>
                                                    <div class="col-sm-10">
                                                        <textarea name="mcMensaje" class="form-control" rows="4" placeholder="Ingrese su mensaje para la compañía Farmer's Market"></textarea>
                                                    </div>
                                                </div>

                                                <input hidden="true" name="mcViene" value="misOfertas">
                                                <input type="hidden" name="mcEnviar" value="ok">
                                            </form>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar</button>
                                            <button type="button" class="btn btn-success" onclick="enviarFormulario('formContactenos')">Enviar Mensaje</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Fin de formulario de Contáctenos -->
                    </div>
                </div>
                <!-- Contenedor de Segundo-->
            </div>
            <!-- Fin de contenedor Principal de la Página -->
            <p></p>
            <!-- Footer (Nota: Escribir el código que permita que esto quede abajo fijo) -->
            <div class="row">
                <div class="col-md-13">
                    <!-- Footer (Nota: Escribir el código que permita que esto quede abajo fijo) -->
                    <ol class="breadcrumb container-fluid">
                        <em class="text-center">Todos los derechos reservados / <a href="http://getbootstrap.com/">Bootstrap</a> / <a href="http://fortawesome.github.io/Font-Awesome/">Font-Awesome</a> / <a href="http://jquery.com/">JQuery</a></em>
                        <em class="pull-right"><a href="#" data-toggle="modal" data-target="#modalContactenos">Contactar un Administrador</a></em>
                    </ol>

                </div>
            </div>
            <!-- Fin del Footer -->
        </div>
    </body>
</html>
<%
        }
    }
%>