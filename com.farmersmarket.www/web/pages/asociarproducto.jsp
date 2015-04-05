<%-- 
    Document   : plantilla
    Created on : 27/02/2015, 12:22:03 PM
    Author     : kennross
--%>
<%@page import="co.modulo.pedidos.FPedido"%>
<%@page isThreadSafe="false" import="java.util.*" errorPage="../error.jsp" %>
<%@page import="co.modulo.ofertas.FOferta"%>
<%@page import="co.modulo.ofertas.dtos.ProductoDto"%>
<%@page import="co.modulo.usuarios.FUsuario"%>
<%@page import="co.modulo.usuarios.dtos.PermisoDto"%>
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
        FPedido faPe = new FPedido();
        String pagActual = "asociarproducto.jsp";

        // Validación para poder entrar
        boolean poderEntrar = false;

        for (RolDto rol : rolesActuales) {
            if (rol.getIdRol() == 1) {
                poderEntrar = true;
            }
        }

        if (!poderEntrar) {
            miSesion.invalidate();
            response.sendRedirect("../index.jsp?msg=<strong>¡Ups! <i class='glyphicon glyphicon-exclamation-sign'></i></strong> No tiene permisos para entrar aquí, ingrese de nuevo.&tipoAlert=warning");
        } else {
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" href="../img/favicon.ico">
        <link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="../css/font-awesome.css">
        <link rel="stylesheet" type="text/css" href="../css/dataTables.bootstrap.css">
        <script type="text/javascript" src="../js/jquery-1.11.2.js"></script>
        <script type="text/javascript" src="../js/bootstrap.js"></script>
        <script type="text/javascript" src="../js/validaciones.js"></script>
        <script type="text/javascript" src="../js/ajax.js"></script>


        <script type="text/javascript" src="../js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="../js/dataTables.bootstrap.js"></script>
        <title>Asociar Producto - Farmer's Market</title>
        <script type="text/javascript">
            $(document).ready(function () {
                // Initialize tooltip
                $('[data-toggle="tooltip"]').tooltip({
                    placement: 'top'
                });
            });

            $(document).ready(function () {
                $('#rtProductos').dataTable();
            });
        </script>
    </head>
    <body>
        <div class="container">
            <!-- Banner Farmer's Market -->
            <div class="row">
                <nav class="navbar navbar-default">
                    <div class="container-fluid">
                        <a class="navbar-brand" id="brandfm" href="indexp.jsp">Farmer's Market</a>
                        <div class="navbar-header">
                            <a href="#" class="navbar-brand text-success">
                                <small>Pedidos <span class="badge info"><%= faPe.obtenerPedidosActivosProductor(actualUsuario.getIdUsuario())%></span></small>
                            </a>
                            <a href="#" class="navbar-brand text-success">
                                <small>Ofertas <span class="badge info"><%= faOfer.obtenerOfertasActivasProductor(actualUsuario.getIdUsuario())%></span></small>
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
                        </div>
                    </div>
                </nav>
            </div>
            <!-- Fin del Banner  -->

            <!-- Contenedor Principal de la Página -->
            <div class="row">
                <!-- Dashboard -->
                <div class="col-md-2 barraizquierda">
                    <!-- Información del Rol iniciado -->
                    <div class="media">
                        <div class="media-left">
                            <a href="#" data-toggle="modal" data-target="#modalSubirFoto">
                                <img class="media-object img-circle" width="50" 
                                     <%
                                         if (actualUsuario.getImagen() != null) {
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
                    <!-- Miga de pan -->
                    <div class="row">
                        <ol class="breadcrumb">
                            <li><a class="a" href="indexp.jsp">Inicio</a></li>
                            <li><a class="a" href="asociarproducto.jsp">Asociar Productos</a></li>
                        </ol>
                    </div>                    
                    <!-- Fin de miga de pan -->                    

                    <!-- Mensajes de alertas -->
                    <div class="row">
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
                    </div>
                    <!-- Fin de mensajes de alertas -->

                    <!-- Contenedor de contenido especifico -->
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-9" >
                                <div class="well-sm">
                                    <h4 class="text-center">Seleccione los productos a ofertar <small><span class="text-info">Tiene disponibles: <%= faOfer.mostrarCuposDisponiblesAsociar(actualUsuario.getIdUsuario())%> cupo(s)</span></small></h4>
                                </div>
                                <p></p>
                                <form method="GET" action="../GestionProductos" id="formAsociarProductos">                                    
                                    <table class="table table-hover" id="rtProductos">
                                        <thead>
                                            <tr>
                                                <th>Nombre</th>
                                                <th>Categoria</th>
                                                <th>Imagen</th>
                                                <th>Seleccionar</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                ArrayList<ProductoDto> listaProductos;
                                                listaProductos = (ArrayList<ProductoDto>) faOfer.obtenerTodosLosProductos();
                                                for (ProductoDto p : listaProductos) {
                                            %>
                                            <tr>
                                                <td><%= p.getNombre()%></td>
                                                <td><%= faOfer.obtenerNombreDeCategoriaPorId(p.getIdCategoria())%></td>
                                                <td><img src="../<%= p.getImagen()%>" alt="Imagen de la lechuga" width="40"></td>
                                                <td class="text-center"><input type="checkbox" name="apProductos" value="<%= p.getIdProducto()%>" id="apProductos"></td>
                                            </tr>
                                            <%
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                    <input type="hidden" name="apidProductor" value="<%= actualUsuario.getIdUsuario()%>">
                                    <input type="hidden" name="apEnviar" value="Asociar">
                                    <button type="button" class="btn btn-success" data-toggle="modal" data-target="#modalConfirmarAsociarProducto">Asociar Producto(s)</button>
                                </form>                                
                            </div>
                            <div class="col-md-3">
                                <img class="img-thumbnail" src="../img/publicidad/publicidad2.jpg" alt="Nuevo producto a disposición">
                            </div>
                        </div>
                    </div>
                    <!-- Fin de contenedor de contenido especifico -->                    

                </div>
                <!-- Contenedor de Segundo-->
            </div>
            <!-- Fin de contenedor Principal de la Página -->

            <!-- Footer -->
            <div class="row">                
                <div class="col-md-12">                    
                    <ol class="breadcrumb container-fluid">
                        <em class="text-center"><span class="a">Todos los derechos reservados</span> / <a href="http://getbootstrap.com/" class="a" >Bootstrap</a> / <a class="a" href="http://fortawesome.github.io/Font-Awesome/">Font-Awesome</a> / <a class="a" href="http://jquery.com/">JQuery</a></em>
                        <em class="pull-right"><a href="#" class="a" data-toggle="modal" data-target="#modalContactenos">Contactar un Administrador</a></em>
                    </ol>
                </div>               
            </div>
            <!-- Fin del Footer -->

            <!-- Ventanas Modales -->
            <div class="container-fluid">
                <!-- Cambiar Contraseña -->
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
                <!-- Fin de Cambiar Contraseña -->

                <!-- Formulario de Contáctenos -->                        
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

                                    <input hidden="true" name="mcViene" value="indexp">
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
                <!-- Fin de formulario de Contáctenos -->

                <!-- Modal para confirmación de asociar productos -->
                <div>
                    <div class="modal fade bs-example-modal-sm" id="modalConfirmarAsociarProducto" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-sm">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h4 class="modal-title text-center" id="myModalLabel">¿Está seguro que desea asociar estos productos?</h4>
                                </div>
                                <div class="modal-footer">
                                    <center>
                                        <button type="button" class="btn btn-success" onclick="enviarFormulario('formAsociarProductos');">Sí</button>
                                        <button type="button" class="btn btn-danger" data-dismiss="modal">No</button>                                                
                                    </center>                                            
                                </div>                                        
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Fin de modal para confirmación de asociar productos -->
            </div>
        </div>
    </body>
</html>
<%
        }
    }
%>