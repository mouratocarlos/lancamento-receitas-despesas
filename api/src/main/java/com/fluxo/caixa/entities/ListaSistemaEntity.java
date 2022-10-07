package com.fluxo.caixa.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "lista_sistema")
public class ListaSistemaEntity {
	@Id
	@Column(name = "id")
	private Long id;

	@Column(name = "tipo")
	private String tipo;

	@Column(name = "codigo")
	private String codigo;
	
	@Column(name = "descricao")
	private String descricao;
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getTipo() {
		return tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

	public String getCodigo() {
		return codigo;
	}

	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public ListaSistemaEntity() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ListaSistemaEntity(Long id, String tipo, String codigo, String descricao) {
		super();
		this.id = id;
		this.tipo = tipo;
		this.codigo = codigo;
		this.descricao = descricao;
	}	

}
