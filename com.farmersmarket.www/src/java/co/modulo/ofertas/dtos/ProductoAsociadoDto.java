package co.modulo.ofertas.dtos;

import co.modulo.usuarios.dtos.UsuarioDto;

/**
 *
 * @author kennross
 */
public class ProductoAsociadoDto {

    private int idProductoAsociado = 0;
    private long idProductor = 0;
    private int idProducto = 0;
    private String fechaInicio = "";
    private String fechaFin = "";
    private int estado = 0;

    @Override
    public String toString() {
        return "ProductoAsociadoDto{" + "idProductoAsociado=" + idProductoAsociado + ", idProductor=" + idProductor + ", idProducto=" + idProducto + ", fechaInicio=" + fechaInicio + ", fechaFin=" + fechaFin + ", estado=" + estado + '}';
    }

    public String getFechaInicio() {
        return fechaInicio;
    }

    public void setFechaInicio(String fechaInicio) {
        this.fechaInicio = fechaInicio;
    }

    public String getFechaFin() {
        return fechaFin;
    }

    public void setFechaFin(String fechaFin) {
        this.fechaFin = fechaFin;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public int getIdProductoAsociado() {
        return idProductoAsociado;
    }

    public void setIdProductoAsociado(int idProductoAsociado) {
        this.idProductoAsociado = idProductoAsociado;
    }

    public long getIdProductor() {
        return idProductor;
    }

    public void setIdProductor(long idProductor) {
        this.idProductor = idProductor;
    }

    public int getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

}
