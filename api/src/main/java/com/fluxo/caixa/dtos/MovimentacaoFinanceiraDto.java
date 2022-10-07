package com.fluxo.caixa.dtos;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

public class MovimentacaoFinanceiraDto {
	private Long id;
	private LocalDateTime data;
	private BigDecimal valor;
	private Long listaFormaBaixa;
	private Long listaTipoEspecie;
	private String formaBaixa;
	private String tipoEspecie;
	
	public Long getId() {
		return id;
	}
	
	public void setId(Long id) {
		this.id = id;
	}

	public LocalDateTime getData() {
		return data;
	}
	
	public void setData(LocalDateTime data) {
		this.data = data;
	}
	
	public BigDecimal getValor() {
		return valor;
	}
	
	public void setValor(BigDecimal valor) {
		this.valor = valor;
	}
	
	public Long getListaFormaBaixa() {
		return listaFormaBaixa;
	}

	public void setListaFormaBaixa(Long listaFormaBaixa) {
		this.listaFormaBaixa = listaFormaBaixa;
	}

	public Long getListaTipoEspecie() {
		return listaTipoEspecie;
	}

	public void setListaTipoEspecie(Long listaTipoEspecie) {
		this.listaTipoEspecie = listaTipoEspecie;
	}

	public String getFormaBaixa() {
		return formaBaixa;
	}
	
	public void setFormaBaixa(String formaBaixa) {
		this.formaBaixa = formaBaixa;
	}
	
	public String getTipoEspecie() {
		return tipoEspecie;
	}
	
	public void setTipoEspecie(String tipoEspecie) {
		this.tipoEspecie = tipoEspecie;
	}
	
	public MovimentacaoFinanceiraDto(Long id, LocalDateTime data, BigDecimal valor, Long listaFormaBaixa,
			Long listaTipoEspecie, String formaBaixa, String tipoEspecie) {
		super();
		this.id = id;
		this.data = data;
		this.valor = valor;
		this.listaFormaBaixa = listaFormaBaixa;
		this.listaTipoEspecie = listaTipoEspecie;
		this.formaBaixa = formaBaixa;
		this.tipoEspecie = tipoEspecie;
	}

	public MovimentacaoFinanceiraDto() {
		super();
	}

}
