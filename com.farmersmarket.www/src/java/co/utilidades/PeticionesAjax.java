package co.utilidades;

import co.modulo.usuarios.FUsuario;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import co.modulo.usuarios.daos.UsuarioDao;

/**
 *
 * @author kennross
 */
public class PeticionesAjax extends HttpServlet {

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

        FUsuario faUsu = new FUsuario();
        //Verificación de la existencia de un documento
        if ((request.getParameter("idUsuario") != null)) {
            StringBuilder respuesta = new StringBuilder("");            
            

            respuesta.append(faUsu.validarExistenciaDocumento(Long.parseLong(request.getParameter("idUsuario").trim())));

            PrintWriter out = response.getWriter();

            this.writeResponse(response, respuesta.toString());
            //Verificación de la existencia de un correo
        } else if ((request.getParameter("correo") != null)) {
            StringBuilder respuesta = new StringBuilder("");
            UsuarioDao uDao = new UsuarioDao();

            respuesta.append(faUsu.validarExistenciaCorreo(request.getParameter("correo").trim()));

            PrintWriter out = response.getWriter();

            //out.print(request.getParameter("correo").trim());

            this.writeResponse(response, respuesta.toString());
        }
    }

    public void writeResponse(HttpServletResponse response, String output) throws IOException {
        response.setContentType("text/plain");
        response.setHeader("Cache-Control", "no-cache");
        response.setHeader("Content", "text/html;charset=iso-8859-1");
        response.getWriter().write(output);
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
