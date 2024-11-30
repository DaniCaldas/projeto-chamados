<%@page import="java.util.Random"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.LocalDateTime"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Chamados" %>
<%@page import="model.dao.UsuarioDAO" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
            .message-box {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
                padding: 20px;
                border-radius: 5px;
                width: 80%;
                max-width: 400px;
                text-align: center;
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
        <%
            Random random = new Random();
            String titulo = request.getParameter("titulo");
            String descricao = request.getParameter("descricao");
            String nome_responsavel = (String) session.getAttribute("usuario");
            LocalDateTime data = LocalDateTime.now();
            
            // Formatter para exibir data e hora no início
            DateTimeFormatter formatterDataHora = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            String data_inicio = data.format(formatterDataHora);
            
            Chamados chamado = new Chamados();
            
            int id = random.nextInt(100) + 1;
            chamado.setId(id);
            chamado.setTitulo(titulo);
            chamado.setDescricao(descricao);
            chamado.setData_inicio(data_inicio);
            chamado.setNome_responsavel(nome_responsavel);
            
            UsuarioDAO chamadoDAO = new UsuarioDAO();
            if(chamadoDAO.AbrirChamado(chamado)){
                out.print("Chamado Aberto com Sucesso!");
                response.sendRedirect("../destino.html");
            } else {
        %>
                <div class="message-box">
                    <p>ERRO ao tentar Abrir chamado!</p>
                    <a href="javascript:history.back()" class="btn">Voltar</a>
                </div>
        <%
            }
        %>
    </body>
</html>

