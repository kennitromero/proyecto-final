package co.modulo.pedidos.dtos;

/**
 *
 * @author Sammy Guergachi <sguergachi at gmail.com>
 */
public class ComentarioDto {

    private int idComentario = 0;
    private String fechaComenatario = "";
    private String descripcion = "";
    private int idTabla = 0;
    private int id = 0;

    @Override
    public String toString() {
        return "ComentarioDto{" + "idComentario=" + idComentario + ", fechaComenatario=" + fechaComenatario + ", descripcion=" + descripcion + ", idTabla=" + idTabla + ", id=" + id + '}';
    }

    public int getIdComentario() {
        return idComentario;
    }

    public void setIdComentario(int idComentario) {
        this.idComentario = idComentario;
    }

    public String getFechaComenatario() {
        return fechaComenatario;
    }

    public void setFechaComenatario(String fechaComenatario) {
        this.fechaComenatario = fechaComenatario;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public int getIdTabla() {
        return idTabla;
    }

    public void setIdTabla(int idTabla) {
        this.idTabla = idTabla;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

}
