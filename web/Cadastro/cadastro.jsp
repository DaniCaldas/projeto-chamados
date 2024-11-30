<%-- 
    Document   : login
    Created on : 21 de nov. de 2024, 21:27:32
    Author     : danie
--%>

<%@page import="java.util.Random"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Usuario" %>
<%@page import="model.dao.UsuarioDAO" %>
<%@page import="util.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastro</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: Arial, sans-serif;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                background: linear-gradient(to bottom, #1a237e, #3949ab);
                color: #fff;
            }

            h1 {
                margin-bottom: 20px;
            }

            .container {
                background: #fff;
                color: #333;
                padding: 20px 30px;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.25);
                text-align: center;
                max-width: 400px;
                width: 100%;
            }

            .container p {
                margin-bottom: 20px;
                font-size: 1rem;
            }

            .btn {
                display: inline-block;
                margin-top: 10px;
                padding: 10px 20px;
                font-size: 1rem;
                color: #fff;
                background-color: #1a237e;
                border: none;
                border-radius: 5px;
                text-decoration: none;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .btn:hover {
                background-color: #0d154a;
            }

            .btn-back {
                margin-top: 15px;
                background-color: #b71c1c;
            }

            .btn-back:hover {
                background-color: #7f0000;
            }
        </style>
    </head>
    <body>
        <h1>Cadastro</h1>
        <div class="container">
            <% 
                Random random = new Random();
                String nome = request.getParameter("nome");
                String email = request.getParameter("email");
                String senha = request.getParameter("senha");

                Usuario usu = new Usuario();
                int id = random.nextInt(100) + 1;
                usu.setId(id);
                usu.setNome(nome);
                usu.setEmail(email);
                usu.setSenha(senha);

                UsuarioDAO usuDAO = new UsuarioDAO();
                if (usuDAO.Cadastrar(usu)) {
            %>
                <p><%= nome %> cadastrado(a) com sucesso!</p>
                <a class="btn" href="../index.html">Ir para Login</a>
            <% 
                } else { 
            %>
                <p>Erro ao cadastrar. Por favor, tente novamente.</p>
                <a class="btn btn-back" href="javascript:history.back()">Voltar</a>
            <% } %>
        </div>
    </body>
</html>
