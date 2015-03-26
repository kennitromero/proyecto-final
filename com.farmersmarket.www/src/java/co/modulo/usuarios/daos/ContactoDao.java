/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package co.modulo.usuarios.daos;

import co.modulo.usuarios.dtos.ContactoDto;
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
public class ContactoDao {

    PreparedStatement pstm = null;
    int rtdo;
    ResultSet rs = null;
    String mensaje = "";
    String sqlTemp = "";

    public String insertContactenos(ContactoDto nuevoContactenos, Connection unaConexion) {
        try {
            String sqlInsert = "INSERT INTO `contactenos`(`idContacto`, `NombreCompleto`, `Correo`, `Mensaje`, `FechaRegistro`) VALUES (null, ?, ?, ?, now())";
            pstm = unaConexion.prepareStatement(sqlInsert);

            pstm.setString(1, nuevoContactenos.getNombreCompleto());
            pstm.setString(2, nuevoContactenos.getCorreo());
            pstm.setString(3, nuevoContactenos.getMensaje());
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

    public List obtenerContactenos(Connection unaConexion) {
        ArrayList<ContactoDto> mensajesContactenos = null;
        sqlTemp = "SELECT `idContacto`, `NombreCompleto`, `Correo`, `Mensaje`, `FechaRegistro` FROM `contactenos`";
        try {
            pstm = unaConexion.prepareStatement(sqlTemp);
            rs = pstm.executeQuery();

            mensajesContactenos = new ArrayList();
            while (rs.next()) {
                ContactoDto temp = new ContactoDto();
                temp.setIdContacto(rs.getInt("idContacto"));
                temp.setNombreCompleto(rs.getString("NombreCompleto"));
                temp.setCorreo(rs.getString("Correo"));
                temp.setMensaje(rs.getString("Mensaje"));
                temp.setFechaRegistro(rs.getString("FechaRegistro"));
                mensajesContactenos.add(temp);
            }
        } catch (SQLException ex) {
            System.out.println("Error, detalle: " + ex.getMessage());
        }
        return mensajesContactenos;
    }

    public String eliminarContactenos(int idContacto, Connection unaConexion) {
        try {
            String sqlInsert = "DELETE FROM `contactenos` WHERE `idContacto` = ?";
            pstm = unaConexion.prepareStatement(sqlInsert);

            pstm.setInt(1, idContacto);
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
