package co.modulo.ofertas.daos;

import co.utilidades.Conexion;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author kennross
 */
public class ProductoAsociadoDao {

    PreparedStatement pstm = null;
    int rtdo;
    ResultSet rs = null;
    String mensaje = "";
    String sqlTemp = "";
    boolean poder = false;

    public String insertProductoAsociado(long idProductor, int[] idProducto, Connection unaConexion) {
        try {
            String sqlInsert = "INSERT INTO `productosasociados`(`idProductor`, `idProducto`, `idProductoAsociado`) VALUES (?, ?, null)";
            pstm = unaConexion.prepareStatement(sqlInsert);

            for (int i = 0; i < idProducto.length; i++) {
                pstm.setLong(1, idProductor);
                pstm.setInt(2, idProducto[i]);
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

    public String eliminarUnProductoAsociado(int idProductoAsociado, Connection unaConexion) {
        try {
            String sqlInsert = " DELETE FROM productosasociados WHERE idProductoAsociado = ?";
            pstm = unaConexion.prepareStatement(sqlInsert);

            pstm.setInt(1, idProductoAsociado);
            rtdo = pstm.executeUpdate();

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

    //Contar el número de productos que tiene un usuario
    public String obtenerNumeroProductosAsociados(long idProductor, Connection unaConexion) {
        try {
            String sqlInsert = "SELECT count(idProducto) as Cantidad FROM productosasociados WHERE idProductor= ?";
            pstm = unaConexion.prepareStatement(sqlInsert);
            pstm.setLong(1, idProductor);
            rs = pstm.executeQuery();

            while (rs.next()) {
                mensaje = rs.getString("Cantidad");
            }

        } catch (SQLException sqle) {
            mensaje = "Error, detalle " + sqle.getMessage();
        }
        return mensaje;
    }

    //Validar producto ya asociado
    public boolean validarYaProdAso(long idProductor, int idProducto, Connection unaConexion) {
        try {
            String sqlInsert = "SELECT idProductoAsociado FROM productosasociados WHERE idProductor = ? AND idProducto = ?";
            pstm = unaConexion.prepareStatement(sqlInsert);
            pstm.setLong(1, idProductor);
            pstm.setInt(2, idProducto);
            rs = pstm.executeQuery();

            while (rs.next()) {
                rtdo = rs.getInt("idProductoAsociado");
            }

            if (rtdo == 0) {
                poder = true;
            }
        } catch (SQLException sqle) {
            mensaje = "Error, detalle " + sqle.getMessage();
        }
        return poder;
    }

    //Validar producto ya asociado
    public int obtenerIdPA(long idProductor, int idProducto, Connection unaConexion) {
        try {
            String sqlInsert = "SELECT idProductoAsociado FROM productosasociados WHERE idProductor = ? AND idProducto = ?";
            pstm = unaConexion.prepareStatement(sqlInsert);
            pstm.setLong(1, idProductor);
            pstm.setInt(2, idProducto);
            rs = pstm.executeQuery();

            while (rs.next()) {
                rtdo = rs.getInt("idProductoAsociado");
            }

        } catch (SQLException sqle) {
            mensaje = "Error, detalle " + sqle.getMessage();
        }
        return rtdo;
    }

    //Validar producto ya asociado
    public boolean validarProductoOfertado(int idProductoAsociado, Connection unaConexion) {
        try {
            String sqlInsert = "SELECT idProductoAsociado FROM ofertas WHERE idProductoAsociado = ?";
            pstm = unaConexion.prepareStatement(sqlInsert);
            pstm.setLong(1, idProductoAsociado);
            rs = pstm.executeQuery();

            while (rs.next()) {
                rtdo = rs.getInt("idProductoAsociado");
            }

            if (rtdo == 0) {
                poder = true;
            }
        } catch (SQLException sqle) {
            mensaje = "Error, detalle " + sqle.getMessage();
        }
        return poder;
    }
    
    //Mostrar el número disponible de cupos para asociar
    public String obtenerCuposDisponibles(long idProductor, Connection unaConexion) {
        try {
            String sqlInsert = "SELECT count(idProducto) as Cantidad FROM productosasociados WHERE idProductor= ?";
            pstm = unaConexion.prepareStatement(sqlInsert);
            pstm.setLong(1, idProductor);
            rs = pstm.executeQuery();

            while (rs.next()) {
                rtdo = rs.getInt("Cantidad");
            }
            
            mensaje = (7 - rtdo) + "";

        } catch (SQLException sqle) {
            mensaje = "Error, detalle " + sqle.getMessage();
        }
        return mensaje;
    }
}
