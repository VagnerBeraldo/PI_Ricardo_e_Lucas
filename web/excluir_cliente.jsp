<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
    </head>
    <body>

        <%
            String cpf;
            int status;

            Connection conn;
            PreparedStatement stm;
            /*valor do name no HTML*/
            cpf = request.getParameter("cpf");

            /*CONECTAR COM BANCO DE DADOS*/
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/loja_automotiva", "root", "");
 
            stm = conn.prepareStatement("DELETE FROM cliente WHERE CPF_Cliente = ?");
            stm.setString(1, cpf);

            status = stm.executeUpdate(); //executa o cmd
            if (status == 1) {
                out.print("<p style='color:white; font-size:20; font-family: arial'>Cliente excluído com sucesso!</p>");
            } else {
                out.print("Cliente não encontrado!");
            }
        %>
    </body>
</html>
