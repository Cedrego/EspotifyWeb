/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package SV;
 
import Logica.Factory;
import Logica.ICtrl;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author User
 */
@WebServlet(name = "SvExisUs", urlPatterns = {"/SvExisUs"})
public class SvExisUs extends HttpServlet {

    Factory fabric =Factory.getInstance();
    ICtrl ctrl = fabric.getICtrl();
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SvExisUs</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SvExisUs at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String Nick = request.getParameter("nick");
        String Email = request.getParameter("email");
        if(ctrl.exisUs(Nick, Email)) {// Si el usuario existe, envía un mensaje de error al JSP
            request.setAttribute("errorMessage", "El usuario ya existe. Intente nuevamente.");
            request.getRequestDispatcher("Registrar.jsp").forward(request, response);
        } else { // Si el usuario no existe, muestra el resto de los campos
            request.setAttribute("showForm", true);
            request.getRequestDispatcher("Registrar.jsp").forward(request, response);
        }
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
