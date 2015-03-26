<%-- 
    Document   : error.jsp
    Created on : 20/03/2015, 08:42:11 AM
    Author     : kennross
--%>

<%@page import="java.lang.Exception"%>
<%@page import="co.modulo.usuarios.dtos.UsuarioDto"%>
<%@page import="co.modulo.ofertas.FOferta"%>
<%@page import="co.modulo.usuarios.FUsuario"%>
<%@page import="java.util.ArrayList"%>
<%@page import="co.modulo.ofertas.dtos.ProductoDto"%>
<%@page import="co.modulo.ofertas.daos.ProductoDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" import="java.util.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Página de error</title>
    </head>
    <body>
        <h1>No cometa errores >:(</h1>

        <%
            if (exception != null) {                
                exception.printStackTrace();                
            }                       
        %>
    </body>
</html>
