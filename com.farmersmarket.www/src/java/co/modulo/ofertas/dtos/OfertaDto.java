package co.modulo.ofertas.dtos;

/**
 *
 * @author kennross
 */
public class OfertaDto {

    private int idOferta = 0;
    private int idProductoAsociado = 0;
    private float precioCompra = 0;
    private String fechaInicio = "";
    private String fechaFin = "";
    private float cantidadDisponible = 0.f;
    private int idPromocion = 0;
    private int estado = 0;

    @Override
    public String toString() {
        return "OfertaDto{" + "idOferta=" + idOferta + ", idProductoAsociado=" + idProductoAsociado + ", precioCompra=" + precioCompra + ", fechaInicio=" + fechaInicio + ", fechaFin=" + fechaFin + ", cantidadDisponible=" + cantidadDisponible + ", idPromocion=" + idPromocion + ", estado=" + estado + '}';
    }

    public int getIdOferta() {
        return idOferta;
    }

    public void setIdOferta(int idOferta) {
        this.idOferta = idOferta;
    }

    public int getIdProductoAsociado() {
        return idProductoAsociado;
    }

    public void setIdProductoAsociado(int idProductoAsociado) {
        this.idProductoAsociado = idProductoAsociado;
    }

    public float getPrecioCompra() {
        return precioCompra;
    }

    public void setPrecioCompra(float precioCompra) {
        this.precioCompra = precioCompra;
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

    public float getCantidadDisponible() {
        return cantidadDisponible;
    }

    public void setCantidadDisponible(float cantidadDisponible) {
        this.cantidadDisponible = cantidadDisponible;
    }

    public int getIdPromocion() {
        return idPromocion;
    }

    public void setIdPromocion(int idPromocion) {
        this.idPromocion = idPromocion;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

}
