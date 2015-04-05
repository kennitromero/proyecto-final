package co.modulo.pedidos.dtos;

/**
 *
 * @author Kennit Romero
 */
public class PedidoDto {

    private int idPedido = 0;
    private int idOferta = 0;
    private long idCliente = 0;
    private float precioTotalFinal = 0.f;
    private float cantidadPedido = 0.f;
    private String fechaEntrega = "";
    private String fechaPedido = "";
    private int estado = 0;

    @Override
    public String toString() {
        return "PedidoDto{" + "idPedido=" + idPedido + ", idOferta=" + idOferta + ", idCliente=" + idCliente + ", precioTotalFinal=" + precioTotalFinal + ", cantidadPedido=" + cantidadPedido + ", fechaEntrega=" + fechaEntrega + ", fechaPedido=" + fechaPedido + ", estado=" + estado + '}';
    }

    public int getIdPedido() {
        return idPedido;
    }

    public void setIdPedido(int idPedido) {
        this.idPedido = idPedido;
    }

    public int getIdOferta() {
        return idOferta;
    }

    public void setIdOferta(int idOferta) {
        this.idOferta = idOferta;
    }

    public long getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(long idCliente) {
        this.idCliente = idCliente;
    }

    public float getPrecioTotalFinal() {
        return precioTotalFinal;
    }

    public void setPrecioTotalFinal(float precioTotalFinal) {
        this.precioTotalFinal = precioTotalFinal;
    }

    public float getCantidadPedido() {
        return cantidadPedido;
    }

    public void setCantidadPedido(float cantidadPedido) {
        this.cantidadPedido = cantidadPedido;
    }

    public String getFechaEntrega() {
        return fechaEntrega;
    }

    public void setFechaEntrega(String fechaEntrega) {
        this.fechaEntrega = fechaEntrega;
    }

    public String getFechaPedido() {
        return fechaPedido;
    }

    public void setFechaPedido(String fechaPedido) {
        this.fechaPedido = fechaPedido;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

}
