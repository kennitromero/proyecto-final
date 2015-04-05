package co.modulo.usuarios;

import co.modulo.usuarios.daos.CiudadDao;
import co.modulo.usuarios.daos.DepartamentoDao;
import co.modulo.usuarios.daos.PermisoDao;
import co.modulo.usuarios.daos.PermisoRolDao;
import co.modulo.usuarios.daos.RolDao;
import co.modulo.usuarios.daos.RolUsuarioDao;
import co.modulo.usuarios.daos.TelefonoDao;
import co.modulo.usuarios.daos.UsuarioDao;
import co.modulo.usuarios.dtos.CiudadDto;
import co.modulo.usuarios.dtos.DepartamentoDto;
import co.modulo.usuarios.dtos.PermisoDto;
import co.modulo.usuarios.dtos.PermisoRolDto;
import co.modulo.usuarios.dtos.RolDto;
import co.modulo.usuarios.dtos.RolUsuarioDto;
import co.modulo.usuarios.dtos.TelefonoDto;
import co.modulo.usuarios.dtos.UsuarioDto;
import co.modulo.usuarios.daos.ContactoDao;
import co.modulo.usuarios.dtos.ContactoDto;
import co.utilidades.ConexionEscritorio;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

/**
 * @author kennross
 */
public class FUsuario {
    Connection miConexion = null;

    //Clases DataAccessObject (DAO)
    CiudadDao ciDao = null;
    DepartamentoDao depDao = null;
    PermisoDao perDao = null;
    PermisoRolDao perRolDao = null;
    RolDao rlDao = null;
    RolUsuarioDao rlUsuDao = null;
    TelefonoDao tDao = null;
    UsuarioDao uDao = null;
    ContactoDao conDao = null;

    //Clases DataTransferObject (DTO)
    CiudadDto ciDto = null;
    DepartamentoDto depDto = null;
    PermisoDto perDto = null;
    PermisoRolDto perRolDto = null;
    RolDto rlDto = null;
    RolUsuarioDto rlUsuDto = null;
    TelefonoDto tDto = null;
    UsuarioDto uDto = null;
    ContactoDto conDto = null;

    public FUsuario() {
        //Instancio la conexion
        this.miConexion = ConexionEscritorio.getInstance();

        this.ciDao = new CiudadDao();
        this.depDao = new DepartamentoDao();
        this.perDao = new PermisoDao();
        this.perRolDao = new PermisoRolDao();
        this.rlDao = new RolDao();
        this.rlUsuDao = new RolUsuarioDao();
        this.tDao = new TelefonoDao();
        this.uDao = new UsuarioDao();
        this.conDao = new ContactoDao();

        this.ciDto = new CiudadDto();
        this.depDto = new DepartamentoDto();
        this.perDto = new PermisoDto();
        this.perRolDto = new PermisoRolDto();
        this.rlDto = new RolDto();
        this.rlUsuDto = new RolUsuarioDto();
        this.tDto = new TelefonoDto();
        this.uDto = new UsuarioDto();
        this.conDto = new ContactoDto();
    }

    //Inserts a la base de datos directamente (Usuario)
    public String registrarUsuario(UsuarioDto nuevoUsuario, RolDto suRol) {
        return uDao.insertUsuarioProcedimiento(nuevoUsuario, suRol, miConexion);
    }

    public String registrarFormularioDeContactenos(ContactoDto nuevoRegistroContacto) {
        return conDao.insertContactenos(nuevoRegistroContacto, miConexion);
    }
    
    public String registrarTelefono(TelefonoDto nuevoTelefono) {
        return tDao.insertTelefono(nuevoTelefono, miConexion);
    }        

    //Actualizaciones realizadas a la base de datos (Usuario)
    public String actualizarUsuario(UsuarioDto ediUsuario) {
        return uDao.actualizarUsuarioParaUsuario(ediUsuario, miConexion);
    }
    public String cambiarContrasena(String nuevaClave, long documento) {
        return uDao.actualizarClave(nuevaClave, documento, miConexion);
    }

    //Consultas Por Un Criterio (Usuario)
    public String obtenerNombrePorId(long idUsuario) {
        return uDao.obtenerNombresPorId(idUsuario, miConexion);
    }
    
    public String obtenerCorreoPorDocumento(long documento) {
        return uDao.obtenerCorreoPorId(documento, miConexion);
    }
    
    public String obtenerCorreoProductorPorPedido(int idPedido) {
        return uDao.obtenerCorreoProductorPorPedido(idPedido, miConexion);
    }
    
    public String obtenerNombreProductorPorIdProductoAsociado(int idProductoAsociado) {
        return uDao.obtenerNombrePorProductoAsociado(idProductoAsociado, miConexion);
    }
    
    public String obtenerNombreProductorPorIdOferta(int idOferta) {
        return uDao.obtenerNombrePorOferta(idOferta, miConexion);
    }
    
    public StringBuilder validarExistenciaDocumento(long documento) {
        return uDao.validarExistenciaDocumento(documento, miConexion);
    }
    
    public StringBuilder validarExistenciaCorreo(String correo) {
        return uDao.validarExistenciaCorreo(correo, miConexion);
    }

    public UsuarioDto validarLaSesion(long documento) {
        return uDao.validarSesion(documento, miConexion);
    }

    public UsuarioDto obtenerUsuarioPorCorreo(String correo) {
        return uDao.obtenerUsuarioPorCorreo(correo, miConexion);
    }

    public UsuarioDto obtenerUsuarioPorDocumento(long documento) {
        return uDao.obtenerUsuarioPorId(documento, miConexion);
    }

    //Consultas Por Criterio (Roles y Permisos)
    public ArrayList<RolDto> obtenerRolesPorUsuario(long documento) {
        return rlUsuDao.obtenerRolesParaUsuario(documento, miConexion);
    }
    
    public List obtenerPermisosPorRol(int idRol) {
        return perDao.obtenerPermisosPorRol(idRol, miConexion);
    }
    
    //Consultas Por Un Criterio (Ciudades y Departamentos)
    public List obtenerTodosDepartamentos() {
        return depDao.obtenerDepartamentos(miConexion);
    }
    
    public List obtenerCiudadesPorDepartamento(int idDepartamento) {
        return ciDao.obtenerCiudadesPorId(idDepartamento, miConexion);
    }
    
    public String obtenerNombrePorIdCiudad(int idCiudad) {
        return ciDao.obtenerNombrePorId(idCiudad, miConexion);
    }
    
    //Consultas por criterio (Telefonos)
    public List obtenerNumerosPorId(long idUsuario) {
        return tDao.obtenerTelefonosPorId(idUsuario, miConexion);
    }
    
    public String eliminarNUmeroTelefono(String numero) {
        return tDao.eliminarTelefono(numero, miConexion);
    }
}
