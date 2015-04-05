<%-- 
    Document   : plantilla
    Created on : 27/02/2015, 12:22:03 PM
    Author     : kennross
--%>

<%@page import="co.modulo.ofertas.dtos.PromocionDto"%>
<%@page import="co.modulo.ofertas.dtos.OfertaDto"%>
<%@page import="co.modulo.ofertas.FOferta"%>
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
        FOferta faOfer = new FOferta();
        String pagActual = "ofertas.jsp";

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
        <title>Cliente - Farmer's Market</title>
        <script type="text/javascript">
            $(document).ready(function () {
                // Initialize tooltip
                $('[data-toggle="tooltip"]').tooltip({
                    placement: 'top'
                });

                //Iniciar el popover
                $(function () {
                    $('[data-toggle="popover"]').popover()
                })
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
                        <a class="navbar-brand" id="brandfm" href="indexc.jsp">Farmer's Market</a>
                        <div class="navbar-header">
                            <a href="mispedidosc.jsp" class="navbar-brand text-success">
                                <small>Pedidos <span class="badge info">4</span></small>
                            </a>
                            <a href="ofertas.jsp" class="navbar-brand text-success">
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
                    <div class="row">
                        <div class="well-sm">
                            <h4 class="text-center text-success">Todas las ofertas</h4>
                        </div>
                        <br>
                        <div class="col-md-12">
                            <%
                                ArrayList<OfertaDto> ofertas = (ArrayList<OfertaDto>) faOfer.obtenerOfertas();
                                if (ofertas.size() > 0) {
                                    for (OfertaDto of : ofertas) {
                                        int idOferta = of.getIdOferta();
                                        String producto = faOfer.obNombreCategoriaPorIDPA(of.getIdProductoAsociado());
                                        String productor = faUsu.obtenerNombreProductorPorIdProductoAsociado(of.getIdProductoAsociado());
                                        int diasCaduca = faOfer.obtenerDiasCaducacionOferta(of.getIdOferta());
                                        float precioUnitario = of.getPrecioCompra();
                                        float cantidadDisp = of.getCantidadDisponible();
                                        PromocionDto promoTemp = new PromocionDto();
                                        promoTemp = faOfer.obtenerPromocionPorId(of.getIdPromocion());
                                        float procentajePromo = promoTemp.getDetalle();
                                        String descripcionPromo = promoTemp.getDescripcion();
                            %>
                            <div class="media">
                                <div class="media-left">
                                    <a href="#">
                                        <img class="media-object" src="../<%= faOfer.obtenerImagenDeProductoPorIDPA(of.getIdProductoAsociado())%>" width="80" alt="Aguacate">
                                    </a>
                                </div>
                                <div class="media-body">                                    
                                    <table class="table">
                                        <tbody>
                                            <tr class="text-center text-success">
                                                <td>
                                                    <%= producto%>
                                                </td>
                                                <td>
                                                    <%= productor%>
                                                </td>
                                                <td>
                                                    Caduca en <%= diasCaduca%> dia(s)
                                                </td>
                                                <td>Precio por Kilo: <span class="text-danger">$<%=precioUnitario%></span></td>
                                                <td>Cantidad: <span class="text-danger"><%= cantidadDisp%> Kilos</span></td>
                                                <td>
                                                    <%
                                                        if (promoTemp.getIdPromocion() > 0) {
                                                    %>
                                                    <button type="button" class="btn btn-sm btn-default" data-container="body" data-toggle="popover" data-placement="top" data-content="<%= descripcionPromo%>">
                                                        Promoción 
                                                        <span class="label label-danger">
                                                            <%= procentajePromo + "%"%>
                                                        </span>
                                                    </button>
                                                    <%
                                                        } else {
                                                            out.print("0");
                                                        }
                                                    %>                                                    
                                                </td>
                                                <td>
                                                    <button class="btn btn-sm btn-success" data-toggle="modal" data-target="#modalPedido" onclick="ponerPedido('<%= producto%>', '<%= productor%>', <%= cantidadDisp%>, <%= precioUnitario%>, <%= procentajePromo%>, <%= idOferta%>)">Pedir</button>
                                                </td>
                                            </tr>                              
                                        </tbody>
                                    </table>
                                </div>
                            </div>                  
                            <%
                                }
                            %>

                            <%
                            } else {
                            %>
                            <div class="alert alert-info text-center">
                                <p><strong>:( Esto es enbarazoso </strong>No existen ofertas en el sistema.</p>
                            </div>
                            <%
                                }
                            %>                            
                        </div>
                    </div>
                    <!-- Fin de contenedor de contenido especifico -->
                </div>
                <!-- Contenedor de Segundo-->
            </div>
            <!-- Fin de contenedor Principal de la Página -->
            <p></p>
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
            
            <script type="text/javascript">
                function ponerPedido(nProducto, nProductor, cantidad, precioUni, porcentaje, idOferta) {
                    $("#nProducto").html(nProducto);
                    $("#nProductor").html(nProductor);
                    $("#cantidadDisponible").html(cantidad);
                    $("#precioUni").html(precioUni);
                    $("#porcentajePromo").html(porcentaje);
                    document.getElementById("rpOferta").setAttribute("value", idOferta);
                }

                function calcularPrecios(num1) {
                    num1 = num1.value;
                    //Calcular el precio total con base al precio unitario
                    var precioUni = $("#precioUni").html();
                    var salida = num1 * precioUni;
                    $("#precioTotal").html(salida);

                    //Calcular el precio con descuento con base al precio unitario y el porcentaje de descuento
                    var porcentajeDescuento = $("#porcentajePromo").html();
                    var menos = salida * porcentajeDescuento / 100;
                    var salida2 = salida - menos;
                    $("#precioDescuento").html(salida2);
                    document.getElementById("rpPrecioDescuento").setAttribute("value", salida2);

                }
            </script>
            <!-- Ventanas Modales -->
            <!-- Relizar un Pedido -->
            <div class="modal fade bs-example-modal-sm" id="modalPedido" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-sm">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                            <h3 class="modal-title text-center" id="mySmallModalLabel">Realizar un pedido<a class="anchorjs-link" href="#mySmallModalLabel"><span class="anchorjs-icon"></span></a></h3>
                        </div>
                        <div class="modal-body">
                            <form class="form-inline" method="POST" action="../GestionPedidos">
                                <center>                                    
                                    <h4 class="text-center" id="nProducto"></h4>
                                    <h4><span class="label label-primary" id="nProductor"></span></h4>
                                    <div class="form-group">                                    
                                        <div class="input-group">                                        
                                            <input type="text" class="form-control" id="cantidadSolicitada" name="cantidadSolicitada" onkeyup="calcularPrecios(this);" maxlength="5" placeholder="Cantidad Pedida">
                                            <div class="input-group-addon"><span id="cantidadDisponible"></span><small>/k</small> Disponible</div>
                                        </div>
                                    </div>
                                    <p></p>

                                    <span class="badge">Precio por Kilo $<span id="precioUni"></span></span>
                                    <span class="badge">Precio total $<span id="precioTotal"></span></span>
                                    <br>
                                    <span class="badge">Precio con descuento $<span id="precioDescuento"></span> al <span id="porcentajePromo"></span>%</span>
                                    <input type="hidden" name="precioDescuento" id="rpPrecioDescuento" value="">
                                    <br><br>
                                    <input type="hidden" name="rpOferta" id="rpOferta" value="">
                                    <input type="hidden" name="rpCliente" id="rpOferta" value="<%= actualUsuario.getIdUsuario()%>">
                                    <input type="hidden" name="rpEnviar" value="ok">
                                    <button type="submit" class="btn btn-primary">Realizar Pedido</button>
                                </center>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Fin de realizar un pedido-->
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
        </div>
    </body>
</html>
<%
        }
    }
%>