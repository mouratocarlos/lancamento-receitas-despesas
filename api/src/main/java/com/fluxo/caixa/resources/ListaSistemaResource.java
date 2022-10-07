package com.fluxo.caixa.resources;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fluxo.caixa.dtos.RequisicaoListaSistemaDto;
import com.fluxo.caixa.entities.ListaSistemaEntity;
import com.fluxo.caixa.services.ListaSistemaService;

@RestController
@RequestMapping(value = "/lista-sistema")
public class ListaSistemaResource {

	@Autowired
	private ListaSistemaService service;
	
	@GetMapping(value = "/tipo")
	public ResponseEntity<List<ListaSistemaEntity>> findByTipo(@RequestBody RequisicaoListaSistemaDto body) {
		List<ListaSistemaEntity> list = this.service.findByTipo(body.getTipo());
		return ResponseEntity.ok().body(list);
	}
	
	@GetMapping
	public ResponseEntity<List<ListaSistemaEntity>> findAll() {
		List<ListaSistemaEntity> list = this.service.findAll();
		return ResponseEntity.ok().body(list);
	}	
}
