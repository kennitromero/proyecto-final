package co.modulo.usuarios.daos;

/**
 * @author Kennit David Ruz Romero 
 * Fecha: 4 de de Enero de 2015
 */
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import co.modulo.usuarios.dtos.DepartamentoDto;
import co.modulo.usuarios.dtos.TelefonoDto;
import co.utilidades.Conexion;

public class TelefonoDao {

    PreparedStatement pstm = null;
    int rtdo;
    ResultSet rs = null;
    String mensaje = "";
    String sqlTemp = "";

    
    public String insertTelefono(TelefonoDto nuevoTelefono, Connection unaConexion) {
        try {
            String sqlInsert = "INSERT INTO `telefonos`(`idUsuario`, `Numero`) VALUES (?, ?)";
            pstm = unaConexion.prepareStatement(sqlInsert);

            pstm.setLong(1, nuevoTelefono.getIdUsuario());
            pstm.setString(2, nuevoTelefono.getNumero());
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
    
    public List obtenerTelefonosPorId(long idUsuario, Connection unaConexion) {
        ArrayList<TelefonoDto> telefonos = null;
        sqlTemp = "SELECT `Numero` FROM `telefonos` WHERE `idUsuario` = ?";
        try {
            pstm = unaConexion.prepareStatement(sqlTemp);
            pstm.setLong(1, idUsuario);
            rs = pstm.executeQuery();
            
            telefonos = new ArrayList();
            while (rs.next()) {
                TelefonoDto temp = new TelefonoDto();
                temp.setNumero(rs.getString("Numero"));                
                telefonos.add(temp);
            }
        } catch (SQLException ex) {
            System.out.println("Error, detalle: " + ex.getMessage());
        }
        return telefonos;
    }        
    
    public String eliminarTelefono(String numero, Connection unaConexion) {
        try {
            String sqlInsert = "DELETE FROM `telefonos` WHERE `Numero` = ?";
            pstm = unaConexion.prepareStatement(sqlInsert);

            pstm.setString(1, numero);
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
