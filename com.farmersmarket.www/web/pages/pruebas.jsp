<%-- 
    Document   : pruebas
    Created on : 11/03/2015, 05:53:22 PM
    Author     : kennross
--%>

<%@page import="modelo.dtos.RolDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelo.dtos.UsuarioDto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
    </head>
    <body>
        <h1>Hello World!</h1>
        <%
            HttpSession miSesion = request.getSession(false);
            HttpSession miSesionRoles = request.getSession(false);

            UsuarioDto actualUsuario;
            actualUsuario = (UsuarioDto) miSesion.getAttribute("usuarioEntro");

            if (actualUsuario == null) {
                out.print("Se cerró la sesión y está null");
            } else {
                out.print("La sesión está abierta");

                ArrayList<RolDto> rolesActuales;

                actualUsuario = (UsuarioDto) miSesion.getAttribute("usuarioEntro");
                rolesActuales = (ArrayList<RolDto>) miSesionRoles.getAttribute("roles");

                out.print(miSesionRoles.getAttribute("roles"));

                RolDto primerRol = rolesActuales.get(0);
            }
        %>
        
        <p class="text-lowercase">Elige Un Trabajo Que Te Guste Y No Tendrás Que Trabajar Ni Un Día De Tu Vida.</p>
    </body>
</html>
