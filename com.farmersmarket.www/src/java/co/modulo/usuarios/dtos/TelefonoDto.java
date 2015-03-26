package co.modulo.usuarios.dtos;

/** 
 * @author Kennit David Ruz Romero
 * Hora de creación: 11:18 a.m.
 * Fecha: 4 de Marzo de 2015
 */

public class TelefonoDto {

    private long idUsuario = 0;
    private long numero = 0;

    @Override
    public String toString() {
        return "TelefonoDto{" + "idUsuario=" + idUsuario + ", numero=" + numero + '}';
    }

    /**
     * @return the idUsuario
     */
    public long getIdUsuario() {
        return idUsuario;
    }

    /**
     * @param idUsuario the idUsuario to set
     */
    public void setIdUsuario(long idUsuario) {
        this.idUsuario = idUsuario;
    }

    /**
     * @return the numero
     */
    public long getNumero() {
        return numero;
    }

    /**
     * @param numero the numero to set
     */
    public void setNumero(long numero) {
        this.numero = numero;
    }
}
