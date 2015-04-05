package co.utilidades;

import co.modulo.ofertas.FOferta;
import co.modulo.ofertas.daos.ProductoDao;
import co.modulo.ofertas.dtos.ProductoDto;
import co.modulo.pedidos.FPedido;
import co.modulo.pedidos.dtos.PedidoDto;
import co.modulo.usuarios.FUsuario;
import co.modulo.usuarios.dtos.RolDto;
import co.modulo.usuarios.dtos.TelefonoDto;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.Arrays;

public class verificar {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        Connection miCon = ConexionEscritorio.getInstance();
//        if (miCon != null) {
//            System.out.println("c");
//        } else {
//            System.out.println("No se pudo");
//        }

        FUsuario faUsu = new FUsuario();
        FOferta faOfer = new FOferta();
        FPedido faPe = new FPedido();
        
        System.out.println(faPe.cambiarEstadoPedido(24, 1));
        
//        PedidoDto np = new PedidoDto();
//        np.setIdOferta(30);
//        np.setIdCliente(1111111111);
//        np.setPrecioTotalFinal(102300);
//        np.setCantidadPedido(450);
//        
//        System.out.println(faPe.registrarPedido(np));

//        ArrayList<TelefonoDto> misNumeros;
//        misNumeros = (ArrayList<TelefonoDto>) faUsu.obtenerNumerosPorId(1102867002);
//        for (TelefonoDto t : misNumeros) {
//            System.out.println(t.getNumero());
//        }
//        TelefonoDto nt = new TelefonoDto();
//        nt.setIdUsuario(1102867002);
//        nt.setNumero("3045652958");
//        
//        System.out.println(faUsu.registrarTelefono(nt));
//        
//        System.out.println(faOfer.obtenerNumeroDeProductosAsociadosPorProducto(64569185));
////
//        System.out.println("----------------------------");
//        

//        ArrayList<ProductoDto> prods = (ArrayList<ProductoDto>) faOfer.obtenerTodosLosProductos();
//
//        System.out.println(faOfer.ponerImagenesProductos(prods));
//        ArrayList<ProductoDto> misProductos = (ArrayList<ProductoDto>) faOfer.obtenerTodosLosProductos();
//        
//        for (ProductoDto p : misProductos) {
//            System.out.println(p);
//        }
          //      ArrayList<RolDto> roles;
//        roles = faUsu.obtenerRolesPorUsuario(64569185);
//        
//        for (RolDto r : roles) {
//            System.out.println(r);
//        }
//        
            //        
            //        ProductoDao pdao = new ProductoDao();
            //        
            //        ArrayList<ProductoDto> listProductos = (ArrayList<ProductoDto>) pdao.obtenerProductos();
            //        
            //        for (ProductoDto p : listProductos) {
            //            System.out.println(p);
            //        }
            //        
            //        System.out.println("-------------------------------------------");
            //        DepartamentoDao dao = new DepartamentoDao();
            //        ArrayList<DepartamentoDto> listad = (ArrayList<DepartamentoDto>) dao.obtenerDepartamentos();
            //        
            //        for (DepartamentoDto d : listad) {
            //            System.out.println(d);
            //        }
//        PreparedStatement pstm;
//        int rtdo = 0;        
//        String mensaje;        
//        String sqlInsert;
//        
//        int[] idProducto = new int[4];
//        
//        idProducto[0] = 102001;
//        idProducto[1] = 101001;
//        idProducto[2] = 102002;        
//        idProducto[3] = 102003;
//
//        try {
//            sqlInsert = "INSERT INTO `productosasociados`(`idProductor`, `idProducto`, `idProductoAsociado`) VALUES (?, ?, null)";
//            pstm = miCon.prepareStatement(sqlInsert);
//
//            for (int i = 0; i < idProducto.length; i++) {
//                pstm.setLong(1, 64569185);
//                pstm.setInt(2, idProducto[i]);
//                rtdo = pstm.executeUpdate();
//            }
//
//            if (rtdo != 0) {
//                mensaje = "ok";
//            } else {
//                mensaje = "okno";
//            }
//        } catch (SQLException sqle) {
//            mensaje = "Error, detalle " + sqle.getMessage();
//        }
//        
//        System.out.println(mensaje);
//        int[] idProducto = new int[4];
//
//        idProducto[0] = 102001;
//        idProducto[1] = 101001;
//        idProducto[2] = 102002;
//        idProducto[3] = 102003;
////
////        FOferta faOfer = new FOferta();
////        System.out.println(faOfer.asociarProductos(64569185, idProducto));
////
////        ProductoAsociadoDao paAso = new ProductoAsociadoDao();
////        System.out.println(paAso.insertProductoAsociado(64569185, idProducto));
//        
//        if (Correo.sendMail("Productos Asociados", "prueba", "thekenyr@gmail.com")) {
//            System.out.println("ok");
//        } else {
//            System.out.println("okno");
//        }
//        ProductoDao pDao = new ProductoDao();
//        ArrayList<ProductoDto> misProductos;
//        misProductos = (ArrayList<ProductoDto>) pDao.obtenerProductosPorId(64569185);
//
//        for (ProductoDto p : misProductos) {
//            System.out.print(p);
//        }      
//        if (!faOfer.validarProductoOfertado(94)) {
//            System.out.println("Puede Eliminar");
//        } else {
//            System.out.println("No puede eliminar");
//        }
        }

    }
