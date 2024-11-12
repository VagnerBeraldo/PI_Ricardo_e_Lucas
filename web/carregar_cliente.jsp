<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset="ISO-8859-1">
        <title></title>
        <style>
            .btnSalvar{
                padding: 5px 10px;
            }
        </style>
    </head>
    <body>
        <%
            String cpf;
            Connection conn;
            PreparedStatement stm;
            ResultSet rs;

            // Captura o CPF enviado pelo formulário
            cpf = request.getParameter("cpf");

            /* Conectar com o banco de dados */
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/loja_automotiva", "root", "");

            /* Busca os dados do cliente e associações com carro, serviço e procedimento pelo CPF */
            String sql = "SELECT cli.CPF_Cliente, cli.Nome_Cliente, cli.email, cli.telefone, car.Cod_Carro, car.Marca_Carro, car.Modelo_Carro, car.Ano_Carro, "
                    + "ser.Cod_Servico, ser.Nome_Servico, ser.Preco_servico, proc.Cod_procedimento, proc.Tipo_procedimento, it.Data_Revisao, "
                    + "ser.id_Servico, it.id_proc, car.id_Carro "
                    + // Adicionando a coluna 'id_Carro' para ser recuperada
                    "FROM Cliente AS cli "
                    + "JOIN Carro AS car ON cli.CPF_Cliente = car.CPF_ClienteID "
                    + "JOIN Servico AS ser ON cli.CPF_Cliente = ser.CPF_ClienteID "
                    + "JOIN Itens_Servico AS it ON ser.id_Servico = it.id_Servico "
                    + "JOIN Procedimento AS proc ON it.id_proc = proc.id_proc "
                    + "WHERE cli.CPF_Cliente = ?";

            stm = conn.prepareStatement(sql);
            stm.setString(1, cpf);

            rs = stm.executeQuery();
            if (rs.next()) {
        %>    

        <form method="post" action="alterar_cliente.jsp">

            <p>
                <label for="idcpf">CPF</label>
                <input id="idcpf" type="text" name="cpf" maxlength="20" value="<%=rs.getString("CPF_Cliente")%>" readonly size="20">
            </p>

            <p>
                <label for="idNome">Nome</label>
                <input id="idNome" type="text" name="nome" maxlength="50" value="<%=rs.getString("Nome_Cliente")%>" size="20">
            </p>

            <p>
                <label for="idEmail">Email</label>
                <input id="idEmail" type="email" name="email" maxlength="50" value="<%=rs.getString("email")%>" size="20">
            </p>

            <p>
                <label for="idFone">Telefone</label>
                <input id="idFone" type="fone" name="fone" maxlength="50" value="<%=rs.getString("telefone")%>" size="20">
            </p>

            <p>
                <label for="idCarro">ID Carro</label>
                <input id="idCarro" type="text" name="carroID" value="<%=rs.getInt("id_Carro")%>" readonly maxlength="20" size="20">
            </p>
            <p>
                <label for="codCarro">Código Carro</label>
                <input id="codCarro" type="text" name="carro" value="<%=rs.getString("Cod_Carro")%>" maxlength="20" size="20">
            </p>

            <p>
                <label for="idMarca">Marca</label>
                <input id="idMarca" type="text" name="marca" value="<%=rs.getString("Marca_Carro")%>" maxlength="20" size="20">
            </p>

            <p>
                <label for="idModelo">Modelo</label>
                <input id="idModelo" type="text" name="modelo" value="<%=rs.getString("Modelo_Carro")%>" maxlength="20" size="20">
            </p>

            <p>
                <label for="idAno">Ano</label>
                <input id="idAno" type="text" name="ano" value="<%=rs.getString("Ano_Carro")%>" maxlength="70" size="70">
            </p>
            <p>
                <label for="idServ">ID Serviço</label>
                <input id="idServ" type="text" name="servicoID" value="<%=rs.getInt("id_Servico")%>" readonly maxlength="20" size="20">
            </p>


            <p>
                <label for="idServico">Cód Serviço</label>
                <input id="idServico" type="text" name="servico" value="<%=rs.getString("Cod_Servico")%>" maxlength="70" size="70">
            </p>

            <p>
                <label for="idNomeServico">Nome do Serviço</label>
                <input id="idNomeServico" type="text" name="nomeServico" value="<%=rs.getString("Nome_Servico")%>" maxlength="70" size="70">
            </p>

            <p>
                <label for="idPreco">Preco</label>
                <input id="idPreco" type="text" name="preco" value="<%=rs.getString("Preco_servico")%>" maxlength="30" size="30">
            </p>

            <p>
                <label for="idProc">ID Procedimento</label>
                <input id="idProc" type="text" name="procID" value="<%=rs.getInt("id_proc")%>" readonly maxlength="20" size="20">
            </p>
            <p>
                <label for="idProcedimento">Código Procedimento</label>
                <input id="idProcedimento" type="text" name="procedimento" value="<%=rs.getString("Cod_procedimento")%>" maxlength="70" size="70">
            </p>

            <p>
                <label for="tipoProcedimento">Tipo de Procedimento</label>
                <input id="tipoProcedimento" type="text" name="tipoProcedimento" value="<%=rs.getString("Tipo_procedimento")%>" maxlength="70" size="70">
            </p>




            <p>  
                <input  class="btnSalvar" type="submit" value="Salvar Alteração">
            </p>
        </form>

        <%
            } else {
                out.print("<p style='color:white; font-size:20; font-family: arial'>Cliente não localizado!</p>");
            }
            // Fecha a conexão com o banco de dados
            rs.close();
            stm.close();
            conn.close();
        %>
    </body>



</html>
