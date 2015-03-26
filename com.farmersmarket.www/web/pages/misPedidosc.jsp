<%-- 
    Document   : plantilla
    Created on : 27/02/2015, 12:22:03 PM
    Author     : kennross
--%>

<%@page import="modelo.daos.PermisoDao"%>
<%@page import="modelo.dtos.RolDto"%>
<%@page import="modelo.dtos.PedidosDto"%>
<%@page import="modelo.daos.PedidoDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelo.dtos.UsuarioDto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

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

        PermisoDao permisoDao = new PermisoDao();
        String pagActual = "indexp.jsp";

        // Validación para poder entrar
        boolean poderEntrar = false;

        for (RolDto rol : rolesActuales) {
            if (rol.getIdRol() == 1) {
                poderEntrar = true;
            }
        }

        if (poderEntrar) {

%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" href="../img/favicon.ico">
        <link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="../css/font-awesome.css">
        <script type="text/javascript" src="../js/jquery-1.11.2.js"></script>
        <script type="text/javascript" src="../js/bootstrap.js"></script>
        <script type="text/javascript" src="../js/ajax.js"></script>
        <title>Mis pedidos - Farmer's Market</title>
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
                            <a href="#">
                                <img class="media-object img-circle" width="50" src="../img/avatars/avatar.png" alt="Mi foto de perfil">
                            </a>
                        </div>
                        <div class="media-body">
                            <p></p>
                            <h4 class="media-heading">Cliente</h4>
                            <%=actualUsuario.getNombres() + " " + actualUsuario.getApellidos()%>
                        </div>
                    </div>
                    <!-- Fin del rol iniciado -->
                    <hr>

                    <!-- Menú de navegación -->
                    <ul class="nav nav-pills nav-stacked">
                        <li role="presentation" class="text-left"><a href="indexc.jsp">Inicio <i class="fa fa-shopping-cart "></i></a></li>
                        <li role="presentation" class="active text-left"><a href="mis-pedidosc.jsp">Mis pedidos <i class="fa fa-shopping-cart "></i></a></li>
                        <li role="presentation" class="text-left"><a href="#">Catalogo <i class="fa fa-list-alt "></i></a></li>
                        <li role="presentation" class="text-left"><a href="ofertas.jsp">Ofertas <i class="fa fa-list-alt "></i></a></li>                        

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
                                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"> <%=actualUsuario.getNombres() + " " + actualUsuario.getApellidos()%> <span class="fa fa-chevron-down"></span></a>
                                        <ul class="dropdown-menu" role="menu">
                                            <li class="text-center"><a href="../index.jsp">Cerrar Sesión</a></li>
                                            <li class="divider"></li>
                                            <li class="text-center"><a href="#">Mi Perfil</a></li>
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
                        <li><a href="indexpc.jsp">Inicio</a></li>
                        <li class="active">Mis pedidos</li>                    
                    </ol>
                    <!-- Fin de miga de pan -->

                    <!-- Mensajes de alertas
                    <div class="alert alert-success" role="alert">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <p class="text-center"><strong><i class="glyphicon glyphicon-exclamation-sign"></i> Esto Ocurrió!</strong> Mensaje de prueba para las alertas</p>
                    </div>
                    <div class="alert alert-info" role="alert">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <p class="text-center"><strong><i class="glyphicon glyphicon-exclamation-sign"></i> Esto Ocurrió!</strong> Mensaje de prueba para las alertas</p>
                    </div>
                    <div class="alert alert-warning" role="alert">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <p class="text-center"><strong><i class="glyphicon glyphicon-exclamation-sign"></i> Esto Ocurrió!</strong> Mensaje de prueba para las alertas</p>
                    </div>
                    <div class="alert alert-danger" role="alert">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <p class="text-center"><strong><i class="glyphicon glyphicon-exclamation-sign"></i> Esto Ocurrió!</strong> Mensaje de prueba para las alertas</p>
                    </div>
                    Fin de mensajes de alertas-->

                    <!-- Contenedor de contenido especifico -->
                    <%
                        PedidoDao oDao = new PedidoDao();
                        ArrayList<PedidosDto> pedidos = (ArrayList<PedidosDto>) oDao.obtenerPedidos(actualUsuario.getIdUsuario());
                    %>
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-10">
                                <!-- Titutlo -->
                                <div class="page-header">
                                    <h2 class="text-center">Mis pedidos</h2>
                                </div>
                                <!-- Formato de un pedido -->
                                <%
                                    for (PedidosDto pedido : pedidos) {
                                %>
                                <div class="panel panel-success">
                                    <div class="panel-heading">
                                        <h2 class="panel-title">
                                            Por <em><strong><a href="#"><%=pedido.getCliente()%></a></strong></em>                                            
                                        </h2>
                                    </div>
                                    <div class="panel-body">
                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <th>Código Pedido</th>
                                                    <th>Producto</th>
                                                    <th>Presentación</th>
                                                    <th>Cantidad</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <th><%=pedido.getIdPedido()%></th>
                                                    <th><%=pedido.getProducto()%></th>
                                                    <th><%=pedido.getPresentacion()%></th>
                                                    <th><%=pedido.getCantidad()%></th>


                                                </tr>                                                
                                            </tbody>                                            
                                        </table>
                                        <span class="lead">Fecha Oferta:</span> <%=pedido.getFechaPedido()%>
                                        <div class="col-sm-4 pull-left">
                                            <select class="form-control">
                                                <option class="danger">Cancelado</option>
                                            </select>
                                        </div> 

                                    </div>
                                    <div class="panel-footer">
                                        <h3 class="panel-title">
                                            <!-- Novedades -->
                                            <!-- link para modal para agregar novedad -->
                                            <a href="">
                                                <i class="fa fa-cart-arrow-down pull-left"></i> <span class="pull-left text-success">Factura</span>
                                            </a>

                                            <!-- link para modal para mostrar novedades -->
                                            <a href="#" data-toggle="modal" ><!--data-target="#modalListadoNovedades"-->
                                                <i class="fa fa-android pull-right"> </i> <span class="pull-right text-success">Ver Novedad(es)</span>
                                            </a>                                                                                        
                                            <!-- Fin de novedades -->
                                            &nbsp;
                                        </h3>
                                    </div>
                                </div>
                                <!-- Fin de formato de un pedido -->     
                                <%
                                    }
                                %>
                            </div>

                            <!-- Publicidad -->
                            <div class="col-md-2">
                                <img src="../img/bann.jpg" alt="Publicidad de frutas">                                
                            </div>
                            <!-- Fin de publicidad -->
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
                        </div>                        

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
                                        <hr>
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
                                        <hr>
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
                                        <hr>
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
                                        <hr>
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