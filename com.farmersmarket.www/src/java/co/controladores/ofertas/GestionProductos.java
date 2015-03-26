/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package co.controladores.ofertas;

import co.utilidades.Correo;
import co.modulo.ofertas.FOferta;
import co.modulo.usuarios.FUsuario;
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
public class GestionProductos extends HttpServlet {

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

        FOferta faOfer = new FOferta();
        FUsuario faUsu = new FUsuario();
        String salida;
        String correo;
        String mensajeCorreo;
        //Asociar un Producto
        if (request.getParameter("apEnviar") != null && request.getParameter("apEnviar").equals("Asociar")) {
            String codeProductosEnString[];
            long idProductor = Long.parseLong(request.getParameter("apidProductor"));
            codeProductosEnString = request.getParameterValues("apProductos");
            int cantidadDisponible;

            //Validamos que el usuario pueda asociar más productos (MÁXIMO 7 Productos)
            int cantidadAcomulada = Integer.parseInt(faOfer.obtenerNumeroDeProductosAsociadosPorProducto(idProductor));
            if (codeProductosEnString.length <= 7) {
                if (7 > cantidadAcomulada) {
                    cantidadDisponible = cantidadAcomulada - 7;

                    //Validamos que la cantidad que disponible sea menor o igual a la cantidad que seleccionó
                    if (cantidadDisponible <= codeProductosEnString.length) {
                        int codeProductosInt[] = new int[codeProductosEnString.length];
                        boolean poderAsociar = false;
                        for (int i = 0; i < codeProductosEnString.length; i++) {
                            codeProductosInt[i] = Integer.parseInt(codeProductosEnString[i]);
                            if (faOfer.validarProductoYaAsociado(idProductor, codeProductosInt[i])) {
                                poderAsociar = true;
                            }
                        }

                        //Después de validar todos los productos, en caso de que alguno de ellos ya se haya asociado, retornará un falso
                        if (poderAsociar) {
                            salida = faOfer.asociarProductos(idProductor, codeProductosInt);

                            mensajeCorreo = "Se le han asociado unos productos a petición suya.";

                            correo = faUsu.obtenerCorreoPorDocumento(idProductor);

                            if (salida.equals("ok")) {
                                if (Correo.sendMail("Productos Asociados", mensajeCorreo, correo)) {
                                    //Respuesta afirmativa y envío de correo
                                    response.sendRedirect("pages/asociarproducto.jsp?msg=<strong>¡Asociasión Éxitosa! <i class='glyphicon glyphicon-ok'></i></strong> Revise su correo para ver el listado de productos ó mírelos en Mis Productos.&tipoAlert=success");
                                } else {
                                    //Respuesta afirmativa y no se envío de correo
                                    response.sendRedirect("pages/asociarproducto.jsp?msg=<strong>¡Asociasión Éxitosa! <i class='glyphicon glyphicon-ok'></i></strong> Mírelos en Mis Productos.&tipoAlert=success");
                                }
                            } else if (salida.equals("okno")) {
                                //Respuesta desconocida, no se realizó
                                response.sendRedirect("pages/asociarproducto.jsp?msg=<strong><i class='glyphicon glyphicon-exclamation-sign'></i> ¡Algo salió mal!</strong> Por favor intentelo de nuevo.&tipoAlert=warning");
                            } else {
                                //Respuesta conocida, no se realizó
                                response.sendRedirect("pages/asociarproducto.jsp?msg=<strong><i class='glyphicon glyphicon-exclamation-sign'></i> ¡Ocurrió un error!</strong> Detalle: " + salida + "&tipoAlert=danger");
                            }
                        } else {
                            //respuesta a productos ya asociados anteriormente.
                            response.sendRedirect("pages/asociarproducto.jsp?msg=<strong><i class='glyphicon glyphicon-exclamation-sign'></i> ¡Producto(s) ya asociado(s)!</strong> Por favor intentelo de nuevo, no puede asociar un producto dos veces.&tipoAlert=warning");
                        }
                    } else {
                        //Respuesta denegada, por máximo de productos asociados, tiene cupo, pero seleccionó más de lo disponible
                        response.sendRedirect("pages/asociarproducto.jsp?msg=<strong>Número Máximo de Productos</strong> <i class='glyphicon glyphicon-remove'></i> Tiene cupo disponible, pero lo sobrepasó. Cupos disponibles: " + cantidadDisponible + ".&tipoAlert=danger");
                    }
                } else {
                    //Respuesta denegada, por máximo de productos asociados.
                    response.sendRedirect("pages/asociarproducto.jsp?msg=<strong>Número Máximo de Productos</strong> <i class='glyphicon glyphicon-remove'></i> Sólo pude tener asociado 7 productos como máximo. Tiene: " + cantidadAcomulada + " productos asociados.&tipoAlert=danger");
                }
            } else {
                response.sendRedirect("pages/asociarproducto.jsp?msg=<strong>No puedes asociar más de 7 productos</strong> <i class='glyphicon glyphicon-remove'></i> Intenta asociar menos productos.&tipoAlert=danger");
            }
            //Eliminar Producto Asociado
        } else if (request.getParameter("op") != null && request.getParameter("op").equals("eliaso")) {
            int idProductoAso = Integer.parseInt(request.getParameter("idProductoAso"));
            //Validar que el producto a eliminar, no esé asociado
            if (faOfer.validarProductoOfertado(idProductoAso)) {
                salida = faOfer.eliminarAsociasionDeProducto(idProductoAso);
                if (salida.equals("ok")) {
                    //Respuesta afirmativa, se eliminó el producto
                    response.sendRedirect("pages/misproductos.jsp?msg=<strong>¡Eliminación Éxitosa! <i class='glyphicon glyphicon-ok'></i></strong> Se desasocio el producto.&tipoAlert=success");
                } else if (salida.equals("okno")) {
                    //Respuesta desconocida, no se realizó
                    response.sendRedirect("pages/misproductos.jsp?msg=<strong><i class='glyphicon glyphicon-exclamation-sign'></i> ¡Algo salió mal!</strong> Por favor intentelo de nuevo.&tipoAlert=warning");
                } else {
                    //Respuesta conocida, no se realizó
                    response.sendRedirect("pages/misproductos.jsp?msg=<strong><i class='glyphicon glyphicon-exclamation-sign'></i> ¡Ocurrió un error!</strong> Detalle: " + salida + "&tipoAlert=danger");
                }
            } else {
                response.sendRedirect("pages/misproductos.jsp?msg=<strong><i class='glyphicon glyphicon-exclamation-sign'></i> ¡No se pudo eliminar!</strong> El producto está ofertado, concluya la oferta del producto primero.&tipoAlert=warning");
            }
        }
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
