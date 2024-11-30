package model;

import java.util.Date;


public class Chamados {
    private Integer Id;
    private String titulo;
    private String descricao;
    private String data_inicio;
    private String data_fim;
    private Integer id_responsavel;
    private String nome_responsavel;

    public Integer getId() {
        return Id;
    }

    public void setId(Integer Id) {
        this.Id = Id;
    }
    
    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public String getData_inicio() {
        return data_inicio;
    }

    public void setData_inicio(String data_inicio) {
        this.data_inicio = data_inicio;
    }

    public String getData_fim() {
        return data_fim;
    }

    public void setData_fim(String data_fim) {
        this.data_fim = data_fim;
    }

    public Integer getId_responsavel() {
        return id_responsavel;
    }

    public void setId_responsavel(Integer id_responsavel) {
        this.id_responsavel = id_responsavel;
    }

    public String getNome_responsavel() {
        return nome_responsavel;
    }

    public void setNome_responsavel(String nome_responsavel) {
        this.nome_responsavel = nome_responsavel;
    }
    
    
}
