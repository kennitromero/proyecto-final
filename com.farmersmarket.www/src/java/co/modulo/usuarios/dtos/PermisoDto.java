package co.modulo.usuarios.dtos;

/** 
 * @author Kennit David Ruz Romero
 * Hora de creación: 11:18 a.m.
 * Fecha: 4 de Marzo de 2015
 */

public class PermisoDto {
    
    private int idPermiso = 0;
    private String nombre = "";
    private String url = "";
    private String icon = "";

    @Override
    public String toString() {
        return "PermisoDto{" + "idPermiso=" + idPermiso + ", nombre=" + nombre + ", url=" + url + ", icon=" + icon + "}";
    }

    /**
     * @return the idPermiso
     */
    public int getIdPermiso() {
        return idPermiso;
    }

    /**
     * @param idPermiso the idPermiso to set
     */
    public void setIdPermiso(int idPermiso) {
        this.idPermiso = idPermiso;
    }

    /**
     * @return the nombre
     */
    public String getNombre() {
        return nombre;
    }

    /**
     * @param nombre the nombre to set
     */
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    /**
     * @return the url
     */
    public String getUrl() {
        return url;
    }

    /**
     * @param url the url to set
     */
    public void setUrl(String url) {
        this.url = url;
    }

    /**
     * @return the icon
     */
    public String getIcon() {
        return icon;
    }

    /**
     * @param icon the icon to set
     */
    public void setIcon(String icon) {
        this.icon = icon;
    }    
    
}
