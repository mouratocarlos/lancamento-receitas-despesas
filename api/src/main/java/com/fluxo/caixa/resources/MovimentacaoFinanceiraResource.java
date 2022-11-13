package com.fluxo.caixa.resources;

import java.time.LocalDateTime;
import java.util.List;

import javax.websocket.server.PathParam;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateDeserializer;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fluxo.caixa.dtos.MovimentacaoFinanceiraDto;
import com.fluxo.caixa.dtos.RequisicaoMovimentacaoFinanceiraDto;
import com.fluxo.caixa.entities.MovimentacaoFinanceiraEntity;
import com.fluxo.caixa.services.MovimentacaoFinanceiraService;

@RestController
@RequestMapping(value = "/movimentacao-financeira")
public class MovimentacaoFinanceiraResource {
	@Autowired
	private MovimentacaoFinanceiraService service;
	
	@GetMapping
	public ResponseEntity<List<MovimentacaoFinanceiraDto>> findByData(@RequestParam(name = "data") String data) {
		List<MovimentacaoFinanceiraDto> listMovimentacao;
		
		if (data.isEmpty()) {
			listMovimentacao = service.findByData(LocalDateTime.now());						
		} else {
			LocalDateTime dataLocal = LocalDateTime.parse(data);
			listMovimentacao = service.findByData(dataLocal);			
		}
		
		return ResponseEntity.ok().body(listMovimentacao);
	}
	
	@PostMapping
	public ResponseEntity<MovimentacaoFinanceiraEntity> post(@RequestBody RequisicaoMovimentacaoFinanceiraDto body) {
		MovimentacaoFinanceiraEntity movimentacao = service.post(body);
		return ResponseEntity.ok().body(movimentacao);
	}
	
	@DeleteMapping
	public void delete(@RequestBody RequisicaoMovimentacaoFinanceiraDto body) {
		service.delete(body);
	}
}
