<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
    </head>
    <body>


        <%
            String cpf = request.getParameter("cpf");
            String nome = request.getParameter("nome");
            String email = request.getParameter("email");
            String fone = request.getParameter("fone");
            String carro = request.getParameter("carro");
            String modelo = request.getParameter("modelo");
            String marca = request.getParameter("marca");
            String ano = request.getParameter("ano");
            String servico = request.getParameter("servico");
            String nomeServico = request.getParameter("nomeServico");
            String preco = request.getParameter("preco");
            String procedimento = request.getParameter("procedimento");
            String tipoProcedimento = request.getParameter("tipoProcedimento");
            String data = request.getParameter("data");

            java.sql.Date dataRevisao = java.sql.Date.valueOf(data);

            if (cpf == null || cpf.isEmpty() || nome == null || nome.isEmpty()
                    || carro == null || carro.isEmpty() || modelo == null || modelo.isEmpty()
                    || marca == null || marca.isEmpty() || ano == null || ano.isEmpty()
                    || servico == null || servico.isEmpty() || nomeServico == null || nomeServico.isEmpty()
                    || preco == null || preco.isEmpty() || procedimento == null || procedimento.isEmpty()
                    || tipoProcedimento == null || tipoProcedimento.isEmpty() || data == null || data.isEmpty()) {

                out.println("Todos os campos são obrigatórios. Por favor, preencha todos os campos.");
            } else {
                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/loja_automotiva", "root", "");

                    // Verificar se o CPF já existe na tabela Cliente
                    stmt = conn.prepareStatement("SELECT * FROM Cliente WHERE CPF_Cliente = ?");
                    stmt.setString(1, cpf);
                    rs = stmt.executeQuery();

                    if (!rs.next()) {
                        stmt = conn.prepareStatement("INSERT INTO Cliente (CPF_Cliente, Nome_Cliente, email, telefone) VALUES (?, ?, ?, ?)");
                        stmt.setString(1, cpf);
                        stmt.setString(2, nome);
                        stmt.setString(3, email);
                        stmt.setString(4, fone);
                        stmt.executeUpdate();
                    }

                    // Inserir o Carro
                    stmt = conn.prepareStatement("INSERT INTO Carro (Cod_Carro, Modelo_Carro, Marca_Carro, Ano_Carro, CPF_ClienteID) VALUES (?, ?, ?, ?, ?)");
                    stmt.setString(1, carro);
                    stmt.setString(2, modelo);
                    stmt.setString(3, marca);
                    stmt.setInt(4, Integer.parseInt(ano));
                    stmt.setString(5, cpf);
                    stmt.executeUpdate();

                    // Inserir o Servico
                    stmt = conn.prepareStatement("INSERT INTO Servico (Cod_Servico, Nome_Servico, Preco_servico, CPF_ClienteID) VALUES (?, ?, ?, ?)", Statement.RETURN_GENERATED_KEYS);
                    stmt.setString(1, servico);
                    stmt.setString(2, nomeServico);
                    stmt.setDouble(3, Double.parseDouble(preco));
                    stmt.setString(4, cpf);
                    stmt.executeUpdate();
                    rs = stmt.getGeneratedKeys();
                    int idServico = 0;
                    if (rs.next()) {
                        idServico = rs.getInt(1);
                    }

                    // Inserir o Procedimento
                    stmt = conn.prepareStatement("INSERT INTO Procedimento (Cod_procedimento, Tipo_procedimento) VALUES (?, ?)", Statement.RETURN_GENERATED_KEYS);
                    stmt.setString(1, procedimento);
                    stmt.setString(2, tipoProcedimento);
                    stmt.executeUpdate();
                    rs = stmt.getGeneratedKeys();
                    int idProc = 0;
                    if (rs.next()) {
                        idProc = rs.getInt(1);
                    }

                    // Inserir o Item do Servico
                    stmt = conn.prepareStatement("INSERT INTO Itens_Servico (Data_Revisao, id_Servico, id_proc) VALUES (?, ?, ?)");
                    stmt.setDate(1, dataRevisao);
                    stmt.setInt(2, idServico);
                    stmt.setInt(3, idProc);
                    stmt.executeUpdate();

                    out.println("<p style='color:white; font-size:20; font-family: arial'>Cliente e serviços cadastrados com sucesso!</p>");

                } catch (Exception e) {
                    out.println("<p style='color:white; font-size:20; font-family: arial'>Erro ao cadastrar os dados: </p>" + e.getMessage());
                } finally {
                    try {
                        if (rs != null) {
                            rs.close();
                        }
                        if (stmt != null) {
                            stmt.close();
                        }
                        if (conn != null) {
                            conn.close();
                        }
                    } catch (SQLException e) {
                        out.println("<p style='color:white; font-size:20; font-family: arial'>Erro ao fechar conexão: </p>" + e.getMessage());
                    }
                }
            }
        %>




    </body>
</html>
