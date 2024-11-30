<%-- 
    Document   : update
    Created on : 26 de nov. de 2024, 15:36:20
    Author     : danie
--%>

<%@page import="model.dao.UsuarioDAO"%>
<%@page import="model.Chamados"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String id = request.getParameter("id");
            String titulo = request.getParameter("titulo");
            String descricao = request.getParameter("descricao");
            String data_inicio = request.getParameter("data_inicio");
            String data_fim = request.getParameter("data_fim");
            
            Chamados chamado = new Chamados();
 
            chamado.setId(Integer.parseInt(id));
            chamado.setTitulo(titulo);
            chamado.setDescricao(descricao);
            chamado.setData_inicio(data_inicio);
            chamado.setData_fim(data_fim);
            
            UsuarioDAO usuDAO = new UsuarioDAO();
            if(usuDAO.EditarChamado(chamado)){
                out.print("Editado com sucesso!");
                response.sendRedirect("../destino.html");
            }else{
               out.print("ERRO ao editar!"); 
            }
        %>
    </body>
</html>
