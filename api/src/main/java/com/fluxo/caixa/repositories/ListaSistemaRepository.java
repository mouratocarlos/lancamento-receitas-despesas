package com.fluxo.caixa.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.fluxo.caixa.entities.ListaSistemaEntity;

@Repository
public interface ListaSistemaRepository extends JpaRepository<ListaSistemaEntity, Long> {

	@Query("select "
			+ "   LTS "
			+ "  from ListaSistemaEntity LTS "
			+ " where LTS.tipo = :tipo "
			+ " order by LTS.descricao ")
	public List<ListaSistemaEntity> findByTipo(@Param("tipo") String tipo);	
}
