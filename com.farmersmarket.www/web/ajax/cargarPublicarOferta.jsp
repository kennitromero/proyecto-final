<%-- 
    Document   : cargarPublicarOferta
    Created on : 24/03/2015, 12:05:25 AM
    Author     : kennross
--%>

<%@page import="co.modulo.usuarios.FUsuario"%>
<%@page import="co.modulo.ofertas.FOferta"%>
<%@page import="co.modulo.usuarios.dtos.UsuarioDto"%>
<%@page import="co.modulo.ofertas.dtos.ProductoDto"%>
<%@page import="co.modulo.ofertas.dtos.OfertaDto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
        <title>Oferta</title>
    </head>
    <body>
        <%
            OfertaDto oDto;
            ProductoDto pDto;

            FOferta faOfer = new FOferta();

            int idProductoAso = Integer.parseInt(request.getParameter("idProducoAso"));

            pDto = faOfer.obtenerProductoConIdProductoAso(idProductoAso);
        %>       


        <strong><%= pDto.getNombre()%></strong> (<%= faOfer.obtenerNombreDeCategoriaPorId(pDto.getIdCategoria())%>)
        <input type="hidden" name="idProductoAsociado" value="<%= idProductoAso%>">

    </body>
</html>
