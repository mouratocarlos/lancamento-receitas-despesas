package com.fluxo.caixa.services;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.fluxo.caixa.entities.MovimentacaoFinanceiraEntity;
import com.fluxo.caixa.repositories.MovimentacaoFinanceiraRepository;

@Service
public class MovimentacaoFinanceiraService {
	@Autowired
	private MovimentacaoFinanceiraRepository repository;

	public List<MovimentacaoFinanceiraEntity> findAll() {
		return repository.findAll();
	}

	public List<MovimentacaoFinanceiraEntity> findByData(LocalDateTime data) {
		return repository.findByData(data.getYear(), data.getMonthValue(), data.getDayOfMonth());
	}
	
	public MovimentacaoFinanceiraEntity post(MovimentacaoFinanceiraEntity entity) {
		return repository.save(entity);
	}

	public void delete(MovimentacaoFinanceiraEntity entity) {
		repository.delete(entity);
	}
}
