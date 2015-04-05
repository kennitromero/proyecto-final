<%-- 
    Document   : plantilla
    Created on : 27/02/2015, 12:22:03 PM
    Author     : kennross
--%>

<%@page import="co.modulo.usuarios.dtos.TelefonoDto"%>
<%@page import="co.modulo.usuarios.dtos.PermisoDto"%>
<%@page import="co.modulo.usuarios.FUsuario"%>
<%@page import="co.modulo.usuarios.dtos.RolDto"%>
<%@page import="co.modulo.usuarios.dtos.DepartamentoDto"%>
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
    } else if (actualUsuario.getEstado() == 4 || actualUsuario.getEstado() == 3) {
        response.sendRedirect("../index.jsp?msg=<strong><i class='glyphicon glyphicon-exclamation-sign'></i> ¡Ups!</strong> Usted ha sido bloqueado, contacte a un administrador.&tipoAlert=info");
    } else {
        RolDto primerRol = rolesActuales.get(0);

        FUsuario faUsu = new FUsuario();
        String pagActual = "indexp.jsp";
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
        <script type="text/javascript" src="../js/validaciones.js"></script>
        <script type="text/javascript" src="../js/validacionesAjax.js"></script>
        <script type="text/javascript" src="../js/ajaxPages.js"></script>
        <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
        <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
        <title>Mi Perfil - Farmer's Market</title>
        <script type="text/javascript">
            $(document).ready(function () {
                $('[data-toggle="tooltip"]').tooltip({
                    placement: 'left'
                });
            });

            $(function () {
                $("#datepicker").datepicker();
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
                                     <% if (actualUsuario.getImagen() != null) {
                                             out.print("src='../" + actualUsuario.getImagen() + "'");
                                             out.print("data-toggle='tooltip' title='Presione clic para cambiar su foto'");
                                         } else {
                                             out.print("src='../img/avatars/user.png'");
                                             out.print("data-toggle='tooltip' title='Presione clic para cambiar su foto'");
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
                            <li class="active"><a class="a" href="perfil.jsp">Perfil</a></li>
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
                            <div class="col-md-9">
                                <div class="well-sm">
                                    <h4 class="text-center">Mis Datos Personales</h4>
                                </div>
                                <br>
                                <p>Los campos que están deshabilitados no lo puede cambiar, es necesario que <a href="#" data-toggle="modal" data-target="#modalContactenos"><strong>contacte a un administrador</strong></a>, todo esto está descrito en las politicas del sitio.</p>
                                <br>
                                <div class="container-fluid">
                                    <form class="form-horizontal" method="POST" action="../GestionUsuarios" id="formActualizarUsuario" >                                        
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="auDocumento" class="col-sm-4 control-label">Documento</label>
                                                <div class="col-sm-8">
                                                    <input type="text" name="auDocumento" class="form-control"
                                                           id="auDocumento" placeholder="Documento" readonly
                                                           value="<%= actualUsuario.getIdUsuario()%>" data-toggle="tooltip" 
                                                           data-original-title="No puede cambiar su documento, contacte a un administrador">                                                           
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="auNombres" class="col-sm-4 control-label">Nombres</label>
                                                <div class="col-sm-8">
                                                    <input type="text" name="auNombres" class="form-control" 
                                                           id="auNombres" placeholder="Sus nombres"
                                                           value="<%= actualUsuario.getNombres()%>">
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="auApellidos" class="col-sm-4 control-label">Apellidos</label>
                                                <div class="col-sm-8">
                                                    <input type="text" name="auApellidos" class="form-control" 
                                                           id="auApellidos" placeholder="Sus apellidos"
                                                           value="<%= actualUsuario.getApellidos()%>">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="auCorreo" class="col-sm-4 control-label">Corre electrónico</label>
                                                <div class="col-sm-8">
                                                    <input type="text" name="auCorreo" class="form-control" 
                                                           id="auCorreo" placeholder="Su correo electrónico"
                                                           value="<%= actualUsuario.getCorreo()%>">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="auApellidos" class="col-sm-4 control-label">Ciudad</label>
                                                <div class="col-sm-8">
                                                    <input type="text" name="auApellidos" class="form-control" readonly
                                                           id="auApellidos" placeholder="Su correo electrónico"
                                                           value="<%= faUsu.obtenerNombrePorIdCiudad(actualUsuario.getIdCiudad())%>">
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="auDireccion" class="col-sm-4 control-label">Dirección</label>
                                                <div class="col-sm-8">
                                                    <input type="text" name="auDireccion" class="form-control" 
                                                           id="auDireccion" placeholder="Dirección"
                                                           value="<%= actualUsuario.getDireccion()%>">                                                    
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="auCiudad" class="col-sm-4 control-label">Telefono:</label>
                                                <div class="col-sm-8">
                                                    <div class="input-group">
                                                        <span class="input-group-btn">
                                                            <button class="btn btn-default" data-toggle="modal" data-target="#modalNumeros" type="button">Ver o agregar números</button>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <center>
                                            <input type="button" data-toggle="modal" data-target="#modalConfirmarActualizar" class="btn btn-success" value="Actualizar Datos">
                                        </center>
                                        <input type="hidden" name="auEnviar" value="ok">
                                    </form>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="well-sm">
                                    <h4 class="text-center"><%= actualUsuario.getNombres() + " " + actualUsuario.getApellidos()%></h4>
                                </div>
                                <p></p>
                                <a href="#" data-toggle="modal" data-target="#modalSubirFoto">
                                    <img 
                                        <%
                                            if (actualUsuario.getImagen() != null) {
                                                out.print("src='../" + actualUsuario.getImagen() + "'");
                                                out.print("data-toggle='tooltip' title='Presione clic para cambiar su foto'");
                                            } else {
                                                out.print("src='../img/avatars/user.png' ");
                                                out.print("data-toggle='tooltip' title='Presione clic para cambiar su foto'");
                                            }
                                        %>                                             
                                        alt="Imagen de perfil de usuario" class="img-thumbnail">
                                </a>                                
                            </div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                                <div class="panel panel-default">
                                    <div class="panel-heading" role="tab" id="headingOne">
                                        <h4 class="panel-title">
                                            <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                                Reportar una queja.
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
                                        <div class="panel-body">
                                            Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading" role="tab" id="headingTwo">
                                        <h4 class="panel-title">
                                            <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                                Denunciar Usuario.
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                                        <div class="panel-body">
                                            Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading" role="tab" id="headingThree">
                                        <h4 class="panel-title">
                                            <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                                Desactivar mi cuenta.
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
                                        <div class="panel-body">
                                            Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Fin de contenedor de contenido especifico -->   
                    </div>
                    <!-- Contenedor de Segundo-->
                </div>
                <!-- Fin de contenedor Principal de la Página -->

                <div class="row">
                    <!-- Footer (Nota: Escribir el código que permita que esto quede abajo fijo) -->
                    <div class="col-md-12">                    
                        <ol class="breadcrumb container-fluid">
                            <em class="text-center"><span class="a">Todos los derechos reservados</span> / <a href="http://getbootstrap.com/" class="a" >Bootstrap</a> / <a class="a" href="http://fortawesome.github.io/Font-Awesome/">Font-Awesome</a> / <a class="a" href="http://jquery.com/">JQuery</a></em>
                            <em class="pull-right"><a href="#" class="a" data-toggle="modal" data-target="#modalContactenos">Contactar un Administrador</a></em>
                        </ol>
                    </div>
                    <!-- Fin del Footer -->
                </div>



                <!-- Ventanas Modales -->
                <!-- Confirmación para actualizar datos -->
                <div class="modal fade bs-example-modal-sm" id="modalConfirmarActualizar" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-sm">
                        <div class="modal-content">
                            <div class="modal-body">
                                <p class="text-center lead">¿Está seguro que desea modificar sus datos?</p>
                                <center>
                                    <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                                    <button type="button" class="btn btn-success" onclick="enviarFormulario('formActualizarUsuario')">Actualizar Datos</button>
                                </center>                                        
                            </div>                                                                                                               
                        </div>
                    </div>
                </div>
                <!-- Fin de confirmación para actualiazar datos -->

                <!-- Cambiar Contraseña -->
                <div class="modal fade" id="modalCambiarClave" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title text-center" id="myModalLabel">Cambiar Contraseña</h4>
                            </div>
                            <div class="modal-body">

                                <form class="form-horizontal">
                                    <div class="form-group has-error has-feedback">
                                        <label for="ccClaveAntigua" class="col-sm-4 control-label">Contraseña Antigua</label>
                                        <div class="col-sm-7">
                                            <input type="password" class="form-control" 
                                                   id="ccClaveAntigua" placeholder="Ingrese la contraseña antigua"
                                                   name="ccClaveAntigua">
                                            <!-- Al momento de validar, se le manda la class a la i para agregar icon-->
                                            <i class="glyphicon glyphicon-remove form-control-feedback"></i>
                                        </div>
                                    </div>

                                    <div class="form-group has-warning has-feedback">
                                        <label for="ccClaveNueva" class="col-sm-4 control-label">Nueva Contraseña</label>
                                        <div class="col-sm-7">                                                        
                                            <input type="password" class="form-control" 
                                                   id="ccClaveNueva" placeholder="Ingrese una nueva contraseña"
                                                   name="ccClaveNueva">
                                            <!-- Al momento de validar, se le manda la class a la i para agregar icon-->
                                            <i class="glyphicon glyphicon-exclamation-sign form-control-feedback"></i>
                                        </div>
                                    </div>

                                    <div class="form-group has-success has-feedback">
                                        <label for="ccClaveRepetida" class="col-sm-4 control-label">Repetir Contraseña</label>
                                        <div class="col-sm-7">
                                            <input type="password" class="form-control" 
                                                   id="ccClaveRepetida" placeholder="Repita la contraseña"
                                                   name="ccClaveRepetida">
                                            <!-- Al momento de validar, se le manda la class a la i para agregar icon-->
                                            <i class="glyphicon glyphicon-ok form-control-feedback"></i>
                                        </div>
                                    </div>
                                </form>                                                                                        
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                                <button type="button" class="btn btn-success">Cambiar Contraseña</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Fin de Cambiar Contraseña -->            

                <!-- Subir foto de perfil -->
                <div class="modal fade" id="modalSubirFoto" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title text-center" id="myModalLabel">Subir una foto de perfil</h4>
                            </div>
                            <div class="modal-body">
                                <form  method="post" action="../SubirFotoPerfil" enctype="multipart/form-data" id="formSubirImagen">
                                    <div class="form-group">
                                        <label for="foPerfil">Imagen de Perfil</label>
                                        <input type="file" name="imagenFoto">

                                        <input type="submit" value="Upload">

                                        <input type="file" name="foPerfil" id="foPerfil">
                                        <p class="help-block">Sólo se permite subir imágenes tipo JPG y PNG.</p>
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                                <button type="submit" class="btn btn-default" onclick="enviarFormulario('formSubirImagen')">Colocar Foto</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Fin para Subir foto de perfil -->

                <!-- Formulario de Contáctenos -->
                <div class="modal fade" id="modalContactenos" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title text-center" id="myModalLabel">Contáctenos | Farmer's Market</h4>
                            </div>
                            <div class="modal-body">
                                <form class="form-horizontal">
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
                                            <textarea class="form-control" rows="4" placeholder="Ingrese su mensaje para la compañía Farmer's Market"></textarea>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar</button>
                                <button type="button" class="btn btn-success">Enviar Mensaje</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Fin de formulario de Contáctenos -->

                <!-- Modal formulario para los números telefonicos -->            
                <div class="modal fade" id="modalNumeros" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h3 class="modal-title text-center" id="myModalLabel">Mis números de telefono</h3>
                            </div>
                            <div class="modal-body">
                                <form class="form-horizontal" method="POST" action="../GestionUsuarios">                                        
                                    <div class="form-group">
                                        <label for="rnNumero" class="col-sm-4 control-label">Número de telefono:</label>
                                        <div class="col-sm-7">
                                            <div class="input-group">
                                                <input type="text" class="form-control" name="rnNumero" id="rnNumero" maxlength="10" placeholder="Ingrese el número de telefon">
                                                <span class="input-group-btn">
                                                    <button class="btn btn-default" type="submit">Agrear</button>
                                                </span>
                                            </div>                                                
                                        </div>
                                    </div>                                
                                    <input type="hidden" name="rnEnviar" value="<%= actualUsuario.getIdUsuario()%>">
                                </form>                                    

                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th class="text-center">Número</th>
                                            <th class="text-center">Eliminar</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            ArrayList<TelefonoDto> misNumeros;
                                            misNumeros = (ArrayList<TelefonoDto>) faUsu.obtenerNumerosPorId(actualUsuario.getIdUsuario());
                                            if (misNumeros.size() > 0) {
                                                for (TelefonoDto t : misNumeros) {
                                        %>
                                        <tr class="text-center">
                                            <td><%= t.getNumero()%></td>
                                            <td>
                                                <a href="../GestionUsuarios?op=elite&num=<%= t.getNumero()%>"><i class="fa fa-remove"></i> Eliminar</a>&nbsp;                                            
                                            </td>
                                        </tr>
                                        <%
                                            }
                                        } else {
                                        %>
                                        <tr>
                                            <td class="text-center">No tiene números registrados</td>
                                            <td class="text-center">Registre sus número para tener más credibilidad</td>
                                        </tr>
                                        <%
                                            }
                                        %>                                                                       
                                    </tbody>
                                </table>
                            </div>                                           
                        </div>
                    </div>
                </div>
                <!-- Fin de modal para los números telefonicos -->
            </div>
    </body>
</html>
<%
    }
%>