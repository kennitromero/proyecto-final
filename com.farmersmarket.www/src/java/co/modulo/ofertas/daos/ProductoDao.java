package co.modulo.ofertas.daos;

import co.modulo.ofertas.dtos.ProductoDto;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author kennross
 */
public class ProductoDao {

    PreparedStatement pstm = null;
    int rtdo;
    ResultSet rs = null;
    String mensaje = "";
    String sqlTemp = "";

    public List obtenerProductos(Connection unaConexion) {
        ArrayList<ProductoDto> todosProductos = null;
        sqlTemp = "SELECT `idProducto`, `Nombres`, `idCategoria`, `Imagen` FROM `productos`";
        try {
            pstm = unaConexion.prepareStatement(sqlTemp);
            rs = pstm.executeQuery();

            todosProductos = new ArrayList();
            while (rs.next()) {
                ProductoDto productoTemp = new ProductoDto();
                productoTemp.setIdProducto(rs.getInt("idProducto"));
                productoTemp.setNombre(rs.getString("Nombres"));
                productoTemp.setIdCategoria(rs.getInt("idCategoria"));
                productoTemp.setImagen(rs.getString("Imagen"));
                todosProductos.add(productoTemp);
            }
        } catch (SQLException ex) {
            System.out.println("Error, detalle: " + ex.getMessage());
        }
        return todosProductos;
    }

    public List obtenerProductosPorId(long idUsuario, Connection unaConexion) {
        ArrayList<ProductoDto> misProductos = null;
        sqlTemp = "SELECT p.idProducto, p.Nombres, p.idCategoria, p.Imagen FROM productos as p "
                + "JOIN productosasociados as pa on (p.idProducto = pa.idProducto) "
                + "JOIN usuarios as u on (u.idUsuario = pa.idProductor) WHERE u.idUsuario = ? AND pa.Estado = 1";
        try {
            pstm = unaConexion.prepareStatement(sqlTemp);
            pstm.setLong(1, idUsuario);
            rs = pstm.executeQuery();

            misProductos = new ArrayList();
            while (rs.next()) {
                ProductoDto productoTemp = new ProductoDto();
                productoTemp.setIdProducto(rs.getInt("idProducto"));
                productoTemp.setNombre(rs.getString("Nombres"));
                productoTemp.setIdCategoria(rs.getInt("idCategoria"));
                productoTemp.setImagen(rs.getString("Imagen"));
                misProductos.add(productoTemp);
            }
        } catch (SQLException ex) {
            System.out.println("Error, detalle: " + ex.getMessage());
        }
        return misProductos;
    }

    public List obtenerProductosPedidosPoridProductor(long idProductor, Connection unaConexion) {
        ArrayList<ProductoDto> misProductos = null;
        sqlTemp = "SELECT p.idProducto, p.Nombres, idCategoria, p.Imagen, ROUND(((i.Cantidad - o.Cantidad) / i.Cantidad) * 100) as rt "
                + "FROM productos as p "
                + "JOIN productosasociados as pa on (p.idProducto = pa.idProducto) "
                + "JOIN ofertas as o ON (o.idProductoAsociado = pa.idProductoAsociado) "
                + "JOIN pedidos as pe ON (pe.idOferta = o.idOferta) "
                + "JOIN inventario as i ON (i.idOferta = o.idOferta) "
                + "JOIN usuarios as u ON (u.idUsuario = pa.idProductor) "
                + "WHERE u.idUsuario = ? AND pe.idEstado = 1";
        try {
            pstm = unaConexion.prepareStatement(sqlTemp);
            pstm.setLong(1, idProductor);
            rs = pstm.executeQuery();

            misProductos = new ArrayList();
            while (rs.next()) {
                ProductoDto productoTemp = new ProductoDto();
                productoTemp.setIdProducto(rs.getInt("idProducto"));
                productoTemp.setNombre(rs.getString("Nombres"));
                productoTemp.setIdCategoria(rs.getInt("idCategoria"));
                productoTemp.setImagen(rs.getString("rt"));
                misProductos.add(productoTemp);
            }
        } catch (SQLException ex) {
            System.out.println("Error, detalle: " + ex.getMessage());
        }
        return misProductos;
    }

    public ProductoDto obtenerProductoIdProducoAso(int idProductoAso, Connection unaConexion) {
        ProductoDto productoTemp = null;
        sqlTemp = "SELECT p.idProducto, Nombres, idCategoria, Imagen FROM productos as p "
                + "JOIN productosasociados as pa on (p.idProducto = pa.idProducto) WHERE idProductoAsociado = ?";
        try {
            pstm = unaConexion.prepareStatement(sqlTemp);
            pstm.setLong(1, idProductoAso);
            rs = pstm.executeQuery();

            while (rs.next()) {
                productoTemp = new ProductoDto();
                productoTemp.setIdProducto(rs.getInt("idProducto"));
                productoTemp.setNombre(rs.getString("Nombres"));
                productoTemp.setIdCategoria(rs.getInt("idCategoria"));
                productoTemp.setImagen(rs.getString("Imagen"));
            }
        } catch (SQLException ex) {
            System.out.println("Error, detalle: " + ex.getMessage());
        }
        return productoTemp;
    }

    public String obtenerNombreCategoriaPorIdPA(int idProductoAsociado, Connection unaConexion) {
        sqlTemp = "SELECT concat(p.Nombres, ' <strong>(', c.Descripcion, ')</strong>') as NombreCategoria FROM productos as p JOIN categorias as c on (p.idCategoria = c.idCategoria) JOIN productosAsociados as pa on (pa.idProducto = p.idProducto) WHERE idProductoAsociado = ?";
        try {
            pstm = unaConexion.prepareStatement(sqlTemp);
            pstm.setLong(1, idProductoAsociado);
            rs = pstm.executeQuery();

            while (rs.next()) {
                mensaje = rs.getString("NombreCategoria");
            }
        } catch (SQLException ex) {
            mensaje = ex.getMessage();
        }
        return mensaje;
    }

    public String obtenerNombreCategoriaPorIdOferta(int idOferta, Connection unaConexion) {
        sqlTemp = "SELECT concat(p.Nombres, ' <strong>(', c.Descripcion, ')</strong>') as NombreCategoria "
                + "FROM productos as p "
                + "JOIN categorias as c on (p.idCategoria = c.idCategoria) "
                + "JOIN productosasociados as pa on (pa.idProducto = p.idProducto) "
                + "JOIN ofertas as o ON (o.idProductoAsociado = pa.idProductoAsociado) "
                + "JOIN pedidos as pe ON (pe.idOferta = o.idOferta) "
                + "WHERE o.idOferta = ?";
        try {
            pstm = unaConexion.prepareStatement(sqlTemp);
            pstm.setLong(1, idOferta);
            rs = pstm.executeQuery();

            while (rs.next()) {
                mensaje = rs.getString("NombreCategoria");
            }
        } catch (SQLException ex) {
            mensaje = ex.getMessage();
        }
        return mensaje;
    }

    public int[] obtenerIdProductos(Connection unaConexion) {
        sqlTemp = "SELECT `idProducto`, `Nombres`, `idCategoria`, `Imagen` FROM `productos` WHERE idProducto = 102001";
        int[] ids = new int[88];
        try {
            pstm = unaConexion.prepareStatement(sqlTemp);
            rs = pstm.executeQuery();

            for (int i = 1; i < rs.getRow(); i++) {
                ids[i] = rs.getInt("idProducto");
                System.out.println(rs.getInt("idProducto"));
            }
        } catch (SQLException ex) {
            System.out.println("Error, detalle: " + ex.getMessage());
        }
        return ids;
    }

    public String insertarImagenes(ArrayList<ProductoDto> ps, Connection unaConexion) {
        try {
            String sqlInsert = "UPDATE productos SET Imagen = 'img/productos/acelga.png' WHERE idProducto = ?";
            pstm = unaConexion.prepareStatement(sqlInsert);

            for (ProductoDto p : ps) {
                pstm.setInt(1, p.getIdProducto());
                rtdo = pstm.executeUpdate();
            }

            if (rtdo != 0) {
                mensaje = "ok";
            } else {
                mensaje = "okno";
            }
        } catch (SQLException sqle) {
            mensaje = "Error, detalle " + sqle.getMessage();
        }
        return mensaje;
    }

    public String obtenerImagenPorIdPA(int idProductoAsociado, Connection unaConexion) {
        sqlTemp = "SELECT Imagen FROM productos as p "
                + "JOIN productosasociados as pa on (p.idProducto = pa.idProducto) "
                + "JOIN ofertas as o on (o.idProductoAsociado = pa.idProductoAsociado) "
                + "WHERE o.idProductoAsociado = ?";
        try {
            pstm = unaConexion.prepareStatement(sqlTemp);
            pstm.setLong(1, idProductoAsociado);
            rs = pstm.executeQuery();

            while (rs.next()) {
                mensaje = rs.getString("Imagen");
            }
        } catch (SQLException ex) {
            mensaje = ex.getMessage();
        }
        return mensaje;
    }
}
