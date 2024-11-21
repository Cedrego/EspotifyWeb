<%-- 
    Document   : Artista
    Created on : 17 oct. 2024, 6:31:10 p. m.
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Artista</title>
        <style>
            /* Reset and basic styles */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                background-color: #333; /* Fondo general */
                color: #FFF; /* Color de texto */
                font-family: 'Poppins', sans-serif; /* Fuente */
                display: flex;
                flex-direction: column;
                height: 100vh; /* Altura completa */
            }

            /* Contenedor principal */
            .container {
                display: flex;
                flex-direction: column;
                flex: 1;
            }

            /* Barra superior */
            .top-bar {
                display: flex;
                align-items: center;
                justify-content: space-between;
                background-color: #1a1a1a;
                padding: 15px;
                color: #1db954;
                font-size: 24px;
                font-weight: bold;
            }

            .top-bar .logo-container {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .logo {
                width: 50px;
                height: 50px;
                margin: 0 auto 20px;
                background-image: url('<%= request.getContextPath() %>/images/logo.png');
                background-size: cover;
                background-position: center;
                border-radius: 5px;
            }

            .client-name {
                color: #FFF; /* Color del nombre del cliente */
                font-size: 20px; /* Tamaño del nombre */
            }

            /* Contenido principal */
            .content {
                display: flex;
                flex: 1;
                background-color: #000; /* Parte central en negro */
            }

            /* Columna izquierda para botones */
            .sidebar {
                width: 20%;
                background-color: #1a1a1a; /* Fondo de la barra lateral */
                padding: 20px;
                display: flex;
                flex-direction: column;
                align-items: center;
                gap: 15px; /* Espacio entre botones */
            }

            .sidebar button {
                background-color: #1db954; /* Color de los botones */
                color: black;
                padding: 10px 15px; /* Relleno para botones */
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px; /* Tamaño de fuente */
                transition: background-color 0.3s ease;
                width: 80%; /* Ancho fijo para los botones */
            }

            .sidebar button:hover {
                box-shadow: 0 0 10px #1db954, 0 0 20px #1db954, 0 0 30px #1db954;
            }

            /* Footer Styles */
            .footer {
                width: 100%;
                background-color: #1a1a1a;
                padding: 10px 20px;
                display: flex;
                justify-content: center;
                align-items: center;
                position: fixed;
                bottom: 0;
                left: 0;
                height: 80px;
            }

            .footer-content {
                display: flex;
                align-items: center;
                width: 100%;
                max-width: 1200px;
                justify-content: space-between;
            }

            /* Imagen y Etiqueta */
            .image-and-label {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .dynamic-image {
                width: 50px;
                height: 50px;
                background-image: url('<%= request.getContextPath()%>/images/noImageSong.png');
                background-size: cover;
                background-position: center;
                border-radius: 5px;
            }

            .song-label {
                color: #FFF;
                font-size: 16px;
                font-weight: bold;
            }

            /* Controles y Barra de Progreso */
            .footer-controls {
                display: flex;
                flex-direction: column;
                align-items: center;
                flex: 1;
            }

            .controls {
                display: flex;
                align-items: center;
                gap: 15px;
                margin-bottom: 5px;
            }

            .controls button {
                background-color: #FFF;
                color: #000;
                border: none;
                border-radius: 50%;
                width: 30px;
                height: 30px;
                cursor: pointer;
                font-size: 16px;
                transition: box-shadow 0.3s ease;
            }

            .slider {
                -webkit-appearance: none;
                width: 80%;
                height: 5px;
                background: #333;
                outline: none;
                opacity: 0.7;
                transition: opacity .2s;
            }
            /* Menú desplegable */
            #dropdown-menu {
                display: none;
                position: absolute;
                top: 100%;
                right: 0;
                background-color: #1a1a1a;
                border: 1px solid #333;
                border-radius: 5px;
                padding: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
            }

            #dropdown-menu a {
                color: #FFF;
                text-decoration: none;
                display: block;
                padding: 5px 10px;
                transition: background-color 0.3s ease; /* Animación de transición */
            }

            /* Efecto de hover */
            #dropdown-menu a:hover {
                background-color: #9e9e9e;
            }
            #toggle-menu a {
                color: #1db954; /* Color inicial del texto */
                text-decoration: none;
                display: block;
                margin-bottom: 10px;
                padding: 10px;
                border-radius: 5px; /* Bordes redondeados */
                transition: background-color 0.3s ease, color 0.3s ease;
            }

            #toggle-menu a:hover {
                background-color: #ff0000; /* Fondo rojo al hacer hover */
                color: #333; /* Color de texto blanco para contraste */
            }

            #toggle-menu button {
                display: block;
                width: 100%;
                margin-bottom: 10px;
                background-color: #1db954;
                color: black;
                border: none;
                border-radius: 5px;
                padding: 10px;
                cursor: pointer;
            }
        </style>
        <script>
            function loadContent(url) {
                document.getElementById('dynamic-content').src = url;
            }
            function buscarResultados() {
                const query = document.getElementById('query').value;
                if (query.length > 1) { // Ejecuta la búsqueda solo si hay al menos 2 caracteres
                    const url = "<%= request.getContextPath()%>/SvBuscador?query=" + encodeURIComponent(query);
                    loadContent(url); // Utiliza loadContent para cargar el URL en el iframe
                } else {
                    // Si la consulta es corta, limpia el iframe
                    loadContent("");
                }
            }
            // Función para mostrar/ocultar el menú
        function toggleMenu() {
            const menu = document.getElementById('toggle-menu');
            if (menu.style.display === 'none' || menu.style.display === '') {
                menu.style.display = 'block'; // Mostrar el menú
            } else {
                menu.style.display = 'none'; // Ocultar el menú
            }
        }

        document.addEventListener('click', function(event) {
            const menu = document.getElementById('toggle-menu');
            const clientNameLink = document.querySelector('.client-name a');

            // Si el menú está abierto y no se hace clic en el enlace para abrirlo
            if (menu.style.display === 'block' && event.target !== clientNameLink) {
                menu.style.display = 'none'; // Cierra el menú
            }
        });

        // Asegura que el enlace de cliente no cierre inmediatamente el menú
        const clientNameLink = document.querySelector('.client-name a');
        clientNameLink.addEventListener('click', function(event) {
            event.stopPropagation(); // Evita que el clic cierre el menú
        });
        </script>
    </head>
    <body>
        <div class="top-bar">
            <div class="logo-container">
                <div class="logo-container">
                    <div class="logo"></div> <!-- Logo aquí -->
                    <div>Espotify</div>
                </div>
            </div>
            <form onsubmit="buscarResultados(); return false;" style="display: flex; align-items: center; gap: 10px;">
                <input type="text" id="query" name="query" placeholder="Buscar álbumes, temas, listas de reproducción" 
                       style="width: 300px; padding: 10px; border-radius: 5px; border: none; font-size: 16px; color: #000; background-color: #FFF;">
                <button type="submit" style="background-color: #1db954; color: black; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; font-size: 16px; font-weight: bold; transition: box-shadow 0.3s ease;">
                    Buscar
                </button>
            </form>

            <div class="client-name">
                <%
                    String nick = (String) session.getAttribute("NickSesion"); // Obtener el nick de la sesión
%>
                <a href="#" onclick="toggleMenu(); return false;" style="color: #FFF; text-decoration: none;">
                    <%= nick%> <!-- Mostrar el nombre del cliente -->
                </a>
            </div>

            <!-- Toggle Menu -->
            <div id="toggle-menu" style="display: none; position: absolute; top: 50px; right: 20px; background-color: #1a1a1a; padding: 10px; border-radius: 5px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.5); z-index: 1000;">
                <button onclick="loadContent('<%= request.getContextPath()%>/JSP/LoadingScreen.jsp')">Ver Perfil</button>
                <button onclick="window.location.href='<%= request.getContextPath()%>/JSP/ArtistaEliminar.jsp'">Dar de Baja</button>
                <button onclick="window.location.href='<%= request.getContextPath()%>/SvCerrarSesion'">Cerrar Sesión</button>
            </div>
        </div>            
        <!-- Main Content -->
        <div class="content">
            <!-- Left Sidebar -->
            <div class="sidebar">
                <button onclick="loadContent('<%= request.getContextPath()%>/JSP/AltaAlbum.jsp')">Alta de Álbum</button>
                <button onclick="loadContent('<%= request.getContextPath()%>/JSP/LoadingScreen.jsp')">Consulta de Perfil de Usuario</button>
                <button onclick="window.location.href='<%= request.getContextPath() %>/SvCerrarSesion'">Cerrar Sesión</button>
            </div>

            <div style="flex: 1; background-color: #000; color: #FFF; padding-bottom: 40px;">
                <iframe id="dynamic-content" style="width: 100%; height: calc(100% - 40px); border: none;" src=""></iframe>
            </div>

            <!-- Footer con controles, imagen y texto -->
            <div class="footer">
                <div class="footer-content">
                    <div class="image-and-label">
                        <div class="dynamic-image"></div> <!-- Imagen de la canción -->
                        <span class="song-label">Nombre de la canción</span> <!-- Etiqueta de texto -->
                    </div>
                    <div class="footer-controls">
                        <div class="controls">
                            <button>&#9664;&#9664;</button> <!-- Botón de retroceso -->
                            <button>&#9654;</button> <!-- Botón de reproducción -->
                            <button>&#9654;&#9654;</button> <!-- Botón de adelanto -->
                        </div>
                        <input type="range" min="0" max="100" value="0" class="slider"> <!-- Barra de progreso -->
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
