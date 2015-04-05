package co.controladores.usuarios;

import co.utilidades.Correo;
import co.modulo.usuarios.FUsuario;
import co.modulo.usuarios.dtos.ContactoDto;
import co.modulo.usuarios.dtos.RolDto;
import co.modulo.usuarios.dtos.TelefonoDto;
import co.modulo.usuarios.dtos.UsuarioDto;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author kennross
 */
public class GestionUsuarios extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        request.setCharacterEncoding("UTF-8");

        FUsuario faUsu = new FUsuario();
        String salida;
        String correo;
        String mensajeCorreo;

        //Registro de un usuario dentro del sistema
        if (request.getParameter("botonRegistro") != null && request.getParameter("botonRegistro").equals("Registrarme")) {
            RolDto suRol = new RolDto();
            suRol.setIdRol(Integer.parseInt(request.getParameter("ruRol")));

            UsuarioDto nuevoUsuario = new UsuarioDto();
            nuevoUsuario.setIdUsuario(Long.parseLong(request.getParameter("ruDocumento")));
            nuevoUsuario.setNombres(request.getParameter("ruNombres"));
            nuevoUsuario.setApellidos(request.getParameter("ruApellidos"));
            nuevoUsuario.setClave(request.getParameter("ruClave"));
            nuevoUsuario.setCorreo(request.getParameter("ruCorreo"));
            nuevoUsuario.setFechaNacimiento(request.getParameter("ruFechaNacimiento"));
            nuevoUsuario.setDireccion(request.getParameter("ruDireccion"));
            nuevoUsuario.setIdCiudad(Integer.parseInt(request.getParameter("ruCiudad")));
            nuevoUsuario.setImagen("img/avatars/user.png");
            nuevoUsuario.setEstado(1);

            salida = faUsu.registrarUsuario(nuevoUsuario, suRol);            
            

            if (salida.equals("ok")) {
                response.sendRedirect("index.jsp?msg=<strong><i class='glyphicon glyphicon-ok'></i> ¡Registro Éxitoso!</strong> Revise su correo para activar cuenta, puede iniciar sesión.&tipoAlert=success");
            } else if (salida.equals("okno")) {
                response.sendRedirect("index.jsp?msg=<strong><i class='glyphicon glyphicon-exclamation-sign'></i> ¡Algo salió mal!</strong> Por favor intentelo de nuevo.&tipoAlert=warning");
            } else {
                response.sendRedirect("index.jsp?msg=<strong><i class='glyphicon glyphicon-exclamation-sign'></i> ¡Ocurrió un error!</strong> Detalle: " + salida + "&tipoAlert=danger");
            }
            
            //Cambio o Actualización de la contraseña de usuario
        } else if (request.getParameter("formCambiarClave") != null && request.getParameter("formCambiarClave").equals("ok")) {
            String claveAntigua = request.getParameter("ccClaveAntigua");
            String claveNueva = request.getParameter("ccClaveNueva");
            String claveNuevaRepetida = request.getParameter("ccClaveRepetida");
            long documento = Long.parseLong(request.getParameter("ccDocumento"));
            String viene = request.getParameter("ccViene");

            if (claveAntigua != null && claveNueva != null && claveNuevaRepetida != null && documento != 0) {                
                UsuarioDto usuario;

                usuario = faUsu.validarLaSesion(documento);

                if (usuario.getClave().equals(claveAntigua)) {
                    salida = faUsu.cambiarContrasena(claveNueva, documento);

                    mensajeCorreo = "Se ha cambiado su contraseña, a nueva contraseña es: " + claveNueva + " y la antigua era: " + claveAntigua;

                    correo = faUsu.obtenerCorreoPorDocumento(documento);

                    if (salida.equals("ok")) {
                        if (Correo.sendMail("Contraseña Cambiada", mensajeCorreo, correo)) {
                            response.sendRedirect("pages/" + viene + ".jsp?msg=<strong>¡Cambio Éxitoso! <i class='glyphicon glyphicon-ok'></i></strong> La contraseña se cambió correctamente, revise su correo.&tipoAlert=success");
                        } else {
                            response.sendRedirect("pages/" + viene + ".jsp?msg=<strong>¡Cambio Éxitoso! <i class='glyphicon glyphicon-ok'></i></strong> La contraseña se cambió correctamente, " + usuario.getCorreo() + " no envió correo.&tipoAlert=success");
                        }
                    } else if (salida.equals("okno")) {
                        response.sendRedirect("pages/" + viene + ".jsp?msg=<strong><i class='glyphicon glyphicon-exclamation-sign'></i> ¡Algo salió mal!</strong> Por favor intentelo de nuevo.&tipoAlert=warning");
                    } else {
                        response.sendRedirect("pages/" + viene + ".jsp?msg=<strong><i class='glyphicon glyphicon-exclamation-sign'></i> ¡Ocurrió un error!</strong> Detalle: " + salida + "&tipoAlert=danger");
                    }
                } else {
                    response.sendRedirect("pages/" + viene + ".jsp?msg=<strong>¡Contraseña Antigua Incorrecta!</strong> Por favor, Intente de nuevo <i class='glyphicon glyphicon-remove'></i>&tipoAlert=danger");
                }
            }            
            //Envío de Formulairo de Contáctenos :3
        } else if (request.getParameter("mcEnviar") != null && request.getParameter("mcEnviar").equals("ok")) {
            ContactoDto nuevoMensajeContacto = new ContactoDto();
            nuevoMensajeContacto.setNombreCompleto(request.getParameter("mcNombre"));
            nuevoMensajeContacto.setCorreo(request.getParameter("mcCorreo"));
            nuevoMensajeContacto.setMensaje(request.getParameter("mcMensaje"));

            String viene = request.getParameter("mcViene");
            
            mensajeCorreo = "Tiene un nuevo mensaje de Contáctenos, revíselo";
            correo = "thekenyr@hotmail.com";
            
            salida = faUsu.registrarFormularioDeContactenos(nuevoMensajeContacto);

            if (salida.equals("ok")) {
                if (Correo.sendMail("Nuevo Mensaje de Contactenos", mensajeCorreo, correo)) {
                            response.sendRedirect("pages/" + viene + ".jsp?msg=<strong>¡Mensaje Enviado Éxitosamente! <i class='glyphicon glyphicon-ok'></i></strong> Nos pondremos en contacto con usted cuando leamos el mensaje.&tipoAlert=success");
                        } else {
                            response.sendRedirect("pages/" + viene + ".jsp?msg=<strong>¡Mensaje Enviado Éxitosamente! <i class='glyphicon glyphicon-ok'></i></strong>&tipoAlert=success");
                        }                
            } else if (salida.equals("okno")) {
                response.sendRedirect("pages/" + viene + ".jsp?msg=<strong><i class='glyphicon glyphicon-exclamation-sign'></i> ¡Algo salió mal!</strong> Por favor intentelo de nuevo.&tipoAlert=warning");
            } else {
                response.sendRedirect("pages/" + viene + ".jsp?msg=<strong><i class='glyphicon glyphicon-exclamation-sign'></i> ¡Ocurrió un error!</strong> Detalle: " + salida + "&tipoAlert=danger");
            }
            
            //Recuperación de la contraseña a través de correo electrónico
        } else if (request.getParameter("rcEnviar") != null && request.getParameter("rcEnviar").equals("ok")) {

            correo = request.getParameter("rcCorreo");
            UsuarioDto usuario;

            usuario = faUsu.obtenerUsuarioPorCorreo(correo);

            correo = usuario.getCorreo();
            mensajeCorreo = "Usted ha pedido recuperar su contraseña, su contraseña es: " + usuario.getClave() + " <br><strong>Le recomendamos que la cambie a penas ingrese</strong>";

            if (Correo.sendMail("Recuperar Contraseña", mensajeCorreo, correo)) {
                response.sendRedirect("index.jsp?msg=<strong>¡Recuperación Éxitosa! <i class='glyphicon glyphicon-ok'></i></strong> Revise su correo obtener su contaseña, <strong> Recuerde cambiarla, por su seguridad.</strong>&tipoAlert=success");
            } else {
                response.sendRedirect("index.jsp?msg=<strong>¡No existe! <i class='glyphicon glyphicon-remove'></i></strong> Correo no registrado, <strong> Lo inventamos a registrárse</strong>&tipoAlert=info");
            }
            //Registro de telefonos
        } else if (request.getParameter("rnEnviar") != null) {
            long idUsuario = Long.parseLong(request.getParameter("rnEnviar"));
            String nuevoNumero = request.getParameter("rnNumero");
            
            TelefonoDto nuevoTelefono = new TelefonoDto();
            nuevoTelefono.setIdUsuario(idUsuario);
            nuevoTelefono.setNumero(nuevoNumero);
            
            salida = faUsu.registrarTelefono(nuevoTelefono);
            
            if (salida.equals("ok")) {
                response.sendRedirect("pages/perfil.jsp?msg=<strong>¡Registro Éxitoso! <i class='glyphicon glyphicon-ok'></i></strong> El número quedó registrado a su cuenta.&tipoAlert=success");
            } else if (salida.equals("okno")) {
               response.sendRedirect("pages/perfil.jsp?msg=<strong><i class='glyphicon glyphicon-exclamation-sign'></i> ¡Algo salió mal!</strong> Por favor intentelo de nuevo.&tipoAlert=warning");
            } else {
               response.sendRedirect("pages/perfil.jsp?msg=<strong><i class='glyphicon glyphicon-exclamation-sign'></i> ¡Ocurrió un error!</strong> Detalle: " + salida + "&tipoAlert=danger");
            }
            //Eliminación de telefonos
        } else if (request.getParameter("op") != null && request.getParameter("op").equals("elite")) {
            String numero = request.getParameter("num");
            salida = faUsu.eliminarNUmeroTelefono(numero);
            
            if (salida.equals("ok")) {
                response.sendRedirect("pages/perfil.jsp?msg=<strong>¡Se eliminó correctamente! <i class='glyphicon glyphicon-ok'></i></strong> El número se eliminó de su cuenta.&tipoAlert=info");
            } else if (salida.equals("okno")) {
               response.sendRedirect("pages/perfil.jsp?msg=<strong><i class='glyphicon glyphicon-exclamation-sign'></i> ¡Algo salió mal!</strong> Por favor intentelo de nuevo.&tipoAlert=warning");
            } else {
               response.sendRedirect("pages/perfil.jsp?msg=<strong><i class='glyphicon glyphicon-exclamation-sign'></i> ¡Ocurrió un error!</strong> Detalle: " + salida + "&tipoAlert=danger");
            }
        } else if (request.getParameter("auEnviar") != null && request.getParameter("auEnviar").equals("ok")) {
            UsuarioDto ediUsuario = new UsuarioDto();
            ediUsuario.setIdUsuario(Long.parseLong(request.getParameter("auDocumento")));
            ediUsuario.setNombres(request.getParameter("auNombres"));
            ediUsuario.setApellidos(request.getParameter("auApellidos"));            
            ediUsuario.setCorreo(request.getParameter("auCorreo"));            
            ediUsuario.setDireccion(request.getParameter("auDireccion"));                        

            salida = faUsu.actualizarUsuario(ediUsuario);            
            

            if (salida.equals("ok")) {
                response.sendRedirect("pages/perfil.jsp?msg=<strong><i class='glyphicon glyphicon-ok'></i> ¡Registro Éxitoso!</strong> Revise su correo para activar cuenta, puede iniciar sesión.&tipoAlert=success");
            } else if (salida.equals("okno")) {
                response.sendRedirect("pages/perfil.jsp?msg=<strong><i class='glyphicon glyphicon-exclamation-sign'></i> ¡Algo salió mal!</strong> Por favor intentelo de nuevo.&tipoAlert=warning");
            } else {
                response.sendRedirect("pages/perfil.jsp?msg=<strong><i class='glyphicon glyphicon-exclamation-sign'></i> ¡Ocurrió un error!</strong> Detalle: " + salida + "&tipoAlert=danger");
            }
        }
        request.setCharacterEncoding("UTF-8");
    }
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
