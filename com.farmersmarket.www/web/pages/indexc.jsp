<%-- 
    Document   : plantilla
    Created on : 27/02/2015, 12:22:03 PM
    Author     : kennross
--%>

<%@page import="co.modulo.usuarios.FUsuario"%>
<%@page import="co.modulo.usuarios.dtos.PermisoDto"%>
<%@page import="co.modulo.usuarios.dtos.RolDto"%>
<%@page import="co.modulo.usuarios.daos.PermisoDao"%>
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
        String pagActual = "indexc.jsp";

        // Validación para poder entrar
        boolean poderEntrar = false;

        for (RolDto rol : rolesActuales) {
            if (rol.getIdRol() == 2) {
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
        <script type="text/javascript" src="../js/jquery-1.11.2.js"></script>
        <script type="text/javascript" src="../js/bootstrap.js"></script>
        <script type="text/javascript" src="../js/ajax.js"></script>
        <script type="text/javascript" src="../js/validaciones.js"></script>        
        <title>Cliente - Farmer's Market</title>
        <script type="text/javascript">
            $(document).ready(function () {
                // Initialize tooltip
                $('[data-toggle="tooltip"]').tooltip({
                    placement: 'top'
                });
            });
        </script>
    </head>
    <body>
        <div class="container">
            <!-- Banner Farmer's Market -->
            <div class="row">
                <!-- Menú de Sesion, buscar, idiomas y info -->
                <nav class="navbar navbar-default">
                    <div class="container-fluid">
                        <a class="navbar-brand" id="brandfm" href="indexp.jsp">Farmer's Market</a>

                        <div class="navbar-header">

                            <a href="#" class="navbar-brand text-success">
                                <small>Pedidos <span class="badge info">4</span></small>
                            </a>
                            <a href="#" class="navbar-brand text-success">
                                <small>Ofertas <span class="badge info">18</span></small>
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
                    <!-- Miga de pan -->
                    <div class="row">
                        <ol class="breadcrumb">
                            <li class="active"><a class="a" href="indexp.jsp">Inicio</a></li>
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
                            <form>
                                <div class="col-md-12">
                                    <div class="input-group">
                                        <input type="text" class="form-control" placeholder="¿Buscabas algo en especial?...">
                                        <span class="input-group-btn">
                                            <button class="btn btn-default" type="submit">Voy a tener suerte!</button>
                                        </span>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <h2 class="text-center">
                                    ¡Encuentra lo que buscas! <br>
                                    <small>Hay muchos de productos publicados, las mejores ofertas y los precios más bajos.</small>
                                </h2>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <h3 class="text-center">Categorías</h3>
                                <blockquote>
                                    <p>Encuentra el producto que buscas por su categoría.</p>
                                    <a href="#"><footer> Frutas</footer></a>
                                    <a href="#"><footer> Hortalizas</footer></a>
                                    <a href="#"><footer> Platanos</footer></a>
                                    <a href="#"><footer> Tuberculos</footer></a>                                    
                                </blockquote>
                            </div>                            
                            <div class="col-md-8">
                                <h3 class="text-center">Departamentos</h3>
                                <blockquote>
                                    <p>Encuentra el producto que buscas por su ubicación.</p>
                                    <div class="container-fluid">
                                        <div class="col-md-6">
                                            <p>Región Caribe</p>
                                            <a href="#"><footer> Atlántico</footer></a>
                                            <a href="#"><footer> Bolívar</footer></a>
                                            <a href="#"><footer> Cesar</footer></a>
                                            <a href="#"><footer> La Guajira</footer></a>
                                            <a href="#"><footer> Magdalena</footer></a>
                                            <a href="#"><footer> San Andrés y Providencia</footer></a>                                            
                                            <br>
                                            <p>Región Pacífica</p>
                                            <a href="#"><footer> Choco</footer></a>
                                            <a href="#"><footer> Valle del Cauca</footer></a>
                                            <a href="#"><footer> Cauca</footer></a>
                                            <a href="#"><footer> Nariño</footer></a>                                            
                                        </div>

                                        <div class="col-md-6">
                                            <p>Región de la Orinoquia</p>
                                            <a href="#"><footer> Meta</footer></a>
                                            <a href="#"><footer> Meta</footer></a>
                                            <a href="#"><footer> Casanare</footer></a>
                                            <a href="#"><footer> Arauca</footer></a>
                                            <br>
                                            <p>Región de la Amazonía</p>
                                            <a href="#"><footer> Amazonas</footer></a>
                                            <a href="#"><footer> Caquetá</footer></a>
                                            <a href="#"><footer> Guainía</footer></a>
                                            <a href="#"><footer> Guaviare</footer></a>
                                            <a href="#"><footer> Putumayo</footer></a>
                                            <a href="#"><footer> Vaupés</footer></a>                                            
                                        </div>
                                    </div>
                                </blockquote>
                            </div>
                        </div>
                    </div>                    
                    <!-- Fin de contenedor de contenido especifico -->
                </div>
            </div>

            <!-- Ventanas Modales -->                    
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

                                <input hidden="true" name="ccViene" value="indexc">
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

                                <input hidden="true" name="mcViene" value="indexc">
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
            <!-- Fin de Ventanas Modales-->
        </div>        
    </body>
</html>
<%
        }
    }
%>