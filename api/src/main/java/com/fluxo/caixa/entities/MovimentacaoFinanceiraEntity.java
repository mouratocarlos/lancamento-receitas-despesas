package com.fluxo.caixa.entities;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "movimentacao_financeira")
public class MovimentacaoFinanceiraEntity {
	@Id
	@Column(name = "id", nullable = false)
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;

	@Column(name = "data", nullable = false)
	@JsonDeserialize(using = LocalDateTimeDeserializer.class)
	@JsonSerialize(using = LocalDateTimeSerializer.class)
	private LocalDateTime data;

	@Column(name = "valor", nullable = false)
	private BigDecimal valor;
	
    @ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "lista_forma_baixa")
	private ListaSistemaEntity listaFormaBaixa;

    @ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "lista_tipo_especie")
	private ListaSistemaEntity listaTipoEspecie;
	
	@Column(name = "observacao", length = 200)
	private String observacao;
	
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

	public ListaSistemaEntity getListaFormaBaixa() {
		return listaFormaBaixa;
	}

	public void setListaFormaBaixa(ListaSistemaEntity listaFormaBaixa) {
		this.listaFormaBaixa = listaFormaBaixa;
	}

	public ListaSistemaEntity getListaTipoEspecie() {
		return listaTipoEspecie;
	}

	public void setListaTipoEspecie(ListaSistemaEntity listaTipoEspecie) {
		this.listaTipoEspecie = listaTipoEspecie;
	}

	public String getObservacao() {
		return observacao;
	}

	public void setObservacao(String observacao) {
		this.observacao = observacao;
	}	
}
