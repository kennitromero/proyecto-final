<%@page import="co.modulo.ofertas.dtos.OfertaDto"%>
<%@page import="co.modulo.ofertas.FOferta"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <%
            OfertaDto oDto;

            FOferta faOfer = new FOferta();

            int idOferta = Integer.parseInt(request.getParameter("idOferta"));
            String nombreCategoriaProducto = request.getParameter("nombreCategoriaProducto");

            oDto = faOfer.obtenerOfertaPorId(idOferta);
        %>

    <legend class="text-center"><%= nombreCategoriaProducto%></legend>

    <div class="input-group">
        <span class="input-group-addon">Precio $</span>
        <input type="number" name="opaPrecioVenta" value="<%= oDto.getPrecioCompra()%>" class="form-control" aria-label="Amount (to the nearest dollar)">
        <span class="input-group-addon">.00 * Kilo</span>
    </div>
    <br>
    <div class="input-group">
        <span class="input-group-addon">Cantidad</span>
        <input type="number" name="opaCantidad" value="<%= oDto.getCantidadDisponible()%>" class="form-control" aria-label="Amount (to the nearest dollar)">
        <span class="input-group-addon">.00 de Kilo</span>
    </div>
    <input type="hidden" name="opaEnviar" value="ok">
    <input type="hidden" name="opaIdOferta" value="<%= oDto.getIdOferta()%>"
</body>
</html>
