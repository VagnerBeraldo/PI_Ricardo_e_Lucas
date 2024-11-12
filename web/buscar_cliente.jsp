<%@page import="java.sql.ResultSet"%>
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
            Connection conn;
            PreparedStatement stm;
            ResultSet rs;

            // Captura o valor do campo "cpf" enviado pelo formulário
            cpf = request.getParameter("cpf");

            // Conectar com o banco de dados
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/loja_automotiva", "root", "rpmonn");

            // Consulta SQL com filtro pelo CPF do cliente
            stm = conn.prepareStatement(
                    "SELECT c.CPF_Cliente, c.Nome_Cliente, c.Email, c.Telefone, car.Marca_Carro, car.Modelo_Carro, iserv.Data_Revisao "
                    + "FROM Cliente c "
                    + "JOIN Carro car ON c.CPF_Cliente = car.CPF_ClienteID "
                    + "JOIN Servico s ON c.CPF_Cliente = s.CPF_ClienteID "
                    + "JOIN Itens_Servico iserv ON s.id_Servico = iserv.id_Servico "
                    + "WHERE c.CPF_Cliente = ?"
            );

            // Define o valor do parâmetro CPF na consulta
            stm.setString(1, cpf);

            // Executa a consulta
            rs = stm.executeQuery();

            // Verifica se encontrou algum registro
            if (rs.next()) {
                
            out.print("<b style='margin-left: 10px;'>CPF:</b> " + rs.getString("CPF_Cliente") + "<br>");
out.print("<b style='margin-left: 10px;'>Nome:</b> " + rs.getString("Nome_Cliente") + "<br>");
out.print("<b style='margin-left: 10px;'>Email:</b> " + rs.getString("Email") + "<br>");
out.print("<b style='margin-left: 10px;'>Telefone:</b> " + rs.getString("Telefone") + "<br>");
out.print("<b style='margin-left: 10px;'>Marca:</b> " + rs.getString("Marca_Carro") + "<br>");
out.print("<b style='margin-left: 10px;'>Modelo:</b> " + rs.getString("Modelo_Carro") + "<br>");
out.print("<b style='margin-left: 10px;'>Data Revisão:</b> " + rs.getString("Data_Revisao") + "<br>");

                
            } else {
                out.print("<p style='color:white; font-size:20; font-family:arial;'>Cliente não localizado!</p>");
            }

            // Fecha a conexão com o banco de dados
            rs.close();
            stm.close();
            conn.close();
        %>
    </body>

</html>
