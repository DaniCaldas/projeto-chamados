<%@page import="model.dao.UsuarioDAO"%>
<%@page import="model.Chamados"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Editar Chamado</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }
            .container {
                background-color: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                max-width: 500px;
                width: 100%;
            }
            h1 {
                text-align: center;
                color: #333;
                margin-bottom: 20px;
            }
            form {
                display: flex;
                flex-direction: column;
                gap: 15px;
            }
            label {
                font-weight: bold;
                margin-bottom: 5px;
                color: #555;
            }
            input[type="text"],
            textarea,
            input[type="datetime-local"] {
                width: 100%;
                max-width: 478px;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-size: 14px;
            }
            textarea {
                resize: none;
            }
            .button-group {
                display: flex;
                justify-content: space-between;
                gap: 10px;
            }
            .button-group input,
            .button-group a button {
                flex: 1;
                padding: 10px;
                border: none;
                border-radius: 4px;
                font-size: 14px;
                cursor: pointer;
            }
            .button-group input[type="submit"] {
                background-color: #007bff;
                color: #fff;
            }
            .button-group input[type="submit"]:hover {
                background-color: #0056b3;
            }
            .button-group a button {
                background-color: #dc3545;
                color: #fff;
            }
            .button-group a button:hover {
                background-color: #a71d2a;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Editar Chamado</h1>
            <%
                String id = request.getParameter("id");
                Chamados chamado = new Chamados();
                chamado.setId(Integer.parseInt(id));
                UsuarioDAO usuDAO = new UsuarioDAO();
                if (usuDAO.PesquisaChamado(chamado) == null) {
            %>
            <p style="text-align: center; color: red;">Chamado não encontrado!</p>
            <div class="button-group">
                <a href="../destino.html"><button>Voltar</button></a>
            </div>
            <%
                } else {
            %>
            <form action="update.jsp" method="POST">
                <!-- Campo id não editável "disabled" -->
                <label for="id">ID</label>
                <input type="text" id="id" value="<%= chamado.getId() %>" disabled>

                <!-- Campo oculto para enviar o valor do id -->
                <input type="hidden" name="id" value="<%= chamado.getId() %>">

                <!-- Campo título -->
                <label for="titulo">Título</label>
                <input type="text" id="titulo" name="titulo" value="<%= chamado.getTitulo() %>">

                <!-- Campo descrição -->
                <label for="descricao">Descrição</label>
                <textarea id="descricao" name="descricao" rows="5"><%= chamado.getDescricao() %></textarea>

                <!-- Campo data de início -->
                <label for="data_inicio">Data de Início</label>
                <input type="datetime-local" id="data_inicio" name="data_inicio" value="<%= chamado.getData_inicio() %>">

                <!-- Campo data de fim -->
                <label for="data_fim">Data de Finalização</label>
                <input type="datetime-local" id="data_fim" name="data_fim" value="<%= chamado.getData_fim() %>">

                <div class="button-group">
                    <input type="submit" value="Salvar Alterações">
                    <a href="../destino.html"><button type="button">Voltar</button></a>
                </div>
            </form>
            <%
                }
            %>
        </div>
    </body>
</html>
