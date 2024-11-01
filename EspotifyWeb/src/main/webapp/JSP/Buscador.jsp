<%-- 
    Document   : Buscador
    Created on : 31 oct. 2024, 15:08:06
    Author     : tecnologo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script>
            function buscar() {
                let query = document.getElementById("query").value;

                if (query.length > 1) { // para que ejecute la búsqueda solo si hay al menos 3 caracteres
                    fetch("<%= request.getContextPath() %>/SvBuscador?query=" + query)
                        .then(response => response.text())
                        .then(data => {
                            document.getElementById("resultados").innerHTML = data;
                        })
                        .catch(error => console.error("Error en búsqueda:", error));
                } else {
                    document.getElementById("resultados").innerHTML = ""; //limpio si no hay consulta
                }
            }
            
            
            // Función para reproducir un tema cuando se hace clic
            function reproducirTema(direccion) {
                const audio = document.getElementById("audioPlayer");
                audio.src = direccion;
                audio.play();
            }
        </script>
        
        <style>
            #resultados {
                border: 1px solid #ccc;
                max-height: 200px;
                overflow-y: auto;
                position: absolute;
                background-color: white;
                width: 100%;
            }

            #resultados p {
                margin: 0;
                padding: 8px;
                cursor: pointer;
            }

            #resultados p:hover {
                background-color: #f0f0f0;
            }
        </style>
    </head>
    <body>
        <h1>Hello World!</h1>
        
        <form action="${pageContext.request.contextPath}/JSP/Resultados.jsp" method="GET">
            <input type="text" id="query" name="query" onkeyup="buscar()" placeholder="Buscar álbumes, temas, listas de reproducción">
            <div id="resultados"></div> <!-- div donde se muestran los resultados en tiempo real -->
            <button type="submit">Buscar</button>
        </form>

            <!-- Reproductor de audio -->
        <!--<audio id="audioPlayer" controls style="display:block; margin-top:20px;"> -->
            <!--Tu navegador no soporta el elemento de audio. -->
        <!--</audio> -->
    </body>
</html>
