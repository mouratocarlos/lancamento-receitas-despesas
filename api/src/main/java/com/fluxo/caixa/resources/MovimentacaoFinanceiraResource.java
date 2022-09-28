package com.fluxo.caixa.resources;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.fluxo.caixa.dtos.MovimentacaoFinanceiraDto;
import com.fluxo.caixa.entities.MovimentacaoFinanceiraEntity;
import com.fluxo.caixa.services.MovimentacaoFinanceiraService;

@RestController
@RequestMapping(value = "/movimentacao-financeira")
public class MovimentacaoFinanceiraResource {
	@Autowired
	private MovimentacaoFinanceiraService service;
	
	@GetMapping(value = "/data")
	public ResponseEntity<List<MovimentacaoFinanceiraEntity>> findByData(@RequestBody MovimentacaoFinanceiraDto dto) {
		List<MovimentacaoFinanceiraEntity> list = service.findByData(dto.getData());
		return ResponseEntity.ok().body(list);
	}

	@GetMapping
	public ResponseEntity<List<MovimentacaoFinanceiraEntity>> findAll() {
		List<MovimentacaoFinanceiraEntity> list = service.findAll();
		return ResponseEntity.ok().body(list);
	}
	
	@PostMapping
	public ResponseEntity<MovimentacaoFinanceiraEntity> post(@RequestBody MovimentacaoFinanceiraEntity body) {
		MovimentacaoFinanceiraEntity entity = service.post(body);
		return ResponseEntity.ok().body(entity);
	}
	
	@DeleteMapping
	public void delete(@RequestBody MovimentacaoFinanceiraEntity body) {
		service.delete(body);
	}
}
