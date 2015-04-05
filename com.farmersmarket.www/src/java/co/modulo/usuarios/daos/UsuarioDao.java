/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package co.modulo.usuarios.daos;

import co.modulo.usuarios.dtos.RolDto;
import co.modulo.usuarios.dtos.UsuarioDto;
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
public class UsuarioDao {

    PreparedStatement pstm = null;
    ResultSet rs = null;
    String mensaje = "";
    int rtdo = 0;
    String sqlTemp = "";

    public String insertUsuarioProcedimiento(UsuarioDto nuevoUsuario, RolDto suRol, Connection unaConexion) {
        try {
            String sqlInsert = "CALL ProceRegistrarUsuarioCompleto(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            pstm = unaConexion.prepareStatement(sqlInsert);

            pstm.setLong(1, nuevoUsuario.getIdUsuario());
            pstm.setString(2, nuevoUsuario.getNombres());
            pstm.setString(3, nuevoUsuario.getApellidos());
            pstm.setString(4, nuevoUsuario.getClave());
            pstm.setString(5, nuevoUsuario.getCorreo());
            pstm.setString(6, nuevoUsuario.getFechaNacimiento());
            pstm.setString(7, nuevoUsuario.getDireccion());
            pstm.setInt(8, nuevoUsuario.getIdCiudad());
            pstm.setString(9, nuevoUsuario.getImagen());
            pstm.setInt(10, nuevoUsuario.getEstado());
            pstm.setInt(11, suRol.getIdRol());

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

    public List obtenerUsuarios(Connection unaConexion) {
        ArrayList<UsuarioDto> usuarios = null;
        sqlTemp = "SELECT `idUsuario`, `Nombres`, `Apellidos`, `Clave`, `Correo`, "
                + "`FechaNacimiento`, `Direccion`, `idCiudad`, `FechaSistema`, "
                + "`Imagen`, `idEstado` FROM `usuarios`";
        try {
            pstm = unaConexion.prepareStatement(sqlTemp);
            rs = pstm.executeQuery();

            usuarios = new ArrayList();
            while (rs.next()) {
                UsuarioDto temp = new UsuarioDto();
                temp.setIdUsuario(rs.getLong("idUsuario"));
                temp.setNombres(rs.getString("Nombres"));
                temp.setApellidos(rs.getString("Apellidos"));
                temp.setClave(rs.getString("Clave"));
                temp.setCorreo(rs.getString("Correo"));
                temp.setFechaNacimiento(rs.getString("FechaNacimiento"));
                temp.setDireccion(rs.getString("Direccion"));
                temp.setIdCiudad(rs.getInt("idCiudad"));
                temp.setFechaSistema(rs.getString("FechaSistema"));
                temp.setImagen(rs.getString("Imagen"));
                temp.setEstado(rs.getInt("idEstado"));
                usuarios.add(temp);
            }
        } catch (SQLException ex) {
            System.out.println("Error, detalle: " + ex.getMessage());
        }
        return usuarios;
    }

    public String actualizarUsuarioParaUsuario(UsuarioDto usuarioActualizado, Connection unaConexion) {
        try {
            String sqlInsert = "UPDATE `usuarios` SET `Nombres` = ?, "
                    + "`Apellidos` = ?, `Correo` = ?, `Direccion` = ? WHERE `idUsuario` = ?";
            pstm = unaConexion.prepareStatement(sqlInsert);

            pstm.setString(1, usuarioActualizado.getNombres());
            pstm.setString(2, usuarioActualizado.getApellidos());
            pstm.setString(3, usuarioActualizado.getCorreo());
            pstm.setString(4, usuarioActualizado.getDireccion());
            pstm.setLong(5, usuarioActualizado.getIdUsuario());

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

    public String obtenerNombresPorId(long idUsuario, Connection unaConexion) {
        sqlTemp = "SELECT concat(Nombres, ' ', Apellidos) as Salida FROM usuarios WHERE idUsuario = ?";
        try {
            pstm = unaConexion.prepareStatement(sqlTemp);
            pstm.setLong(1, idUsuario);
            rs = pstm.executeQuery();

            while (rs.next()) {
                mensaje = rs.getString("Salida");
            }
        } catch (SQLException ex) {
            mensaje = "Error, detalle: " + ex.getMessage();
        }
        return mensaje;
    }

    public StringBuilder validarExistenciaDocumento(long idUsuario, Connection unaConexion) {
        StringBuilder salidaValidar = new StringBuilder("");
        sqlTemp = "SELECT `idUsuario` FROM `usuarios` WHERE `idUsuario` = ?";
        try {
            pstm = unaConexion.prepareStatement(sqlTemp);
            pstm.setLong(1, idUsuario);
            rs = pstm.executeQuery();

            if (rs.next()) {
                salidaValidar.append("existe");
            } else {
                salidaValidar.append("noexiste");
            }
        } catch (SQLException ex) {
            mensaje = "Error, detalle: " + ex.getMessage();
        }
        return salidaValidar;
    }

    public StringBuilder validarExistenciaCorreo(String correo, Connection unaConexion) {
        StringBuilder salidaValidar = new StringBuilder("");
        sqlTemp = "SELECT `Correo` FROM `usuarios` WHERE `Correo` = ?";
        try {
            pstm = unaConexion.prepareStatement(sqlTemp);
            pstm.setString(1, correo);
            rs = pstm.executeQuery();

            if (rs.next()) {
                salidaValidar.append("existe");
            } else {
                salidaValidar.append("noexiste");
            }
        } catch (SQLException ex) {
            mensaje = "Error, detalle: " + ex.getMessage();
        }
        return salidaValidar;
    }

    public UsuarioDto validarSesion(long documento, Connection unaConexion) {
        UsuarioDto usuario = null;
        sqlTemp = "SELECT `idUsuario`, `Clave` FROM `usuarios` WHERE `idUsuario` = ?";
        try {
            pstm = unaConexion.prepareStatement(sqlTemp);
            pstm.setLong(1, documento);
            rs = pstm.executeQuery();

            usuario = new UsuarioDto();
            while (rs.next()) {
                usuario.setIdUsuario(rs.getLong("idUsuario"));
                usuario.setClave(rs.getString("Clave"));
            }
        } catch (SQLException ex) {
            System.out.println("Error, detalle: " + ex.getMessage());
        }
        return usuario;
    }

    public UsuarioDto obtenerUsuarioPorId(long idUsuario, Connection unaConexion) {
        sqlTemp = "SELECT `idUsuario`, `Nombres`, `Apellidos`, `Clave`, `Correo`, "
                + "`FechaNacimiento`, `Direccion`, `idCiudad`, `FechaSistema`, `Imagen`, "
                + "`idEstado` FROM `usuarios` WHERE `idUsuario` = ?";
        UsuarioDto salidaUsuario = new UsuarioDto();
        try {
            pstm = unaConexion.prepareStatement(sqlTemp);
            pstm.setLong(1, idUsuario);
            rs = pstm.executeQuery();

            while (rs.next()) {

                salidaUsuario.setIdUsuario(rs.getLong("idUsuario"));
                salidaUsuario.setNombres(rs.getString("Nombres"));
                salidaUsuario.setApellidos(rs.getString("Apellidos"));
                salidaUsuario.setClave(rs.getString("Clave"));
                salidaUsuario.setCorreo(rs.getString("Correo"));
                salidaUsuario.setFechaNacimiento(rs.getString("FechaNacimiento"));
                salidaUsuario.setDireccion(rs.getString("Direccion"));
                salidaUsuario.setIdCiudad(rs.getInt("idCiudad"));
                salidaUsuario.setFechaSistema(rs.getString("FechaSistema"));
                salidaUsuario.setImagen(rs.getString("Imagen"));
                salidaUsuario.setEstado(rs.getInt("idEstado"));
            }
        } catch (SQLException ex) {
            System.out.println("Error, detalle: " + ex.getMessage());
        }
        return salidaUsuario;
    }

    public UsuarioDto obtenerUsuarioPorCorreo(String correo, Connection unaConexion) {
        sqlTemp = "SELECT `idUsuario`, `Nombres`, `Apellidos`, `Clave`, `Correo`, "
                + "`FechaNacimiento`, `Direccion`, `idCiudad`, `FechaSistema`, `Imagen`, "
                + "`idEstado` FROM `usuarios` WHERE `Correo` = ?";
        UsuarioDto salidaUsuario = new UsuarioDto();
        try {
            pstm = unaConexion.prepareStatement(sqlTemp);
            pstm.setString(1, correo);
            rs = pstm.executeQuery();

            while (rs.next()) {
                salidaUsuario.setIdUsuario(rs.getLong("idUsuario"));
                salidaUsuario.setNombres(rs.getString("Nombres"));
                salidaUsuario.setApellidos(rs.getString("Apellidos"));
                salidaUsuario.setClave(rs.getString("Clave"));
                salidaUsuario.setCorreo(rs.getString("Correo"));
                salidaUsuario.setFechaNacimiento(rs.getString("FechaNacimiento"));
                salidaUsuario.setDireccion(rs.getString("Direccion"));
                salidaUsuario.setIdCiudad(rs.getInt("idCiudad"));
                salidaUsuario.setFechaSistema(rs.getString("FechaSistema"));
                salidaUsuario.setImagen(rs.getString("Imagen"));
                salidaUsuario.setEstado(rs.getInt("idEstado"));
            }
        } catch (SQLException ex) {
            System.out.println("Error, detalle: " + ex.getMessage());
        }
        return salidaUsuario;
    }

    public String actualizarClave(String nuevaClave, long documento, Connection unaConexion) {
        try {
            String sqlInsert = "UPDATE `usuarios` SET `Clave` = ? WHERE `idUsuario` = ?";
            pstm = unaConexion.prepareStatement(sqlInsert);

            pstm.setString(1, nuevaClave);
            pstm.setLong(2, documento);

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

    public String obtenerCorreoPorId(long idUsuario, Connection unaConexion) {
        sqlTemp = "SELECT `Correo` FROM `usuarios` WHERE `idUsuario` = ?";
        try {
            pstm = unaConexion.prepareStatement(sqlTemp);
            pstm.setLong(1, idUsuario);
            rs = pstm.executeQuery();

            while (rs.next()) {
                mensaje = rs.getString("Correo");
            }
        } catch (SQLException ex) {
            System.out.println("Error, detalle: " + ex.getMessage());
        }
        return mensaje;
    }
    
    public String obtenerCorreoProductorPorPedido(int idPedido, Connection unaConexion) {
        sqlTemp = "SELECT Correo FROM usuarios as u "
                + "JOIN productosasociados as pa ON (u.idUsuario = pa.idProductor) "
                + "JOIN ofertas as o ON (o.idProductoAsociado = pa.idProductoAsociado) "
                + "JOIN pedidos as pe ON (pe.idOferta = o.idOferta) "
                + "WHERE pe.idPedido = ?";
        try {
            pstm = unaConexion.prepareStatement(sqlTemp);
            pstm.setLong(1, idPedido);
            rs = pstm.executeQuery();

            while (rs.next()) {
                mensaje = rs.getString("Correo");
            }
        } catch (SQLException ex) {
            System.out.println("Error, detalle: " + ex.getMessage());
        }
        return mensaje;
    }

    public String obtenerNombrePorProductoAsociado(int idProductoAsociado, Connection unaConexion) {
        sqlTemp = "SELECT concat(u.Nombres, ' ', u.Apellidos) as Salida FROM usuarios as u "
                + "JOIN productosasociados as pa on (pa.idProductor = u.idUsuario) "
                + "JOIN ofertas as o ON (o.idProductoAsociado = pa.idProductoAsociado) "
                + "WHERE o.idProductoAsociado = ?";
        try {
            pstm = unaConexion.prepareStatement(sqlTemp);
            pstm.setInt(1, idProductoAsociado);
            rs = pstm.executeQuery();

            while (rs.next()) {
                mensaje = rs.getString("Salida");
            }
        } catch (SQLException ex) {
            mensaje = "Error, detalle: " + ex.getMessage();
        }
        return mensaje;
    }    
    
    public String obtenerNombrePorOferta(int idOferta, Connection unaConexion) {
        sqlTemp = "SELECT concat(u.Nombres, ' ', u.Apellidos) as Salida FROM usuarios as u "
                + "JOIN productosasociados as pa on (pa.idProductor = u.idUsuario) "
                + "JOIN ofertas as o ON (o.idProductoAsociado = pa.idProductoAsociado) "
                + "WHERE o.idOferta = ?";
        try {
            pstm = unaConexion.prepareStatement(sqlTemp);
            pstm.setInt(1, idOferta);
            rs = pstm.executeQuery();

            while (rs.next()) {
                mensaje = rs.getString("Salida");
            }
        } catch (SQLException ex) {
            mensaje = "Error, detalle: " + ex.getMessage();
        }
        return mensaje;
    }
}
