<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Usuario" %>
<%@page import="model.dao.UsuarioDAO" %>
<%@page import="util.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
                background-color: #f4f4f4;
            }
            .container {
                text-align: center;
                padding: 20px;
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 400px;
            }
            .error-message {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
                padding: 20px;
                border-radius: 5px;
                margin-top: 20px;
                font-weight: bold;
            }
            .btn {
                background-color: #007bff;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                text-decoration: none;
                display: inline-block;
                margin-top: 10px;
            }
            .btn:hover {
                background-color: #0056b3;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <%
                String nome = request.getParameter("nome");
                String senha = request.getParameter("senha");
                
                Usuario usu = new Usuario();
                usu.setNome(nome);
                usu.setSenha(senha);
                
                // Verificação de login
                UsuarioDAO usuDAO = new UsuarioDAO();
                if (usuDAO.Login(usu)) {
                    if (usu.getNome().equals("TI")) {
                        response.sendRedirect("../destino_ti.html");
                        session.setAttribute("usuario", nome);
                        session.setAttribute("senha", senha);
                    } else {
                        response.sendRedirect("../destino.html");
                        session.setAttribute("usuario", nome);
                        session.setAttribute("senha", senha);
                    }
                } else {
            %>
                <div class="error-message">
                    ERRO ao Logar. Verifique suas credenciais.
                </div>
                <a href="javascript:history.back()" class="btn">Voltar</a>
            <%
                }
            %>
        </div>
    </body>
</html>
