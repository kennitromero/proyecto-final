package co.modulo.ofertas.daos;

import co.modulo.ofertas.dtos.PromocionDto;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author kennross
 */
public class PromocionDao {
    PreparedStatement pstm = null;
    int rtdo;
    ResultSet rs = null;
    String mensaje = "";
    String sqlTemp = "";
    
    public PromocionDto obtenerPromocionOferta(int idOferta, Connection unaConexion) {
        PromocionDto promoOfer = null;
        sqlTemp = "SELECT pro.idPromocion, Descripcion, Detalle FROM promociones as pro "
                + "JOIN ofertas as of on (of.idPromocion = pro.idPromocion) WHERE of.idOferta = ?";
        try {
            pstm = unaConexion.prepareStatement(sqlTemp);
            pstm.setLong(1, idOferta);
            rs = pstm.executeQuery();

            while (rs.next()) {
                promoOfer = new PromocionDto();
                promoOfer.setIdPromocion(rs.getInt("idPromocion"));
                promoOfer.setDescripcion(rs.getString("Descripcion"));
                promoOfer.setDetalle(rs.getFloat("Detalle"));                
            }
        } catch (SQLException ex) {
            System.out.println("Error, detalle: " + ex.getMessage());
        }
        return promoOfer;
    }
    
    public PromocionDto obtenerPromocionId(int idPromocion, Connection unaConexion) {
        PromocionDto promoOfer = null;
        sqlTemp = "SELECT idPromocion, Descripcion, Detalle FROM promociones WHERE idPromocion = ?";
        try {
            pstm = unaConexion.prepareStatement(sqlTemp);
            pstm.setLong(1, idPromocion);
            rs = pstm.executeQuery();

            while (rs.next()) {
                promoOfer = new PromocionDto();
                promoOfer.setIdPromocion(rs.getInt("idPromocion"));
                promoOfer.setDescripcion(rs.getString("Descripcion"));
                promoOfer.setDetalle(rs.getFloat("Detalle"));                
            }
        } catch (SQLException ex) {
            System.out.println("Error, detalle: " + ex.getMessage());
        }
        return promoOfer;
    }
    
    public String updatePromocion(PromocionDto ediPromocion, Connection unaConexion) {
        try {
            //1-Descripcion | 2-Detalle | 3-idPromocion
            String sqlInsert = "UPDATE promociones SET Descripcion = ?, Detalle = ? WHERE idPromocion = ?";
            pstm = unaConexion.prepareStatement(sqlInsert);

            pstm.setString(1, ediPromocion.getDescripcion());
            pstm.setFloat(2, ediPromocion.getDetalle());
            pstm.setInt(3, ediPromocion.getIdPromocion());

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
}
