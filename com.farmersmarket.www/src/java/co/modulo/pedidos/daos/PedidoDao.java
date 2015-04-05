/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package co.modulo.pedidos.daos;

import co.modulo.pedidos.dtos.PedidoDto;
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
public class PedidoDao {

    PreparedStatement pstm = null;
    int rtdo;
    ResultSet rs = null;
    String mensaje = "";
    String sqlTemp = "";
    boolean poder = false;
    
    public String registrarPedidoProce(PedidoDto nuevoPedido, Connection unaConexion) {
        sqlTemp = "CALL ProceRegistrarPedido (?, ?, ?, ?)";
        try {
            pstm = unaConexion.prepareCall(sqlTemp);
            pstm.setInt(1, nuevoPedido.getIdOferta());
            pstm.setLong(2, nuevoPedido.getIdCliente());
            pstm.setFloat(3, nuevoPedido.getPrecioTotalFinal());
            pstm.setFloat(4, nuevoPedido.getCantidadPedido());                       
            
            rtdo = pstm.executeUpdate();
            if (rtdo != 0) {
                mensaje = "ok";
            } else {
                mensaje = "okno";
            }
        } catch (SQLException ex) {
            mensaje = ex.getMessage();
        }
        return mensaje;
    }
    
    public String obtenerCorreoProductorPorPedido(int idPedido, Connection unaConexion) {
        sqlTemp = "SELECT `Correo` FROM `usuarios` WHERE `idUsuario` = ?";
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

    public PedidoDto obtenerPedidoPorId(int idPedido, Connection unaConexion) {
        PedidoDto temp = new PedidoDto();
        sqlTemp = "SELECT idPedido, idOferta, idCliente, PrecioTotalFinal, CantidadPedido, DATE_FORMAT(FechaEntrega,'%b %d %Y %h:%i %p') as FechaEntrega, DATE_FORMAT(FechaPedido,'%b %d %Y %h:%i %p') as FechaPedido, idEstado "
                + "FROM pedidos WHERE idPedido = ?";
        try {
            pstm = unaConexion.prepareStatement(sqlTemp);
            pstm.setLong(1, idPedido);
            rs = pstm.executeQuery();

            while (rs.next()) {
                temp.setIdPedido(rs.getInt("idPedido"));
                temp.setIdOferta(rs.getInt("idOferta"));
                temp.setIdCliente(rs.getLong("idCliente"));
                temp.setPrecioTotalFinal(rs.getFloat("PrecioTotalFinal"));
                temp.setCantidadPedido(rs.getFloat("CantidadPedido"));
                temp.setFechaEntrega(rs.getString("FechaEntrega"));
                temp.setFechaPedido(rs.getString("FechaPedido"));
                temp.setEstado(rs.getInt("idEstado"));
            }
        } catch (SQLException ex) {
            System.out.println("Error, detalle: " + ex.getMessage());
        }
        return temp;
    }

    public String obtenerNumeroDePedidosActivosProductor(long idProductor, Connection unaConexion) {
        try {
            sqlTemp = "SELECT count(pe.idPedido) as Salida FROM pedidos as pe "
                    + "JOIN ofertas as o ON (o.idOferta = pe.idOferta) "
                    + "JOIN productosasociados as pa ON (pa.idProductoAsociado = o.idProductoAsociado) "
                    + "JOIN usuarios as u ON (u.idUsuario = pa.idProductor) "
                    + "WHERE pe.idEstado = 1 AND u.idUsuario = ?";
            pstm = unaConexion.prepareStatement(sqlTemp);

            pstm.setLong(1, idProductor);

            rs = pstm.executeQuery();
            while (rs.next()) {
                mensaje = rs.getString("Salida");
            }

        } catch (SQLException sqle) {
            mensaje = "Error, detalle " + sqle.getMessage();
        }
        return mensaje;
    }

    
    public List obtenerPedidosProductor(long idProductor, Connection unaConexion) {
        ArrayList<PedidoDto> misPedidos = null;
        sqlTemp = "SELECT idPedido, pe.idOferta, idCliente, PrecioTotalFinal, CantidadPedido, date_format(FechaEntrega,'%W %d de %M de %Y') as FechaEntrega, date_format(FechaPedido,'%W %d de %M de %Y') as FechaPedido, pe.idEstado "
                + "FROM pedidos as pe "
                + "JOIN ofertas as o ON (pe.idOferta = o.idOferta) "
                + "JOIN productosasociados as pa ON (pa.idProductoAsociado = o.idProductoAsociado) "
                + "JOIN usuarios as u ON (u.idUsuario = pa.idProductor) "
                + "WHERE u.idUsuario = ?";
        try {
            pstm = unaConexion.prepareStatement(sqlTemp);
            pstm.setLong(1, idProductor);
            rs = pstm.executeQuery();

            misPedidos = new ArrayList();
            while (rs.next()) {
                PedidoDto temp = new PedidoDto();
                temp.setIdPedido(rs.getInt("idPedido"));
                temp.setIdOferta(rs.getInt("idOferta"));
                temp.setIdCliente(rs.getLong("idCliente"));
                temp.setPrecioTotalFinal(rs.getFloat("PrecioTotalFinal"));
                temp.setCantidadPedido(rs.getFloat("CantidadPedido"));
                temp.setFechaEntrega(rs.getString("FechaEntrega"));
                temp.setFechaPedido(rs.getString("FechaPedido"));
                temp.setEstado(rs.getInt("idEstado"));
                misPedidos.add(temp);
            }
        } catch (SQLException ex) {
            System.out.println("Error, detalle: " + ex.getMessage());
        }
        return misPedidos;
    }
    
    public List obtenerPedidosCliente(long idCliente, Connection unaConexion) {
        ArrayList<PedidoDto> misPedidos = null;
        sqlTemp = "SELECT idPedido, idOferta, idCliente, PrecioTotalFinal, CantidadPedido, FechaEntrega, FechaPedido, idEstado FROM pedidos  WHERE idCliente = ?";
        try {
            pstm = unaConexion.prepareStatement(sqlTemp);
            pstm.setLong(1, idCliente);
            rs = pstm.executeQuery();

            misPedidos = new ArrayList();
            while (rs.next()) {
                PedidoDto temp = new PedidoDto();
                temp.setIdPedido(rs.getInt("idPedido"));
                temp.setIdOferta(rs.getInt("idOferta"));
                temp.setIdCliente(rs.getLong("idCliente"));
                temp.setPrecioTotalFinal(rs.getFloat("PrecioTotalFinal"));
                temp.setCantidadPedido(rs.getFloat("CantidadPedido"));
                temp.setFechaEntrega(rs.getString("FechaEntrega"));
                temp.setFechaPedido(rs.getString("FechaPedido"));
                temp.setEstado(rs.getInt("idEstado"));
                misPedidos.add(temp);
            }
        } catch (SQLException ex) {
            System.out.println("Error, detalle: " + ex.getMessage());
        }
        return misPedidos;
    }

//
    public String actualizarEstadoPedido(int idPedido, int nuevoEstado, Connection unaConexion) {
        try {
            //1-PrecioVente | 2-Cantidad | 3-idOferta
            String sqlInsert = "UPDATE pedidos SET idEstado = ? WHERE idPedido = ?";
            pstm = unaConexion.prepareStatement(sqlInsert);

            pstm.setInt(1, nuevoEstado);
            pstm.setInt(2, idPedido);

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
    
    public boolean retornarDescuentoCantidad(int idPedido, Connection unaConexion) {
        try {
            //1-PrecioVente | 2-Cantidad | 3-idOferta
            String sqlInsert = "UPDATE ofertas SET Cantidad = Cantidad + (SELECT CantidadPedido FROM pedidos WHERE idPedido = ?) "
                    + "WHERE idOferta = (SELECT idOferta FROM pedidos WHERE idPedido = ?)";
            pstm = unaConexion.prepareStatement(sqlInsert);

            pstm.setInt(1, idPedido);
            pstm.setInt(2, idPedido);

            rtdo = pstm.executeUpdate();

            if (rtdo != 0) {
                poder = true;
            } else {
                poder = false;
            }
        } catch (SQLException sqle) {
            mensaje = "Error, detalle " + sqle.getMessage();
        }
        return poder;
    }
    
    public boolean validarCantidadPedida(int idOferta, float cantidadPedida, Connection unaConexion) {
        try {
            String sqlInsert = "SELECT Cantidad FROM ofertas WHERE idOferta = ?";
            float cantidadOferta = 0.f;
            pstm = unaConexion.prepareStatement(sqlInsert);
            pstm.setLong(1, idOferta);
            rs = pstm.executeQuery();

            while (rs.next()) {
                cantidadOferta = rs.getFloat("Cantidad");
            }

            if (cantidadOferta >= cantidadPedida) {
                poder = true;
            }
        } catch (SQLException sqle) {
            mensaje = "Error, detalle " + sqle.getMessage();
        }
        return poder;
    }
//
//    public int calcularCaducacionOferta(int idOferta, Connection unaConexion) {
//        try {
//            //1- idProductoAsociado 2- PrecioVenta 3- Cantidad 4- idPromocion 5- idEstado
//            String sqlInsert = "SELECT DATEDIFF(FechaFin, FechaInicio) as Diferencia from ofertas WHERE idOferta = ?";
//            pstm = unaConexion.prepareStatement(sqlInsert);
//
//            pstm.setInt(1, idOferta);
//
//            rs = pstm.executeQuery();
//            while (rs.next()) {
//                rtdo = rs.getInt("Diferencia");
//            }
//
//        } catch (SQLException sqle) {
//            mensaje = "Error, detalle " + sqle.getMessage();
//        }
//        return rtdo;
//    }
//
//    //Validar producto ya asociado
//    public boolean validarProductoPublicado(int idProductoAsociado, Connection unaConexion) {
//        try {
//            String sqlInsert = "SELECT o.idProductoAsociado FROM ofertas as o "
//                    + "JOIN productosasociados as pa on (pa.idProductoAsociado = o.idProductoAsociado) "
//                    + "WHERE o.idProductoAsociado = ?";
//            pstm = unaConexion.prepareStatement(sqlInsert);
//            pstm.setLong(1, idProductoAsociado);
//            rs = pstm.executeQuery();
//
//            while (rs.next()) {
//                rtdo = rs.getInt("idProductoAsociado");
//            }
//
//            if (rtdo == 0) {
//                poder = true;
//            }
//        } catch (SQLException sqle) {
//            mensaje = "Error, detalle " + sqle.getMessage();
//        }
//        return poder;
//    }
//
//    //Validar y Mostrar el número disponible de cupos para publicar ofertas
//    public int obtenerCuposParaOfertar(long idProductor, Connection unaConexion) {
//        try {
//            String sqlInsert = "SELECT count(o.idProductoAsociado) as Cantidad FROM ofertas as o "
//                    + "JOIN productosasociados as pa on (o.idProductoAsociado = pa.idProductoAsociado) "
//                    + "WHERE idProductor = ? AND idEstadoOferta = 1;";
//            pstm = unaConexion.prepareStatement(sqlInsert);
//            pstm.setLong(1, idProductor);
//            rs = pstm.executeQuery();
//
//            while (rs.next()) {
//                rtdo = rs.getInt("Cantidad");
//            }
//
//        } catch (SQLException sqle) {
//            mensaje = "Error, detalle " + sqle.getMessage();
//        }
//        return rtdo;
//    }
}
