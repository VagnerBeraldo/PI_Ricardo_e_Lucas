<%@ page import="java.sql.SQLException" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Busca cliente no BD</title>
        <link rel="stylesheet" href="listaClienteTabela.css" type="text/css">

    </head>

    <body>
        <%
            Connection conn = null;  // Inicializa a variável conn como null
            PreparedStatement stm = null;
            ResultSet rs = null;

            try {
                /* CONECTAR COM BANCO DE DADOS */
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/loja_automotiva", "root", "");

                /* Consulta SQL */
                String sqlQuery = "SELECT "
                        + "    Cl.CPF_Cliente, "
                        + "    Cl.Nome_Cliente, "
                        + "    Sv.Nome_Servico, "
                        + "    Ca.Marca_Carro, "
                        + "    Ca.Modelo_Carro, "
                        + "    Pr.Tipo_procedimento, "
                        + "    Sv.Preco_servico "
                        + "FROM "
                        + "    Cliente AS Cl "
                        + "INNER JOIN "
                        + "    Carro AS Ca ON Cl.CPF_Cliente = Ca.CPF_ClienteID "
                        + "INNER JOIN "
                        + "    Servico AS Sv ON Cl.CPF_Cliente = Sv.CPF_ClienteID "
                        + "INNER JOIN "
                        + "    Itens_Servico AS It ON Sv.id_Servico = It.id_Servico "
                        + "INNER JOIN "
                        + "    Procedimento AS Pr ON It.id_proc = Pr.id_proc";

                /* Prepara o statement */
                stm = conn.prepareStatement(sqlQuery);

                /* Executa a consulta */
                rs = stm.executeQuery();

                out.print("<table>");

                out.print("<caption>");
                out.print("Relatório de Clientes");
                out.print("</caption>");

                out.print("<tr><th> CPF Cliente </th><th> Nome </th><th> Serviço </th><th> Marca </th><th> Modelo </th><th> Procedimento </th><th> Preço </th><th> Exclusão</th><th> Alterar</th></tr>");

                /* Processa os resultados da consulta */
                while (rs.next()) {
                    /* nome da coluna no banco de dados */
                    out.print("<tr><td>" + rs.getString("CPF_Cliente")
                            + "</td><td>" + rs.getString("Nome_Cliente")
                            + "</td><td>" + rs.getString("Nome_Servico")
                            + "</td><td>" + rs.getString("Marca_Carro")
                            + "</td><td>" + rs.getString("Modelo_Carro")
                            + "</td><td>" + rs.getString("Tipo_procedimento")
                            + "</td><td>" + rs.getString("Preco_servico")
                            + "</td>");
                    out.print("<td><a href='excluir_cliente.jsp?cpf=" + rs.getString("CPF_Cliente") + "'>Excluir</a></td>");
                    out.print("<td><a href='carregar_cliente.jsp?cpf=" + rs.getString("CPF_Cliente") + "'>Alterar</a></td></tr>");
                }

                out.print("</table>");
            } catch (Exception e) {
                out.print("<p style='color:red; font-size:25px;'>Erro: Entre em contato com o administrador</p>" + e.getMessage());
            } finally {
                try {
                    if (rs != null) {
                        rs.close();
                    }
                    if (stm != null) {
                        stm.close();
                    }
                    if (conn != null) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    out.print("<p style='color:red; font-size:25px;'>Erro ao fechar os recursos: " + e.getMessage() + "</p>");
                }
            }
        %>
    </body>



</html>
