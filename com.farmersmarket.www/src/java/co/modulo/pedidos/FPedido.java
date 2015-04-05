package co.modulo.pedidos;

import co.modulo.pedidos.daos.PedidoDao;
import co.modulo.pedidos.dtos.PedidoDto;
import co.utilidades.ConexionEscritorio;
import java.sql.Connection;
import java.util.List;

/**
 * 
 * @author Sammy Guergachi <sguergachi at gmail.com>
 */
public class FPedido {
    Connection miConexion = null;

    //Clases DataAccessObject (DAO)
    PedidoDao peDao = null;
    

    //Clases DataTransferObject (DTO)
    PedidoDto peDto = null;
    
    public FPedido() {
        //Instancio la conexion
        this.miConexion = ConexionEscritorio.getInstance();
        this.peDao = new PedidoDao();
        
        this.peDto = new PedidoDto();        
    }
    
    public List obtenerPedidosDeCliente(long idCliente) {
        return peDao.obtenerPedidosCliente(idCliente, miConexion);
    }
    
    public List obtenerPedidosDeProductor(long idProductor) {
        return peDao.obtenerPedidosProductor(idProductor, miConexion);
    }
    
    public String registrarPedido(PedidoDto nuevoPedido) {
        return peDao.registrarPedidoProce(nuevoPedido, miConexion);
    }
    
    public String obtenerPedidosActivosProductor(long idProductor) {
        return peDao.obtenerNumeroDePedidosActivosProductor(idProductor, miConexion);
    }
    
    public String cambiarEstadoPedido(int idPedido, int nuevoEstado) {
        return peDao.actualizarEstadoPedido(idPedido, nuevoEstado, miConexion);
    }
    
    public boolean retornarCantidadPedida(int idPedido) {
        return peDao.retornarDescuentoCantidad(idPedido, miConexion);
    }
    
    public boolean validarCantidadPedido(int idOferta, float cantidadPedida) {
        return peDao.validarCantidadPedida(idOferta, cantidadPedida, miConexion);
    }
}
