package com.fluxo.caixa.resources;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fluxo.caixa.dtos.RequisicaoListaSistemaDto;
import com.fluxo.caixa.entities.ListaSistemaEntity;
import com.fluxo.caixa.services.ListaSistemaService;

@RestController
@RequestMapping(value = "/lista-sistema")
public class ListaSistemaResource {

	@Autowired
	private ListaSistemaService service;
	
	@GetMapping
	public ResponseEntity<List<ListaSistemaEntity>> findByTipo(@RequestParam(name = "tipo") String tipo) {
		List<ListaSistemaEntity> list;

		if (tipo.isEmpty()) {
			list = this.service.findAll();			
		} else {
			list = this.service.findByTipo(tipo);			
		}

		return ResponseEntity.ok().body(list);
	}	
}
