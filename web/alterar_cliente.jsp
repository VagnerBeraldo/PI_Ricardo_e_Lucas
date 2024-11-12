<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.SQLException"%>

<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset="ISO-8859-1">
        <title></title>
    </head>
    <body>
        <%
            String nome, email, fone, codCarro, marca, modelo, ano, codServ, nomeServ, preco, codProc, tipoProc;
            int idCarro, idServ, idProc; // Variáveis para os IDs das tabelas Carro, Servico e Procedimento
            Connection conn = null;
            PreparedStatement stm = null;

            try {
                // Captura os valores enviados pelo formulário
                nome = request.getParameter("nome");
                email = request.getParameter("email");
                fone = request.getParameter("fone");
                codCarro = request.getParameter("carro");
                marca = request.getParameter("marca");
                modelo = request.getParameter("modelo");
                ano = request.getParameter("ano");
                codServ = request.getParameter("servico");
                nomeServ = request.getParameter("nomeServico");
                preco = request.getParameter("preco");
                codProc = request.getParameter("procedimento");
                tipoProc = request.getParameter("tipoProcedimento");

                // Captura os IDs das tabelas
                idCarro = Integer.parseInt(request.getParameter("carroID"));
                idServ = Integer.parseInt(request.getParameter("servicoID"));
                idProc = Integer.parseInt(request.getParameter("procID"));

                // Captura o CPF do cliente (garante que o CPF é passado no formulário)
                String cpfCliente = request.getParameter("cpf");

                // Conecta com o banco de dados
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/loja_automotiva", "root", "");

                // Atualizar tabela Cliente
                String sqlCliente = "UPDATE Cliente SET Nome_Cliente = ?, email = ?, telefone = ? WHERE CPF_Cliente = ?";
                stm = conn.prepareStatement(sqlCliente);
                stm.setString(1, nome);
                stm.setString(2, email);
                stm.setString(3, fone);
                stm.setString(4, cpfCliente); // Usando o CPF recebido para atualizar o cliente
                stm.executeUpdate();
                stm.close();

                // Atualizar tabela Carro usando id_Carro
                String sqlCarro = "UPDATE Carro SET Cod_Carro = ?, Marca_Carro = ?, Modelo_Carro = ?, Ano_Carro = ? WHERE id_Carro = ?";
                stm = conn.prepareStatement(sqlCarro);
                stm.setString(1, codCarro);
                stm.setString(2, marca);
                stm.setString(3, modelo);
                stm.setString(4, ano);
                stm.setInt(5, idCarro);
                stm.executeUpdate();
                stm.close();

                // Atualizar tabela Servico usando id_Servico
                String sqlServico = "UPDATE Servico SET Cod_Servico = ?, Nome_Servico = ?, Preco_servico = ? WHERE id_Servico = ?";
                stm = conn.prepareStatement(sqlServico);
                stm.setString(1, codServ);
                stm.setString(2, nomeServ);
                stm.setString(3, preco);
                stm.setInt(4, idServ);
                stm.executeUpdate();
                stm.close();

                // Atualizar tabela Procedimento usando id_proc
                String sqlProcedimento = "UPDATE Procedimento SET Cod_procedimento = ?, Tipo_procedimento = ? WHERE id_proc = ?";
                stm = conn.prepareStatement(sqlProcedimento);
                stm.setString(1, codProc);
                stm.setString(2, tipoProc);
                stm.setInt(3, idProc);
                stm.executeUpdate();
                stm.close();

                out.print("<p style='color:white; font-size:20px; font-family: arial'>Dados do cliente atualizados com sucesso!</p>");

            } catch (SQLException erro) {
                out.print("<p style='color:red; font-size:25px;'>Erro: Entre em contato com o administrador</p>" + erro.getMessage());
            } catch (NumberFormatException erro) {
                out.print("<p style='color:red;'>O valor fornecido está incorreto! - " + erro.getMessage() + "</p>");
            } finally {
                // Fecha os recursos no bloco finally
                if (stm != null) {
                    try {
                        stm.close();
                    } catch (SQLException e) {
                        /* Log do erro, se necessário */ }
                }
                if (conn != null) {
                    try {
                        conn.close();
                    } catch (SQLException e) {
                        /* Log do erro, se necessário */ }
                }
            }
        %>
    </body>



</html>
