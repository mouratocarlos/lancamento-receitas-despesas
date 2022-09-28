package com.fluxo.caixa.repositories;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import com.fluxo.caixa.entities.MovimentacaoFinanceiraEntity;

public interface MovimentacaoFinanceiraRepository extends JpaRepository<MovimentacaoFinanceiraEntity, Long> {
	
	@Query("select "
			+ "   MOF "
			+ "  from MovimentacaoFinanceiraEntity MOF "
			+ " where extract(year from MOF.data) = :year "
			+ "   and extract(month from MOF.data) = :month "
			+ "   and extract(day from MOF.data) = :day "
			+ " order by MOF.data ")
	public List<MovimentacaoFinanceiraEntity> findByData(@Param("year") int year,
			@Param("month") int month,
			@Param("day") int day);
}
