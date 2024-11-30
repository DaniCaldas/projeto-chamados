<%-- 
    Document   : fecharChamado
    Created on : 30 de nov. de 2024, 02:09:29
    Author     : danie
--%>

<%@page import="model.dao.UsuarioDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Fechar Chamado</title>
    </head>
    <body>
       <%
           String idChamado = request.getParameter("id");
           Integer id = Integer.parseInt(idChamado);
           String data_fim = request.getParameter("data_fim");
           UsuarioDAO usuDAO = new UsuarioDAO();
           if(usuDAO.FecharChamado(id, data_fim)){
                %>
                <script> window.alert("Chamado Fechado com sucesso!"); </script>
                <%
                response.sendRedirect("../destino_ti.html");
           }else{
                %>
                <script> window.alert("Erro ao Fechar chamado!"); </script>
                <%
                response.sendRedirect("../destino_ti.html");
           }
       %>
    </body>
</html>
