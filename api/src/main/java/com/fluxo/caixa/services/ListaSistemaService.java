package com.fluxo.caixa.services;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fluxo.caixa.entities.ListaSistemaEntity;
import com.fluxo.caixa.repositories.ListaSistemaRepository;

@Service
public class ListaSistemaService {
	@Autowired
	private ListaSistemaRepository repository;

	public List<ListaSistemaEntity> findByTipo(String tipo) {
        return repository.findByTipo(tipo);
	}

	public List<ListaSistemaEntity> findAll() {
        return repository.findAll();
	}
}
