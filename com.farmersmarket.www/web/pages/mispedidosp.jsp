<%-- 
    Document   : plantilla
    Created on : 27/02/2015, 12:22:03 PM
    Author     : kennross
--%>

<%@page import="co.modulo.ofertas.FOferta"%>
<%@page import="co.modulo.pedidos.dtos.PedidoDto"%>
<%@page import="co.modulo.pedidos.FPedido"%>
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
        FPedido faPe = new FPedido();
        FOferta faOfer = new FOferta();
        String pagActual = "mispedidosp.jsp";

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
        <script type="text/javascript" src="../js/jquery-1.11.2.js"></script>
        <script type="text/javascript" src="../js/bootstrap.js"></script>
        <script type="text/javascript" src="../js/ajax.js"></script>
        <script type="text/javascript" src="../js/validaciones.js"></script>
        <title>Mis Pedidos - Farmer's Market</title>
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

                            <a href="mispedidosp.jsp" class="navbar-brand text-success">
                                <small>Pedidos <span class="badge info"><%= faPe.obtenerPedidosActivosProductor(actualUsuario.getIdUsuario())%></span></small>
                            </a>
                            <a href="misofertas.jsp" class="navbar-brand text-success">
                                <small>Ofertas <span class="badge info"><%= faOfer.obtenerOfertasActivasProductor(actualUsuario.getIdUsuario()) %></span></small>
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
                            <li class="active"><a class="a" href="mispedidosp.jsp">Mis Pedidos</a></li>
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
                                <!-- Titutlo -->
                                <div class="well-sm">
                                    <h4 class="text-center">Mis Pedidos</h4>
                                </div>
                                <br>
                                <!-- Formato de un pedido -->
                                <%
                                    ArrayList<PedidoDto> misPedidos;
                                    misPedidos = (ArrayList<PedidoDto>) faPe.obtenerPedidosDeProductor(actualUsuario.getIdUsuario());
                                    if (misPedidos.size() > 0) {
                                        for (PedidoDto pe : misPedidos) {
                                %>
                                <div class="panel panel-success">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            Por <a href="#" class="text-danger"><%= faUsu.obtenerNombrePorId(pe.getIdCliente())%></a> pedido el <span><%= pe.getFechaPedido()%></span>
                                            <%
                                                if (pe.getEstado() == 1) {
                                                    out.print("<span class='label label-primary pull-right'>Solicitado</span>");
                                                } else if (pe.getEstado() == 2) {
                                                    out.print("<span class='label label-success pull-right'>Entregado</span>");
                                                } else if (pe.getEstado() == 3) {
                                                    out.print("<span class='label label-danger pull-right'>Cancelado</span>");
                                                }
                                            %>
                                        </h4>
                                    </div>
                                    <div class="panel-body">
                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <th>Código Pedido</th>
                                                    <th>Producto</th>
                                                    <th>Cantidad Pedida</th>
                                                    <th>Precio Por Cantidad</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td><%= pe.getIdPedido()%></td>
                                                    <td><%= faOfer.obtenerNombreCategoriaProductoPorOferta(pe.getIdOferta())%></td>
                                                    <td><%= pe.getCantidadPedido()%></td>
                                                    <td class="text-success">$<%= pe.getPrecioTotalFinal()%></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                        <h4 class="panel-title">
                                            <%
                                                if (pe.getEstado() != 3) {
                                            %>
                                            <!-- Novedades -->
                                            <!-- link para modal para agregar novedad -->
                                            <a href="#" class="alert-danger" data-toggle="modal" data-target="#modalGestionarPedido" onclick="ponerCancelar(<%= pe.getIdPedido()%>)">
                                                <i class="fa fa-plus"></i>Cancelar Pedido
                                            </a>

                                            <a href="#" class="alert-success" data-toggle="modal" data-target="#modalGestionarPedidoEntrega" onclick="ponerEntregar(<%= pe.getIdPedido()%>)">
                                                <i class="fa fa-tint"></i> Establecer Fecha De Entrega
                                            </a>
                                            <%
                                                }
                                            %>
                                            <!-- link para modal para mostrar novedades -->
                                            <a href="#" data-toggle="modal" data-target="#modalListadoNovedades">
                                                <i class="fa fa-android pull-right"> </i> <span class="pull-right text-success">Ver Novedad(es)</span>
                                            </a>
                                            <!-- Fin de novedades -->
                                            &nbsp;
                                        </h4>
                                    </div>
                                </div>
                                <%
                                    }
                                } else {
                                %>
                                <div class="alert alert-info text-center">
                                    <p><strong>No tiene pedidos</strong> aún no tiene pedidos.</p>
                                </div>
                                <%
                                    }
                                %>
                                <!-- Fin de formato de un pedido -->
                            </div>

                            <!-- Publicidad -->
                            <div class="col-md-3">
                                <img src="../img/bann.jpg" alt="Publicidad de frutas">                                
                            </div>
                            <!-- Fin de publicidad -->
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

            <script type="text/javascript">
                function ponerCancelar(idPedido) {
                    $("#mySmallModalLabel").html("Cancelar Pedido");
                    document.getElementById("gpAccion").setAttribute("value", "cancelar");
                    document.getElementById("gpPedido").setAttribute("value", idPedido);
                }
                
                function ponerEntregar(idPedido) {
                    $("#mySmallModalLabel2").html("Fecha de entregado");
                    document.getElementById("gpAccionE").setAttribute("value", "entregado");
                    document.getElementById("gpPedidoE").setAttribute("value", idPedido);
                }
            </script>

            <!-- Ventanas Modales -->
            <!-- Cancelar un Pedido -->
            <div class="modal fade bs-example-modal-sm" id="modalGestionarPedido" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-sm">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                            <h3 class="modal-title text-center" id="mySmallModalLabel"><a class="anchorjs-link" href="#mySmallModalLabel"><span class="anchorjs-icon"></span></a></h3>
                        </div>
                        <div class="modal-body">
                            <form method="POST" action="../GestionPedidos">
                                <center>                                    
                                    <div class="col-sm-12">
                                        <textarea class="form-control text-center" maxlength="140" rows="4" name="gpComentario" placeholder="Agregue un comentario (obligatorio)" required></textarea>
                                    </div>                                                                        
                                    <br><br><br><br><br>
                                    <input type="hidden" name="gpAccion" id="gpAccion" value="">
                                    <input type="hidden" name="gpPedido" id="gpPedido" value="">
                                    <input type="hidden" name="gpEnviar" value="misproductosc">
                                    <button type="submit" class="btn btn-success">Enviar</button>
                                </center>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Fin de Cancelar un Pedido -->
            <!-- Entregar un Pedido -->
            <div class="modal fade bs-example-modal-sm" id="modalGestionarPedidoEntrega" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-sm">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                            <h3 class="modal-title text-center" id="mySmallModalLabel2"><a class="anchorjs-link" href="#mySmallModalLabel"><span class="anchorjs-icon"></span></a></h3>
                        </div>
                        <div class="modal-body">
                            <form method="POST" action="../GestionPedidos">
                                <center>                                    
                                    <div class="col-sm-12">
                                        <textarea class="form-control text-center" maxlength="140" rows="4" name="gpComentario" placeholder="Agregue un comentario (obligatorio)" required></textarea>
                                    </div>
                                    <br><br><br><br><br>
                                    <div class="col-sm-12">
                                        <input type="date" class="form-control" name="gpFechaEntrega" id="gpFechaEntrega">
                                    </div>
                                    <br><br>
                                    <input type="hidden" name="gpAccionE" id="gpAccionE" value="">
                                    <input type="hidden" name="gpPedidoE" id="gpPedidoE" value="">
                                    <input type="hidden" name="gpEnviar" value="misproductosc.jsp">
                                    <button type="submit" class="btn btn-success">Enviar</button>
                                </center>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Fin de Entregar un Pedido -->
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
            <!-- Listado de novedades por pedido -->
            <div class="modal fade" id="modalListadoNovedades">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title"><strong>Novedades del pedido</strong> <smal>con código: 378499</smal></h4>
                        </div>
                        <div class="modal-body">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    <h3 class="panel-title">
                                        <strong>Estado:</strong>
                                        <span>Cancelado</span>

                                        <div class="pull-right">
                                            <strong>Fecha de novedad:</strong>
                                            <span>17 de Abril de 2015</span>                                                                                                                                                                
                                        </div>
                                    </h3>                                                
                                </div>
                                <div class="panel-body">
                                    <p>
                                        Some default panel content here. 
                                        Nulla vitae elit libero, a pharetra augue. 
                                        Aenean lacinia bibendum nulla sed consectetur. 
                                        Aenean eu leo quam. Pellentesque ornare sem lacinia 
                                        quam venenatis vestibulum. Nullam id dolor id nibh 
                                        ultricies vehicula ut id elit.
                                    </p>
                                </div>
                            </div>                            
                        </div>                                    
                    </div>
                </div>
            </div>
            <!-- Fin de listado de novedades por pedido -->
            <!-- Fin de Ventanas Modales-->
        </div>
    </body>
</html>
<%
        }
    }
%>

