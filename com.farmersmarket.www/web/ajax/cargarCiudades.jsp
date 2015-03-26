<%-- 
    Document   : cargarCiudades
    Created on : 7/03/2015, 08:48:47 AM
    Author     : kennross
--%>
<%@page import="co.modulo.usuarios.FUsuario"%>
<%@page import="co.modulo.usuarios.daos.CiudadDao"%>
<%@page import="co.modulo.usuarios.dtos.CiudadDto"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ciudades</title>
    </head>
    <body>
        <%
            FUsuario faUsu = new FUsuario();
            ArrayList<CiudadDto> ciudades = new ArrayList();

            if (request.getParameter("idDepartamento") != null) {

                ciudades = (ArrayList<CiudadDto>) faUsu.obtenerCiudadesPorDepartamento(Integer.parseInt(request.getParameter("idDepartamento")));
                if (ciudades.size() > 0) {
                    for (CiudadDto cDatos : ciudades) {
                        out.write("<option value = " + cDatos.getIdCiudad() + ">" + cDatos.getNombre() + "</option>");

                    }
                }
            }
        %>
    </body>
</html>
