package com.idk.fca_auditorios.calendario;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CalendarioRepository extends JpaRepository<CalendarioEscolar, Long> {}
interface PeriodoRepository extends JpaRepository<Periodo, Long> {
  List<Periodo> findByIdCalendarioEscolar(Long id);
}
