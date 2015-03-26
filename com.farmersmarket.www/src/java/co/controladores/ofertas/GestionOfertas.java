/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package co.controladores.ofertas;

import co.modulo.ofertas.FOferta;
import co.modulo.ofertas.dtos.OfertaDto;
import co.modulo.ofertas.dtos.PromocionDto;
import co.utilidades.Correo;
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
public class GestionOfertas extends HttpServlet {

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
        FOferta faOfer = new FOferta();
        String salida;
        String correo = "";
        String mensajeCorreo = "";

        if (request.getParameter("opEnviar") != null && request.getParameter("opEnviar").equals("Publicar")) {
            int idProductoAso = Integer.parseInt(request.getParameter("idProductoAsociado"));
            //Validamos que el producto asociado no se haya ofertado y que la oferta esté activa
            if (faOfer.validarProductoOfertado(idProductoAso)) {
                float precioVenta = Float.parseFloat(request.getParameter("opPrecioVenta"));
                float cantidad = Float.parseFloat(request.getParameter("opCantidad"));
                String descripcionPromo = request.getParameter("opDescripcionPromocion");
                float detallePromo = Float.parseFloat(request.getParameter("opDetalle"));
                long idUsuario = Long.parseLong(request.getParameter("opidProductor"));

                //Validamos el número de ofertas que tiene el usuario
                if (faOfer.obtenerCuposOferta(idUsuario) < 5) {
                    OfertaDto nuevaOferta = new OfertaDto();
                    nuevaOferta.setIdProductoAsociado(idProductoAso);
                    nuevaOferta.setPrecioCompra(precioVenta);
                    nuevaOferta.setCantidadDisponible(cantidad);
                    nuevaOferta.setEstado(1);

                    PromocionDto promo = new PromocionDto();
                    promo.setDescripcion(descripcionPromo);
                    promo.setDetalle(detallePromo);

                    salida = faOfer.publicaroferta(nuevaOferta, promo);

                    if (salida.equals("ok")) {
                        if (Correo.sendMail("Productos Asociados", mensajeCorreo, correo)) {
                            //Respuesta afirmativa y envío de correo
                            response.sendRedirect("pages/misproductos.jsp?msg=<strong>¡Publicación Éxitosa! <i class='glyphicon glyphicon-ok'></i></strong> Su producto se publico de manera satisfactoria.&tipoAlert=success");
                        } else {
                            //Respuesta afirmativa y no se envío de correo
                            response.sendRedirect("pages/misproductos.jsp?msg=<strong>¡Publicación Éxitosa! <i class='glyphicon glyphicon-ok'></i></strong> Su producto se publico de manera satisfactoria.&tipoAlert=success");
                        }
                    } else if (salida.equals("okno")) {
                        //Respuesta desconocida, no se realizó
                        response.sendRedirect("pages/misproductos.jsp?msg=<strong><i class='glyphicon glyphicon-exclamation-sign'></i> ¡Algo salió mal!</strong> Por favor intentelo de nuevo.&tipoAlert=warning");
                    } else {
                        //Respuesta conocida, no se realizó
                        response.sendRedirect("pages/misproductos.jsp?msg=<strong><i class='glyphicon glyphicon-exclamation-sign'></i> ¡Ocurrió un error!</strong> Detalle: " + salida + "&tipoAlert=danger");
                    }
                } else {
                    response.sendRedirect("pages/misproductos.jsp?msg=<strong><i class='glyphicon glyphicon-exclamation-sign'></i> ¡No tenes más de 5 ofertas activas!</strong> Por politicas del sitio, sólo puede publicar y tener 5 ofertas activas.&tipoAlert=warning");
                }
            }
        } else if (request.getParameter("op") != null && request.getParameter("op").equals("eliofer")) {
            int idOferta = Integer.parseInt(request.getParameter("idOferta"));
            salida = faOfer.elimiarOferta(idOferta);

            if (salida.equals("ok")) {
                response.sendRedirect("pages/misofertas.jsp?msg=<strong>¡Se eliminó la oferta! <i class='glyphicon glyphicon-ok'></i></strong>.&tipoAlert=success");
            } else if (salida.equals("okno")) {
                //Respuesta desconocida, no se realizó
                response.sendRedirect("pages/misofertas.jsp?msg=<strong><i class='glyphicon glyphicon-exclamation-sign'></i> ¡Algo salió mal!</strong> Por favor intentelo de nuevo.&tipoAlert=warning");
            } else {
                //Respuesta conocida, no se realizó
                response.sendRedirect("pages/misproductos.jsp?msg=<strong><i class='glyphicon glyphicon-exclamation-sign'></i> ¡Ocurrió un error!</strong> Detalle: " + salida + "&tipoAlert=danger");
            }
        } else if (request.getParameter("opaEnviar") != null && request.getParameter("opaEnviar").equals("Agregar")) {
            int idOferta = Integer.parseInt(request.getParameter("idOferta"));
            String descripcion = request.getParameter("opaDescripcionPromocion");
            float detalle = Float.parseFloat(request.getParameter("opaDetalle"));

            PromocionDto nuPromo = new PromocionDto();
            nuPromo.setDescripcion(descripcion);
            nuPromo.setDetalle(detalle);

            salida = faOfer.agregarPromocion(nuPromo, idOferta);

            if (salida.equals("ok")) {
                response.sendRedirect("pages/misofertas.jsp?msg=<strong>¡Se agregó la promoción! <i class='glyphicon glyphicon-ok'></i></strong> Su promoción se agregó correctamente.&tipoAlert=success");
            } else if (salida.equals("okno")) {
                //Respuesta desconocida, no se realizó
                response.sendRedirect("pages/misofertas.jsp?msg=<strong><i class='glyphicon glyphicon-exclamation-sign'></i> ¡Algo salió mal!</strong> Por favor intentelo de nuevo.&tipoAlert=warning");
            } else {
                //Respuesta conocida, no se realizó
                response.sendRedirect("pages/misproductos.jsp?msg=<strong><i class='glyphicon glyphicon-exclamation-sign'></i> ¡Ocurrió un error!</strong> Detalle: " + salida + "&tipoAlert=danger");
            }
        } else if (request.getParameter("opacEnviar") != null && request.getParameter("opacEnviar").equals("Actualizar")) {
            int idPromocion = Integer.parseInt(request.getParameter("opacidPromocion"));
            String descripcion = request.getParameter("opacDescripcionPromocion");
            float detalle = Float.parseFloat(request.getParameter("opacDetalle"));

            PromocionDto ediPromo = new PromocionDto();
            ediPromo.setIdPromocion(idPromocion);
            ediPromo.setDescripcion(descripcion);
            ediPromo.setDetalle(detalle);

            salida = faOfer.actualizarPromocion(ediPromo);
            if (salida.equals("ok")) {
                response.sendRedirect("pages/misofertas.jsp?msg=<strong>¡Se actualizó la promoción! <i class='glyphicon glyphicon-ok'></i></strong> Su promoción se actualizado correctamente.&tipoAlert=success");
            } else if (salida.equals("okno")) {
                //Respuesta desconocida, no se realizó
                response.sendRedirect("pages/misofertas.jsp?msg=<strong><i class='glyphicon glyphicon-exclamation-sign'></i> ¡Algo salió mal!</strong> Por favor intentelo de nuevo.&tipoAlert=warning");
            } else {
                //Respuesta conocida, no se realizó
                response.sendRedirect("pages/misproductos.jsp?msg=<strong><i class='glyphicon glyphicon-exclamation-sign'></i> ¡Ocurrió un error!</strong> Detalle: " + salida + "&tipoAlert=danger");
            }
        } else if (request.getParameter("opaEnviar") != null && request.getParameter("opaEnviar").equals("ok")) {
            int idOferta = Integer.parseInt(request.getParameter("opaIdOferta"));
            float cantidad = Float.parseFloat(request.getParameter("opaCantidad"));
            float precio = Float.parseFloat(request.getParameter("opaPrecioVenta"));

            OfertaDto ediOfer = new OfertaDto();
            ediOfer.setIdOferta(idOferta);
            ediOfer.setCantidadDisponible(cantidad);
            ediOfer.setPrecioCompra(precio);

            salida = faOfer.actualizarOferta(ediOfer);

            if (salida.equals("ok")) {
                response.sendRedirect("pages/misofertas.jsp?msg=<strong>¡Se actualizó la oferta! <i class='glyphicon glyphicon-ok'></i></strong> Su oferta se actualizado correctamente.&tipoAlert=success");
            } else if (salida.equals("okno")) {
                //Respuesta desconocida, no se realizó
                response.sendRedirect("pages/misofertas.jsp?msg=<strong><i class='glyphicon glyphicon-exclamation-sign'></i> ¡Algo salió mal!</strong> Por favor intentelo de nuevo.&tipoAlert=warning");
            } else {
                //Respuesta conocida, no se realizó
                response.sendRedirect("pages/misproductos.jsp?msg=<strong><i class='glyphicon glyphicon-exclamation-sign'></i> ¡Ocurrió un error!</strong> Detalle: " + salida + "&tipoAlert=danger");
            }
        }
        
        out.print("no entró a nada");
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
