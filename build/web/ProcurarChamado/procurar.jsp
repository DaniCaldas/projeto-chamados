<%-- 
    Document   : procurar
    Created on : 30 de nov. de 2024, 03:12:21
    Author     : danie
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="model.Chamados"%>
<%@page import="java.util.List"%>
<%@page import="model.dao.UsuarioDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }
            .container {
                max-width: 900px;
                margin: 40px auto;
                background: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            h1 {
                text-align: center;
                color: #333;
                margin-bottom: 20px;
            }
            .alert {
                background-color: #ffeeba;
                padding: 15px;
                border: 1px solid #ffc107;
                border-radius: 4px;
                text-align: center;
                color: #856404;
                margin-bottom: 20px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
            }
            table th, table td {
                border: 1px solid #ddd;
                padding: 10px;
                text-align: center;
            }
            table th {
                background-color: #333;
                color: #fff;
            }
            table tr:nth-child(even) {
                background-color: #f9f9f9;
            }
            table tr:hover {
                background-color: #f1f1f1;
            }
            table .description {
                cursor: pointer;
                color: #007bff;
                text-decoration: none;
            }
            table .description:hover {
                text-decoration: underline;
            }
            .button-group {
                text-align: center;
                margin-top: 20px;
            }
            .button-group a {
                display: inline-block;
                background-color: #007bff;
                color: #fff;
                text-decoration: none;
                padding: 10px 15px;
                margin: 0 10px;
                border-radius: 4px;
                transition: background-color 0.3s;
            }
            .button-group a:hover {
                background-color: #0056b3;
            }
            .button-group .btn-danger {
                background-color: #dc3545;
            }
            .button-group .btn-danger:hover {
                background-color: #a71d2a;
            }

            
            .modal {
                display: none; /* Esconde o modal inicialmente */
                position: fixed;
                z-index: 1;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.4); 
            }
            .modal-content {
                background-color: #fff;
                margin: 15% auto;
                padding: 20px;
                border-radius: 8px;
                width: 80%;
                max-width: 600px;
            }
            .close {
                color: #aaa;
                font-size: 28px;
                font-weight: bold;
                float: right;
                cursor: pointer;
            }
            .close:hover,
            .close:focus {
                color: #000;
                text-decoration: none;
                cursor: pointer;
            }
        </style>
        <script>
            // Função para abrir o modal
            function openModal(id) {
                var modal = document.getElementById("myModal-" + id);
                modal.style.display = "block"; // Exibe o modal
            }

            // Função para fechar o modal
            function closeModal(id) {
                var modal = document.getElementById("myModal-" + id);
                modal.style.display = "none"; // Esconde o modal
            }

            // Fecha o modal se o usuário clicar fora da área do modal
            window.onclick = function(event) {
                if (event.target.classList.contains("modal")) {
                    var modals = document.querySelectorAll(".modal");
                    modals.forEach(function(modal) {
                        modal.style.display = "none";
                    });
                }
            }
        </script>
    <body>
       <<div class="container">
            <h1>Todos Chamados</h1>

            <%
            String valor = request.getParameter("valor");
            String opcao = request.getParameter("opcao");
            UsuarioDAO usuDAO = new UsuarioDAO();
            List<Chamados> lista = new ArrayList<>();
            lista = usuDAO.PesquisaChamados(valor, opcao);
            
            if (lista == null || lista.isEmpty()) {
            %>
            <div class="alert">Nenhum chamado aberto.</div>
            <div class="button-group">
                <a href="../destino_ti.html" class="btn">Voltar</a>
            </div>
            <%
            } else {
            %>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Problema</th>
                        <th>Descrição</th>
                        <th>Data de Início</th>
                        <th>Data de Finalização</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>
                <%
                for (Chamados chamado : lista) {
                 String resultadoDataFim = "";
                if(chamado.getData_fim() == null){
                    resultadoDataFim = "Chamado nao finalizado";
                }else{
                    resultadoDataFim = chamado.getData_fim();
                }
                %>
                    <tr>
                    <form action="../FecharChamado/fecharChamado.jsp" method="POST">
                        <input type="text" hidden name="id" value="<%= chamado.getId() %>">
                        <td><%= chamado.getId() %></td>
                        <td><%= chamado.getTitulo() %></td>
                        <td>
                            <span class="description" onclick="openModal(<%= chamado.getId() %>)">Ver descrição</span>
                        </td>
                        <td><%= chamado.getData_inicio() %></td>
                        <td><input type="datetime-local" name="data_fim" value="<%= resultadoDataFim %>"></td>
                        <td>
                            <div class="button-group">
                                <input class="btn" type="submit" value="Fechar Chamado">
                            </div>
                        </td>
                    </form>
                    </tr>
                    
                    <div id="myModal-<%= chamado.getId() %>" class="modal">
                        <div class="modal-content">
                            <span class="close" onclick="closeModal(<%= chamado.getId() %>)">&times;</span>
                            <h2>Descrição Completa</h2>
                            <p><%= chamado.getDescricao() %></p>
                        </div>
                    </div>

                <%
                }
                %>
                </tbody>
            </table>
            <div class="button-group">
                <a href="../destino_ti.html" class="btn">Voltar</a>
            </div>
            <%
            }
            %>
        </div>
    </body>
</html>
