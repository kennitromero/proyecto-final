package co.modulo.ofertas.dtos;

/**
 *
 * @author kennross
 */
public class ProductoDto {

    private int idProducto = 0;
    private String nombre = "";
    private int idCategoria = 0;
    private String imagen = "";

    @Override
    public String toString() {
        return "ProductoDto{" + "idProducto=" + idProducto + ", nombre=" + nombre + ", idCategoria=" + idCategoria + ", imagen=" + imagen + '}';
    }

    public int getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getIdCategoria() {
        return idCategoria;
    }

    public void setIdCategoria(int idCategoria) {
        this.idCategoria = idCategoria;
    }

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

}
