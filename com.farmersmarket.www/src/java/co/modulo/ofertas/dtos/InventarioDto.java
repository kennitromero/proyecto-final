package co.modulo.ofertas.dtos;

/**
 *
 * @author Kennit Romero <kdruz at gmail.com>
 */
public class InventarioDto {

    private int idOferta = 0;
    private float cantidad = 0.f;

    @Override
    public String toString() {
        return "InventarioDto{" + "idOferta=" + idOferta + ", cantidad=" + cantidad + '}';
    }

    public int getIdOferta() {
        return idOferta;
    }

    public void setIdOferta(int idOferta) {
        this.idOferta = idOferta;
    }

    public float getCantidad() {
        return cantidad;
    }

    public void setCantidad(float cantidad) {
        this.cantidad = cantidad;
    }

}
