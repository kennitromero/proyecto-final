/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package co.modulo.ofertas.daos;

import co.modulo.ofertas.dtos.OfertaDto;
import co.modulo.ofertas.dtos.PromocionDto;
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
public class OfertaDao {

    PreparedStatement pstm = null;
    int rtdo;
    ResultSet rs = null;
    String mensaje = "";
    String sqlTemp = "";
    boolean poder = false;

    public List obtenerOfertasPorProductor(long idProductor, Connection unaConexion) {
        ArrayList<OfertaDto> misOfertas = null;
        sqlTemp = "SELECT o.idOferta, o.idProductoAsociado, o.PrecioVente, o.FechaInicio, "
                + "o.FechaFin, o.Cantidad, o.idPromocion, o.idEstadoOferta FROM ofertas as o "
                + "JOIN productosasociados as pa on (o.idProductoAsociado = pa.idProductoAsociado) "
                + "JOIN usuarios as u on (u.idUsuario = pa.idProductor) WHERE u.idUsuario = ?";
        try {
            pstm = unaConexion.prepareStatement(sqlTemp);
            pstm.setLong(1, idProductor);
            rs = pstm.executeQuery();

            misOfertas = new ArrayList();
            while (rs.next()) {
                OfertaDto temp = new OfertaDto();
                temp.setIdOferta(rs.getInt("idOferta"));
                temp.setIdProductoAsociado(rs.getInt("idProductoAsociado"));
                temp.setPrecioCompra(rs.getFloat("PrecioVente"));
                temp.setFechaInicio(rs.getString("FechaInicio"));
                temp.setFechaFin(rs.getString("FechaFin"));
                temp.setCantidadDisponible(rs.getFloat("Cantidad"));
                temp.setIdPromocion(rs.getInt("idPromocion"));
                temp.setEstado(rs.getInt("idEstadoOferta"));
                misOfertas.add(temp);
            }
        } catch (SQLException ex) {
            System.out.println("Error, detalle: " + ex.getMessage());
        }
        return misOfertas;
    }

    public String insertOfertaProcedimiento(OfertaDto nuevaOferta, PromocionDto suPromocion, Connection unaConexion) {
        try {
            String sqlInsert = "CALL ProceRegistrarOfertaPromocion(?, ?, ?, ?, ?, ?)";
            pstm = unaConexion.prepareCall(sqlInsert);

            pstm.setInt(1, nuevaOferta.getIdProductoAsociado());
            pstm.setFloat(2, nuevaOferta.getPrecioCompra());
            pstm.setFloat(3, nuevaOferta.getCantidadDisponible());
            pstm.setString(4, suPromocion.getDescripcion());
            pstm.setFloat(5, suPromocion.getDetalle());
            pstm.setInt(6, nuevaOferta.getEstado());

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

    public String insertPromocion(PromocionDto suPromocion, int idOferta, Connection unaConexion) {
        try {
            String sqlInsert = "CALL ProceAgregarPromocion (?, ?, ?)";
            pstm = unaConexion.prepareCall(sqlInsert);

            pstm.setInt(1, idOferta);
            pstm.setString(2, suPromocion.getDescripcion());
            pstm.setFloat(3, suPromocion.getDetalle());

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

    public String deleteOferta(int idOferta, Connection unaConexion) {
        try {
            String sqlInsert = "DELETE FROM `ofertas` WHERE idOferta = ?";
            pstm = unaConexion.prepareCall(sqlInsert);

            pstm.setInt(1, idOferta);

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

    public String insertOferta(OfertaDto nuevaOferta, Connection unaConexion) {
        try {
            //1-idProductoAsociado | 2-PrecioVenta | 3-Cantidad | 4-idPromocion | 5-idEstado
            String sqlInsert = "INSERT INTO ofertas VALUES (null, ?, ?, now(), adddate(now(),8), ?, ?, ?)";
            pstm = unaConexion.prepareStatement(sqlInsert);

            pstm.setInt(1, nuevaOferta.getIdProductoAsociado());
            pstm.setFloat(2, nuevaOferta.getPrecioCompra());
            pstm.setFloat(3, nuevaOferta.getCantidadDisponible());
            pstm.setInt(4, 500);
            pstm.setInt(5, nuevaOferta.getEstado());

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
    
    public String updateOferta(OfertaDto ediOferta, Connection unaConexion) {
        try {
            //1-PrecioVente | 2-Cantidad | 3-idOferta
            String sqlInsert = "UPDATE ofertas SET PrecioVente = ? Cantidad = ? WHERE idOferta = ?";
            pstm = unaConexion.prepareStatement(sqlInsert);

            pstm.setFloat(1, ediOferta.getPrecioCompra());
            pstm.setFloat(2, ediOferta.getCantidadDisponible());
            pstm.setInt(3, ediOferta.getIdOferta());

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

    public int calcularCaducacionOferta(int idOferta, Connection unaConexion) {
        try {
            //1- idProductoAsociado 2- PrecioVenta 3- Cantidad 4- idPromocion 5- idEstado
            String sqlInsert = "SELECT DATEDIFF(FechaFin, FechaInicio) as Diferencia from ofertas WHERE idOferta = ?";
            pstm = unaConexion.prepareStatement(sqlInsert);

            pstm.setInt(1, idOferta);

            rs = pstm.executeQuery();
            while (rs.next()) {
                rtdo = rs.getInt("Diferencia");
            }

        } catch (SQLException sqle) {
            mensaje = "Error, detalle " + sqle.getMessage();
        }
        return rtdo;
    }

    //Validar producto ya asociado
    public boolean validarProductoPublicado(int idProductoAsociado, Connection unaConexion) {
        try {
            String sqlInsert = "SELECT o.idProductoAsociado FROM ofertas as o "
                    + "JOIN productosasociados as pa on (pa.idProductoAsociado = o.idProductoAsociado) "
                    + "WHERE o.idProductoAsociado = ?";
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

    //Validar y Mostrar el número disponible de cupos para publicar ofertas
    public int obtenerCuposParaOfertar(long idProductor, Connection unaConexion) {
        try {
            String sqlInsert = "SELECT count(o.idProductoAsociado) as Cantidad FROM ofertas as o "
                    + "JOIN productosasociados as pa on (o.idProductoAsociado = pa.idProductoAsociado) "
                    + "WHERE idProductor = ? AND idEstadoOferta = 1;";
            pstm = unaConexion.prepareStatement(sqlInsert);
            pstm.setLong(1, idProductor);
            rs = pstm.executeQuery();

            while (rs.next()) {
                rtdo = rs.getInt("Cantidad");
            }

        } catch (SQLException sqle) {
            mensaje = "Error, detalle " + sqle.getMessage();
        }
        return rtdo;
    }
}
