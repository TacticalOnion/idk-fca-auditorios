package com.idk.fca_auditorios.ponente;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PonenteRepository extends JpaRepository<Ponente, Long> {
  List<Ponente> findByNombreContainingIgnoreCaseOrApellidoPaternoContainingIgnoreCase(String n, String ap);
}
