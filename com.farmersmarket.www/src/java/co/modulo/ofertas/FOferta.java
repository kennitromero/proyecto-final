package co.modulo.ofertas;

import co.modulo.ofertas.daos.CategoriaDao;
import co.modulo.ofertas.daos.OfertaDao;
import co.modulo.ofertas.daos.ProductoAsociadoDao;
import co.modulo.ofertas.daos.ProductoDao;
import co.modulo.ofertas.daos.PromocionDao;
import co.modulo.ofertas.dtos.CategoriaDto;
import co.modulo.ofertas.dtos.OfertaDto;
import co.modulo.ofertas.dtos.ProductoAsociadoDto;
import co.modulo.ofertas.dtos.ProductoDto;
import co.modulo.ofertas.dtos.PromocionDto;
import co.utilidades.ConexionEscritorio;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

/**
 * @author kennross
 */
public class FOferta {

    //Conexion

    Connection miConexion = null;

    //Clases DataAccessObject (DAO)
    OfertaDao ofDao = null;
    ProductoDao pDao = null;
    CategoriaDao caDao = null;
    ProductoAsociadoDao paDao = null;
    PromocionDao proDao = null;

    //Clases DataTransferObject (DTO)
    OfertaDto ofDto = null;
    ProductoDto pDto = null;
    ProductoAsociadoDto paDto = null;
    PromocionDto proDto = null;
    CategoriaDto caDto = null;

    public FOferta() {
        //Instancio la conexion
        this.miConexion = ConexionEscritorio.getInstance();

        this.ofDao = new OfertaDao();
        this.pDao = new ProductoDao();
        this.caDao = new CategoriaDao();
        this.paDao = new ProductoAsociadoDao();
        this.proDao = new PromocionDao();

        this.ofDto = new OfertaDto();
        this.pDto = new ProductoDto();
        this.proDto = new PromocionDto();
        this.caDto = new CategoriaDto();
        this.paDto = new ProductoAsociadoDto();
    }

    //Insert's a la base de datos directamente
    public String asociarProductos(long idProductor, int[] idProducto) {
        return paDao.insertProductoAsociado(idProductor, idProducto, miConexion);
    }

    public String publicaroferta(OfertaDto nOferta, PromocionDto pPromo) {
        return ofDao.insertOfertaProcedimiento(nOferta, pPromo, miConexion);
    }

    public String agregarPromocion(PromocionDto agPromo, int idOferta) {
        return ofDao.insertPromocion(agPromo, idOferta, miConexion);
    }
    
    public String publicarOfertaSinPromocion(OfertaDto nuevaOferta) {
        return ofDao.insertOferta(nuevaOferta, miConexion);
    }

    //Consultas Por Un Criterio (ProductosAsociados)
    public int obtenerIdPaPorIds(long idProductor, int idProducto) {
        return paDao.obtenerIdPA(idProductor, idProducto, miConexion);
    }

    //Consultas Por Un criterio (Usuario)
    public List obtenerOfertasProducto(long idProductor) {
        return ofDao.obtenerOfertasPorProductor(idProductor, miConexion);
    }

    //Consultas Por un Criterio (Ofertas)
    public int obtenerDiasCaducacionOferta(int idOferta) {
        return ofDao.calcularCaducacionOferta(idOferta, miConexion);
    }

    public PromocionDto obtenerPromocionPorOferta(int idOferta) {
        return proDao.obtenerPromocionOferta(idOferta, miConexion);
    }
    
    public boolean validarProductoPublicado (int idProductoAsociado) {
        return ofDao.validarProductoPublicado(idProductoAsociado, miConexion);
    }
    
    public int obtenerCuposOferta(long idProductor) {
        return ofDao.obtenerCuposParaOfertar(idProductor, miConexion);
    }

    //Consultas Por Un Criterio (Produtos)
    public List obtenerTodosLosProductos() {
        return pDao.obtenerProductos(miConexion);
    }

    public String obNombreCategoriaPorIDPA(int idProductoAsociado) {
        return pDao.obtenerNombreCategoriaPorIdPA(idProductoAsociado, miConexion);
    }

    public String mostrarCuposDisponiblesAsociar(long idProductor) {
        return paDao.obtenerCuposDisponibles(idProductor, miConexion);
    }

    public String obtenerNumeroDeProductosAsociadosPorProducto(long idProductor) {
        return paDao.obtenerNumeroProductosAsociados(idProductor, miConexion);
    }

    public boolean validarProductoYaAsociado(long idProductor, int idProducto) {
        return paDao.validarYaProdAso(idProductor, idProducto, miConexion);
    }

    public List obtenerProductosAsociados(long idProductor) {
        return pDao.obtenerProductosPorId(idProductor, miConexion);
    }

    public ProductoDto obtenerProductoConIdProductoAso(int idProductoAso) {
        return pDao.obtenerProductoIdProducoAso(idProductoAso, miConexion);
    }

    public boolean validarProductoOfertado(int idProductoAso) {
        return paDao.validarProductoOfertado(idProductoAso, miConexion);
    }

    //Consultas Por Un Criterio (Categorias)
    public String obtenerNombreDeCategoriaPorId(int idCategoria) {
        return caDao.obtenerNombrePorId(idCategoria, miConexion);
    }

    //Eliminación de registros directamente
    public String eliminarAsociasionDeProducto(int idProductoAso) {
        return paDao.eliminarUnProductoAsociado(idProductoAso, miConexion);
    }

    public String elimiarOferta(int idOferta) {
        return ofDao.deleteOferta(idOferta, miConexion);
    }
    
    //Actualizaciones de registros
    public String actualizarOferta(OfertaDto ediOferta) {
        return ofDao.updateOferta(ediOferta, miConexion);
    }
    
    public String actualizarPromocion(PromocionDto ediPromo) {
        return proDao.updatePromocion(ediPromo, miConexion);
    }

    //Utilidades
    public int[] obtenerCodigosProductos() {
        return pDao.obtenerIdProductos(miConexion);
    }

    public String ponerImagenesProductos(ArrayList<ProductoDto> p) {
        return pDao.insertarImagenes(p, miConexion);
    }
}
