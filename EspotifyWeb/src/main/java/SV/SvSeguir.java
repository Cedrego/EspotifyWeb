/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package SV;

import Logica.Factory;
import Logica.ICtrl;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author camin
 */
@WebServlet(name = "SvSeguir", urlPatterns = {"/SvSeguir"})
public class SvSeguir extends HttpServlet {
    Factory fabric = Factory.getInstance();
    ICtrl ctrl = fabric.getICtrl();

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
        List<String> listClientes = ctrl.obtenerNombresDeCliente(); // Asegúrate que esta línea funciona correctamente
        List<String> listArtistas = ctrl.obtenerNombresDeArtista(); // Verifica también esta línea

        request.setAttribute("listClientes", listClientes);
        request.setAttribute("listArtistas", listArtistas);

        request.getRequestDispatcher("JSP/Seguir.jsp").forward(request, response);
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
        String nickname = "PAPA";
        String cliente = request.getParameter("cliente");
        String artista = request.getParameter("artista");
        String lista = request.getParameter("usuario");
        
        System.out.println("============================");
        System.out.println("Cliente: "+nickname);
        System.out.println("A seguir cli: "+cliente);
        System.out.println("A seguir art: "+artista);
        System.out.println("lista: "+lista);
        System.out.println("============================");
        if (lista != null) {
            ctrl.seguirPerfil(nickname, "Cliente", cliente);
        } else {
            ctrl.seguirPerfil(nickname, "Artista", artista);
        }
        response.sendRedirect("JSP/Seguir.jsp");
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
