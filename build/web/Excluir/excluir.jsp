<%-- 
    Document   : excluir
    Created on : 26 de nov. de 2024, 13:40:05
    Author     : danie
--%>

<%@page import="model.dao.UsuarioDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Excluir Chamado</title>
    </head>
    <body>
       <%
       String idParametro = request.getParameter("id");
       UsuarioDAO usuDAO = new UsuarioDAO();
       Integer id = Integer.parseInt(idParametro);
       if(usuDAO.ExcluirChamado(id)){
                %>
                <script> window.alert("Chamado Excluido com sucesso!"); </script>
                <%
            response.sendRedirect("../destino.html");
        }else{
            out.print("Erro ao Excluir Chamado!");
        }
       %>
    </body>
</html>
