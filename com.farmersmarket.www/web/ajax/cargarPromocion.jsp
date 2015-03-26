<%-- 
    Document   : cargarPromocion
    Created on : 26/03/2015, 12:51:59 PM
    Author     : kennross
--%>

<%@page import="co.modulo.ofertas.FOferta"%>
<%@page import="co.modulo.ofertas.dtos.PromocionDto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            PromocionDto pDto;

            FOferta faOfer = new FOferta();

            int idPromocion = Integer.parseInt(request.getParameter("idPromocion"));

            pDto = faOfer.obtenerPromocionPorId(idPromocion);
        %>
        <div class="input-group">
            <span class="input-group-addon">Descuento del: </span>
            <input type="number" name="opacDetalle" value="<%= pDto.getDetalle()%>" class="form-control" aria-label="Amount (to the nearest dollar)">
            <span class="input-group-addon">.%</span>
        </div>
        <br>
        <textarea class="form-control" rows="3" name="opacDescripcionPromocion" maxlength="140" placeholder="Una breve descripción de la promoción (Máx 140 carácteres)"><%= pDto.getDescripcion()%></textarea>
        <input type="hidden" name="opacidPromocion" value="<%= pDto.getIdPromocion()%>">
        <input type="hidden" name="opacEnviar" value="Actualizar">
    </body>
</html>
