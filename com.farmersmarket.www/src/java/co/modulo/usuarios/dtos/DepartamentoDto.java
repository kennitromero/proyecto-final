package co.modulo.usuarios.dtos;

/** 
 * @author Kennit David Ruz Romero
 * Hora de creación: 11:18 a.m.
 * Fecha: 4 de Marzo de 2015
 */

public class DepartamentoDto {
    
    private int idDepartamento = 0;
    private String nombre = "";
    
    @Override
    public String toString() {
        return "idDepartamento: " + idDepartamento + " Nombre: " + nombre;
    }

    /**
     * @return the idDepartamento
     */
    public int getIdDepartamento() {
        return idDepartamento;
    }

    /**
     * @param idDepartamento the idDepartamento to set
     */
    public void setIdDepartamento(int idDepartamento) {
        this.idDepartamento = idDepartamento;
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
}
