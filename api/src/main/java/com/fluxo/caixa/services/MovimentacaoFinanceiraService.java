package com.fluxo.caixa.services;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fluxo.caixa.dtos.MovimentacaoFinanceiraDto;
import com.fluxo.caixa.dtos.RequisicaoMovimentacaoFinanceiraDto;
import com.fluxo.caixa.entities.ListaSistemaEntity;
import com.fluxo.caixa.entities.MovimentacaoFinanceiraEntity;
import com.fluxo.caixa.repositories.ListaSistemaRepository;
import com.fluxo.caixa.repositories.MovimentacaoFinanceiraRepository;

@Service
public class MovimentacaoFinanceiraService {
	@Autowired
	private MovimentacaoFinanceiraRepository repository;

	@Autowired
	private ListaSistemaRepository listaSistemaRepository;

	private MovimentacaoFinanceiraEntity setMovimentacaoByRequisicao(RequisicaoMovimentacaoFinanceiraDto dto) {
		MovimentacaoFinanceiraEntity entity = new MovimentacaoFinanceiraEntity();

		entity.setId(dto.getId());
		entity.setData(dto.getData());
		entity.setObservacao(dto.getObservacao());
		entity.setValor(dto.getValor());

		if (dto.getListaFormaBaixa() != null) {
			ListaSistemaEntity formaBaixa = listaSistemaRepository.findById(dto.getListaFormaBaixa()).get();
			entity.setListaFormaBaixa(formaBaixa);			
		}

		if (dto.getListaTipoEspecie() != null) {
			ListaSistemaEntity tipoEspecie = listaSistemaRepository.findById(dto.getListaTipoEspecie()).get();
			entity.setListaTipoEspecie(tipoEspecie);		
		}
				
		return entity;
	}
	
	public List<MovimentacaoFinanceiraEntity> findAll() {
		return repository.findAll();
	}

	public List<MovimentacaoFinanceiraDto> findByData(LocalDateTime data) {
		return repository.findByData(data.getYear(), data.getMonthValue(), data.getDayOfMonth());
	}
	
	public MovimentacaoFinanceiraEntity post(RequisicaoMovimentacaoFinanceiraDto body) {
		return repository.save(setMovimentacaoByRequisicao(body));
	}

	public void delete(RequisicaoMovimentacaoFinanceiraDto body) {
		repository.delete(setMovimentacaoByRequisicao(body));
	}
}
