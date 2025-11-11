package com.idk.fca_auditorios.calendario;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@RestController
@RequestMapping("/api/calendario")
public class CalendarioController {
  private final CalendarioRepository calRepo;
  private final PeriodoRepository perRepo;

  public CalendarioController(CalendarioRepository calRepo, PeriodoRepository perRepo) {
    this.calRepo = calRepo; this.perRepo = perRepo;
  }

  @GetMapping
  @PreAuthorize("hasRole('superadministrador')")
  public List<Map<String,Object>> list() {
    List<Map<String,Object>> out = new ArrayList<>();
    for (var c : calRepo.findAll()) {
      var m = new LinkedHashMap<String,Object>();
      m.put("id", c.getId());
      m.put("semestre", c.getSemestre());
      m.put("semestreInicio", c.getSemestreInicio());
      m.put("semestreFin", c.getSemestreFin());
      m.put("periodos", perRepo.findByIdCalendarioEscolar(c.getId()));
      out.add(m);
    }
    return out;
  }

  @PostMapping
  @PreAuthorize("hasRole('superadministrador')")
  @Transactional
  public Map<String,Object> crear(@RequestBody Map<String,Object> body) {
    CalendarioEscolar c = new CalendarioEscolar();
    c.setSemestre(String.valueOf(body.get("semestre")));
    c.setSemestreInicio(java.time.LocalDate.parse(String.valueOf(body.get("semestreInicio"))));
    c.setSemestreFin(java.time.LocalDate.parse(String.valueOf(body.get("semestreFin"))));
    c = calRepo.save(c);

    // ✅ Sin unchecked cast
    List<?> periodosRaw = (List<?>) body.getOrDefault("periodos", List.of());
    for (Object obj : periodosRaw) {
      Map<?,?> p = (Map<?,?>) obj;
      Periodo per = new Periodo();
      per.setIdCalendarioEscolar(c.getId());
      per.setIdTipoPeriodo(Long.parseLong(String.valueOf(p.get("idTipoPeriodo"))));
      per.setFechaInicio(java.time.LocalDate.parse(String.valueOf(p.get("fechaInicio"))));
      per.setFechaFin(java.time.LocalDate.parse(String.valueOf(p.get("fechaFin"))));
      perRepo.save(per);
    }
    return Map.of("id", c.getId());
  }
}
