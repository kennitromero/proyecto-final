/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package co.controladores.pedidos;

import co.modulo.pedidos.FPedido;
import co.modulo.pedidos.dtos.PedidoDto;
import co.modulo.usuarios.FUsuario;
import co.utilidades.Correo;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Sammy Guergachi <sguergachi at gmail.com>
 */
public class GestionPedidos extends HttpServlet {

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
        FPedido faPe = new FPedido();
        FUsuario faUsu = new FUsuario();
        String salida = "";
        String mensajeCorreo = "";
        String correo = "";

        //Realizar un pedido
        if (request.getParameter("rpEnviar") != null && request.getParameter("rpEnviar").equals("ok")) {
            int idOferta = Integer.parseInt(request.getParameter("rpOferta"));
            long idCliente = Long.parseLong(request.getParameter("rpCliente"));
            float precioFinal = Float.parseFloat(request.getParameter("precioDescuento"));
            float cantidadPedida = Float.parseFloat(request.getParameter("cantidadSolicitada"));

            if (faPe.validarCantidadPedido(idOferta, cantidadPedida)) {
                PedidoDto nuevoPedido = new PedidoDto();
                nuevoPedido.setIdOferta(idOferta);
                nuevoPedido.setIdCliente(idCliente);
                nuevoPedido.setPrecioTotalFinal(precioFinal);
                nuevoPedido.setCantidadPedido(cantidadPedida);

                salida = faPe.registrarPedido(nuevoPedido);

                if (salida.equals("ok")) {
                    if (Correo.sendMail("Producto Pedido", mensajeCorreo, correo)) {
                        //Respuesta afirmativa y envío de correo
                        response.sendRedirect("pages/ofertas.jsp?msg=<strong>¡Pedido Exitoso! <i class='glyphicon glyphicon-ok'></i></strong> Usted le ha hecho un pedido exitosamente.&tipoAlert=success");
                    } else {
                        //Respuesta afirmativa y no se envío de correo
                        response.sendRedirect("pages/ofertas.jsp?msg=<strong>¡Pedido Exitoso! <i class='glyphicon glyphicon-ok'></i></strong> Usted le ha hecho un pedido exitosamente.&tipoAlert=info");
                    }
                } else if (salida.equals("okno")) {
                    //Respuesta desconocida, no se realizó
                    response.sendRedirect("pages/ofertas.jsp?msg=<strong><i class='glyphicon glyphicon-exclamation-sign'></i> ¡Algo salió mal!</strong> Por favor intentelo de nuevo.&tipoAlert=warning");
                } else {
                    //Respuesta conocida, no se realizó
                    response.sendRedirect("pages/ofertas.jsp?msg=<strong><i class='glyphicon glyphicon-exclamation-sign'></i> ¡Ocurrió un error!</strong> Detalle: " + salida + "&tipoAlert=danger");
                }
            } else {
                response.sendRedirect("pages/ofertas.jsp?msg=<strong><i class='glyphicon glyphicon-exclamation-sign'></i> ¡Ups!</strong> No puede pedir más de la cantidad disponible en la oferta, intentelo de nuevo.&tipoAlert=warning");
            }

            //Gestionar un pedido | Caso: Cancelar || Cliente
        } else if (request.getParameter("gpEnviarc") != null) {
            if (request.getParameter("gpAccion").equals("cancelar")) {
                int idPedido = Integer.parseInt(request.getParameter("gpPedido"));
                String comentario = request.getParameter("gpComentario");
                if (faPe.retornarCantidadPedida(idPedido)) {
                    salida = faPe.cambiarEstadoPedido(idPedido, 3);

                    mensajeCorreo = "El cliente ha solicitado cancelar el pedido (Código del pedido: " + idPedido + ") por el siguiente motivo: " + comentario;
                    correo = faUsu.obtenerCorreoProductorPorPedido(idPedido);

                    if (salida.equals("ok")) {
                        if (Correo.sendMail("Pedido Cancelado", mensajeCorreo, correo)) {
                            //Respuesta afirmativa, se cambió el estado a Cancelado y envío de correo al productor
                            response.sendRedirect("pages/mispedidosc.jsp?msg=<strong>¡Pedido Cancelado! <i class='glyphicon glyphicon-ok'></i></strong> Usted cancelo el pedido, se le notificará al productor por correo.&tipoAlert=success");
                        } else {
                            //Respuesta afirmativa, se cambió el estado a Cancelado, pero no se envío de correo
                            response.sendRedirect("pages/mispedidosc.jsp?msg=<strong>¡Pedido Cancelado! <i class='glyphicon glyphicon-ok'></i></strong> Usted cancelo el pedido.&tipoAlert=success");
                        }
                    } else if (salida.equals("okno")) {
                        //Respuesta desconocida, no se realizó el cambio de estado a Cancelado
                        response.sendRedirect("pages/mispedidosc.jsp?msg=<strong><i class='glyphicon glyphicon-exclamation-sign'></i> ¡Algo salió mal!</strong> Por favor intentelo de nuevo.&tipoAlert=warning");
                    } else {
                        //Respuesta conocida, no se realizó el cambio de estado
                        response.sendRedirect("pages/mispedidosc.jsp?msg=<strong><i class='glyphicon glyphicon-exclamation-sign'></i> ¡Ocurrió un error!</strong> Detalle: " + salida + "&tipoAlert=danger");
                    }
                } else {
                    response.sendRedirect("pages/mispedidosc.jsp?msg=<strong><i class='glyphicon glyphicon-exclamation-sign'></i> ¡Algo salió mal!</strong> Por favor intentelo de nuevo.&tipoAlert=warning");
                }
                //Gestionar un pedido | Caso: Entregar
            } else if (request.getParameter("gpAccion2").equals("entregado")) {
                int idPedido = Integer.parseInt(request.getParameter("gpPedido"));
                String comentario = request.getParameter("gpComentario");
                //Hacer un update al pedido para luego poder cambiar el estado PENDIENTE
                salida = faPe.cambiarEstadoPedido(idPedido, 2);

                mensajeCorreo = "El cliente ha recibido su pedido (Código del pedido: " + idPedido + ") y agregó el siguiente comentario: " + comentario;
                correo = faUsu.obtenerCorreoProductorPorPedido(idPedido);

                if (salida.equals("ok")) {
                    if (Correo.sendMail("Pedido Entregado", mensajeCorreo, correo)) {
                        //Respuesta afirmativa, se cambió el estado a Cancelado y envío de correo al productor
                        response.sendRedirect("pages/mispedidosc.jsp?msg=<strong>¡Pedido Entregado! <i class='glyphicon glyphicon-ok'></i></strong> Se le notificó al productor por correo que el pedido fue entregado.&tipoAlert=success");
                    } else {
                        //Respuesta afirmativa, se cambió el estado a Cancelado, pero no se envío de correo
                        response.sendRedirect("pages/mispedidosc.jsp?msg=<strong>¡Pedido Entregado! <i class='glyphicon glyphicon-ok'></i></strong> Se le notificó al productor.&tipoAlert=success");
                    }
                } else if (salida.equals("okno")) {
                    //Respuesta desconocida, no se realizó el cambio de estado a Cancelado
                    response.sendRedirect("pages/mispedidosc.jsp?msg=<strong><i class='glyphicon glyphicon-exclamation-sign'></i> ¡Algo salió mal!</strong> Por favor intentelo de nuevo.&tipoAlert=warning");
                } else {
                    //Respuesta conocida, no se realizó el cambio de estado
                    response.sendRedirect("pages/mispedidosc.jsp?msg=<strong><i class='glyphicon glyphicon-exclamation-sign'></i> ¡Ocurrió un error!</strong> Detalle: " + salida + "&tipoAlert=danger");
                }
            } else {
                response.sendRedirect("pages/mispedidosc.jsp?msg=<strong><i class='glyphicon glyphicon-exclamation-sign'></i> ¡No permitido!</strong> No tiene permisos para entrar.&tipoAlert=warning");
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
