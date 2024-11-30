package model.dao;
import model.Usuario;
import model.Chamados;
import util.Conecta;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.jsp.PageContext;

public class UsuarioDAO {
    public boolean Cadastrar(Usuario usu) throws ClassNotFoundException{
        Connection conexao = null;
        try{
            conexao = Conecta.conectar();
            Statement stmt = conexao.createStatement();
                        //INSERT INTO       
            String sql = "INSERT INTO usuarios(id, nome, email, senha) VALUES ('" + usu.getId()+ "'," +
                                                                                "'" + usu.getNome()+ "'," +
                                                                                "'" + usu.getEmail()+ "'," +
                                                                                "'" + usu.getSenha() + "');";
            stmt.executeUpdate(sql); //GO - Executar - Insert / Delete / Update
            return true;
        }catch(SQLException ex){
            System.out.println("Erro:" + ex);
            return false;
        }
    } 
    
    public boolean Login(Usuario usu) throws ClassNotFoundException{
        Connection conexao = null;
        ResultSet rs = null;
        try{
            conexao = Conecta.conectar();
            Statement stmt = conexao.createStatement();       
            String sql = "SELECT * FROM usuarios WHERE nome = '" + usu.getNome() + "' AND senha = '" + usu.getSenha() + "';";
            rs = stmt.executeQuery(sql); //GO - Executar - SELECT
            
            if(rs.next()){
                return true;
            }else{
                return false;
            }
        }catch(SQLException ex){
            System.out.println("Erro:" + ex);
            return false;
        }
    }
    
    public boolean AbrirChamado(Chamados chamado) throws ClassNotFoundException{
        Connection conexao = null;
        ResultSet rs = null;
        
        try{
            conexao = Conecta.conectar();
            Statement stmt = conexao.createStatement();        
            String id = "SELECT id FROM usuarios WHERE nome = '" + chamado.getNome_responsavel() + "'";
            rs = stmt.executeQuery(id);
            
            int idRes = -1;
            if(rs.next()){
                idRes = rs.getInt("id");
            } else {
                System.out.println("Responsável não encontrado!");
                return false;
            }
            
            String sql = "INSERT INTO chamados(id, titulo, descricao, data_inicio, id_responsavel, nome_responsavel) "
                    + "VALUES ('" + chamado.getId()+ "'," +
                                "'" + chamado.getTitulo()+ "'," +
                                "'" + chamado.getDescricao() + "'," +
                                "'" + chamado.getData_inicio() + "'," +
                                "'" + idRes + "'," +
                                "'" + chamado.getNome_responsavel() + "');";
            stmt.executeUpdate(sql); //GO - Executar - Insert / Delete / Update
            return true;
        }catch(SQLException ex){
            System.out.println("Erro:" + ex);
            return false;
        }
    } 
    
    public List Chamados(String nome, String senha) throws ClassNotFoundException{
        Connection conexao = null;
        
        List lista = new ArrayList();
        
        try{
            conexao = Conecta.conectar();
            Statement stmt = conexao.createStatement(); 
            
            String idQuery = "SELECT id FROM usuarios WHERE nome = '" + nome + "' AND senha = '" + senha + "';";
            PreparedStatement idStmt = conexao.prepareStatement(idQuery);
            ResultSet idResult = idStmt.executeQuery();
            // Verificando se existe usuario
            if (!idResult.next()) {
                return null;
            }
            
            String idResponsavel = idResult.getString("id");
            idResult.close();
            idStmt.close();
            
            String sql = "SELECT * FROM chamados WHERE nome_responsavel = '" + nome + "' AND id_responsavel = '" + Integer.parseInt(idResponsavel) + "';";
            ResultSet rs = stmt.executeQuery(sql);
            
            int n = 0;
            while(rs.next()){
                Chamados chamado = new Chamados();
                chamado.setId(rs.getInt("id"));
                chamado.setTitulo(rs.getString("titulo"));
                chamado.setDescricao(rs.getString("descricao"));
                chamado.setData_inicio(rs.getString("data_inicio"));
                chamado.setData_fim(rs.getString("data_fim"));
                chamado.setNome_responsavel(rs.getString("nome_responsavel"));
                lista.add(chamado);
                n++;
            }
            rs.close();
            conexao.close();
            
            if(n == 0){
                return null;
            }else{
                return lista;
            }
        }catch(SQLException ex){
            System.out.println("Erro:" + ex);
            return null;
        }
    }
    
    public boolean ExcluirChamado(Integer id) throws ClassNotFoundException{
        Connection conexao = null;
        
        try{
            conexao = Conecta.conectar();
            Statement stmt = conexao.createStatement();       
            
            String sql = "DELETE FROM chamados WHERE id ='" + id + ";'";
            stmt.executeUpdate(sql); //GO - Executar - Insert / Delete / Update
            return true;
        }catch(SQLException ex){
            System.out.println("Erro:" + ex);
            return false;
        }
    } 
  
    public Chamados PesquisaChamado(Chamados chamado) throws ClassNotFoundException{
        Connection conexao = null;
        try{
            conexao = Conecta.conectar();
            Statement stmt = conexao.createStatement();
            String sql = "SELECT * FROM chamados WHERE id = " + chamado.getId();
            ResultSet rs = stmt.executeQuery(sql);
                        
            int n_reg = 0;
            while (rs.next()) {                
                chamado.setId(Integer.parseInt(rs.getString("id")));
                chamado.setTitulo(rs.getString("titulo"));
                chamado.setDescricao(rs.getString("descricao"));
                chamado.setData_inicio(rs.getString("data_inicio"));
                chamado.setData_fim(rs.getString("data_fim"));
                n_reg++;
            }
            conexao.close();
            
            if (n_reg==0){
                return null;
            }else{
                return chamado;               
            }
        }catch(SQLException ex){
            System.out.println("Exception: " + ex);
            return null;
        } 
    } 
    
    public List TodosChamados() throws ClassNotFoundException{
        Connection conexao = null;
        List lista = new ArrayList();
        try{
            conexao = Conecta.conectar();
            Statement stmt = conexao.createStatement();
            String sql = "SELECT * FROM chamados WHERE data_fim IS NULL;";
            ResultSet rs = stmt.executeQuery(sql);
            Chamados chamado = new Chamados();
            int n_reg = 0;
            while (rs.next()) {                
                chamado.setId(Integer.parseInt(rs.getString("id")));
                chamado.setTitulo(rs.getString("titulo"));
                chamado.setDescricao(rs.getString("descricao"));
                chamado.setData_inicio(rs.getString("data_inicio"));
                chamado.setData_fim(rs.getString("data_fim"));
                lista.add(chamado);
                n_reg++;
            }
            conexao.close();
            
            if (n_reg==0){
                return null;
            }else{
                return lista;               
            }
        }catch(SQLException ex){
            System.out.println("Exception: " + ex);
            return null;
        } 
    } 
    
    public List PesquisaChamados(String valor, String opcao) throws ClassNotFoundException{
        Connection conexao = null;
        List lista = new ArrayList();
        try{
            conexao = Conecta.conectar();
            Statement stmt = conexao.createStatement();
            String sql = "";
            switch (opcao) {
                case "id" -> sql = "SELECT * FROM chamados WHERE id = '" + valor + "';";
                case "responsavel" -> sql = "SELECT * FROM chamados WHERE nome_responsavel = '" + valor + "';";
                case "titulo" -> sql = "SELECT * FROM chamados WHERE titulo = '" + valor + "';";
                default -> {
                }
            }
            
            ResultSet rs = stmt.executeQuery(sql);
            Chamados chamado = new Chamados();
            int n_reg = 0;
            while (rs.next()) {                
                chamado.setId(Integer.parseInt(rs.getString("id")));
                chamado.setTitulo(rs.getString("titulo"));
                chamado.setDescricao(rs.getString("descricao"));
                chamado.setData_inicio(rs.getString("data_inicio"));
                chamado.setData_fim(rs.getString("data_fim"));
                lista.add(chamado);
                n_reg++;
            }
            conexao.close();
            
            if (n_reg==0){
                return null;
            }else{
                return lista;               
            }
        }catch(SQLException ex){
            System.out.println("Exception: " + ex);
            return null;
        } 
    } 
    
    public boolean EditarChamado(Chamados chamado) throws ClassNotFoundException{
        Connection conexao = null;
        ResultSet rs = null;
        
        try{
            conexao = Conecta.conectar();
            Statement stmt = conexao.createStatement();
            
            String sql = "UPDATE chamados SET titulo = '"+ chamado.getTitulo() +"', descricao = '"+ chamado.getDescricao()+"', data_inicio = '"+ chamado.getData_inicio()+"', data_fim = '"+ chamado.getData_fim()+"' WHERE id = '"+ chamado.getId()+"'";
    
            stmt.executeUpdate(sql); //GO - Executar - Insert / Delete / Update
            return true;
        }catch(SQLException ex){
            System.out.println("Erro:" + ex);
            return false;
        }
    } 
    
    public boolean FecharChamado(Integer id, String data_fim) throws ClassNotFoundException{
        Connection conexao = null;
        
        try{
            conexao = Conecta.conectar();
            Statement stmt = conexao.createStatement();
            
            String sql = "UPDATE chamados SET data_fim = '"+ data_fim +"' WHERE id = '"+ id +"'";
    
            stmt.executeUpdate(sql); //GO - Executar - Insert / Delete / Update
            return true;
        }catch(SQLException ex){
            System.out.println("Erro:" + ex);
            return false;
        }
    } 
}
