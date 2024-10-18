<%-- 
    Document   : Registrar
    Created on : 17 oct. 2024, 8:28:49 p. m.
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registrar</title>
    </head>
    <body>
        <h1>Registrese</h1>
         <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
        %>
            <p style="color: red;"><%= errorMessage %></p>
        <%
            }
        %>
        
        <form action="SvExisUs" method="POST">
            <p><lable>Nick :</lable><input type="text" name="nick"</p>
            <p><lable>Email:</lable><input type="text" name="email"</p>
            <button type="submit">Ingresar</button>
        </form>
        <%
            Boolean showForm = (Boolean) request.getAttribute("showForm");
            if (showForm != null && showForm) {
        %>
            <form action="RegistrarUsuario" method="POST">
                <p><label>Nombre:</label><input type="text" name="nombre"></p>
                <p><label>Apellido:</label><input type="text" name="apellido"></p>
                <p><label>Contraseña:</label><input type="password" name="password"></p>
                <button type="submit">Registrar</button>
            </form>
        <%
            }
        %>

    </body>
</html>
