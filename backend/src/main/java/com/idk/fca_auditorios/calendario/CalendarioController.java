package com.idk.fca_auditorios.calendario;

import lombok.Data;
import org.springframework.http.HttpStatus;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/calendario")
public class CalendarioController {
  private final CalendarioRepository calRepo;
  private final PeriodoRepository perRepo;
  private final TipoPeriodoRepository tipoPeriodoRepo;

  public CalendarioController(
      CalendarioRepository calRepo,
      PeriodoRepository perRepo,
      TipoPeriodoRepository tipoPeriodoRepo
  ) {
    this.calRepo = calRepo;
    this.perRepo = perRepo;
    this.tipoPeriodoRepo = tipoPeriodoRepo;
  }

  // ==============================
  // GET: lista de calendarios con sus periodos
  // ==============================
  @GetMapping
  public List<CalendarioDto> list() {
    List<CalendarioEscolar> calendarios = calRepo.findAll();
    if (calendarios.isEmpty()) return List.of();

    List<Long> calIds = calendarios.stream()
        .map(CalendarioEscolar::getId)
        .toList();

    // Periodos por calendario
    List<Periodo> periodos = perRepo.findByIdCalendarioEscolarIn(calIds);
    Map<Long, List<Periodo>> periodosByCal = periodos.stream()
        .collect(Collectors.groupingBy(Periodo::getIdCalendarioEscolar));

    // Nombre del tipo de periodo
    Map<Long, String> tipoNombreById = tipoPeriodoRepo.findAll().stream()
        .collect(Collectors.toMap(TipoPeriodo::getId, TipoPeriodo::getNombre));

    List<CalendarioDto> result = new ArrayList<>();
    for (CalendarioEscolar cal : calendarios) {
      List<Periodo> perList = periodosByCal.getOrDefault(cal.getId(), List.of());
      List<PeriodoDto> perDtos = new ArrayList<>();
      for (Periodo p : perList) {
        String tipoNombre = tipoNombreById.getOrDefault(p.getIdTipoPeriodo(), "");
        PeriodoDto dto = new PeriodoDto();
        dto.setId(p.getId());
        dto.setIdTipoPeriodo(p.getIdTipoPeriodo());
        dto.setTipoPeriodo(tipoNombre);
        dto.setFechaInicio(p.getFechaInicio());
        dto.setFechaFin(p.getFechaFin());
        perDtos.add(dto);
      }

      CalendarioDto dto = new CalendarioDto();
      dto.setId(cal.getId());
      dto.setSemestre(cal.getSemestre());
      dto.setSemestreInicio(cal.getSemestreInicio());
      dto.setSemestreFin(cal.getSemestreFin());
      dto.setPeriodos(perDtos);
      result.add(dto);
    }

    return result;
  }

  // ==============================
  // GET: lista de tipos de periodo (útil si luego usas selects en el frontend)
  // ==============================
  @GetMapping("/tipos-periodo")
  public List<TipoPeriodoDto> listTiposPeriodo() {
    return tipoPeriodoRepo.findAll().stream()
        .map(tp -> {
          TipoPeriodoDto dto = new TipoPeriodoDto();
          dto.setId(tp.getId());
          dto.setNombre(tp.getNombre());
          return dto;
        })
        .toList();
  }

  // ==============================
  // POST: crear calendario + periodos
  // ==============================
  @PostMapping
  @Transactional
  public Map<String, Long> create(@RequestBody CalendarioCreateRequest body) {
    if (body.getSemestre() == null || body.getSemestre().trim().isEmpty()) {
      throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "El semestre es obligatorio.");
    }
    if (body.getSemestreInicio() == null || body.getSemestreFin() == null) {
      throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Las fechas de semestre son obligatorias.");
    }

    LocalDate semInicio = LocalDate.parse(body.getSemestreInicio());
    LocalDate semFin = LocalDate.parse(body.getSemestreFin());
    if (!semInicio.isBefore(semFin)) {
      throw new ResponseStatusException(
          HttpStatus.BAD_REQUEST,
          "La fecha de inicio del semestre debe ser menor a la fecha fin."
      );
    }

    List<PeriodoCreateRequest> periodos = body.getPeriodos() != null ? body.getPeriodos() : List.of();
    if (periodos.isEmpty()) {
      throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Debe capturar al menos un periodo.");
    }

    // Regla: debe haber al menos 1 periodo de cada tipo de periodo existente
    List<Long> tiposExistentes = tipoPeriodoRepo.findAll().stream()
        .map(TipoPeriodo::getId)
        .toList();

    Set<Long> tiposEnRequest = periodos.stream()
        .map(PeriodoCreateRequest::getIdTipoPeriodo)
        .filter(Objects::nonNull)
        .collect(Collectors.toSet());

    if (!tiposEnRequest.containsAll(tiposExistentes)) {
      throw new ResponseStatusException(
          HttpStatus.BAD_REQUEST,
          "Debe capturar al menos un periodo de cada tipo de periodo configurado."
      );
    }

    // Crear calendario
    CalendarioEscolar c = new CalendarioEscolar();
    c.setSemestre(body.getSemestre());
    c.setSemestreInicio(semInicio);
    c.setSemestreFin(semFin);
    calRepo.save(c);

    // Crear periodos
    for (PeriodoCreateRequest pReq : periodos) {
      if (pReq.getIdTipoPeriodo() == null ||
          pReq.getFechaInicio() == null ||
          pReq.getFechaFin() == null) {
        throw new ResponseStatusException(
            HttpStatus.BAD_REQUEST,
            "Todos los periodos deben tener tipo y rango de fechas."
        );
      }
      LocalDate fi = LocalDate.parse(pReq.getFechaInicio());
      LocalDate ff = LocalDate.parse(pReq.getFechaFin());
      if (fi.isAfter(ff)) {
        throw new ResponseStatusException(
            HttpStatus.BAD_REQUEST,
            "La fecha de inicio del periodo no puede ser mayor que la fecha fin."
        );
      }

      Periodo per = new Periodo();
      per.setIdCalendarioEscolar(c.getId());
      per.setIdTipoPeriodo(pReq.getIdTipoPeriodo());
      per.setFechaInicio(fi);
      per.setFechaFin(ff);
      perRepo.save(per);
    }

    return Map.of("id", c.getId());
  }

  // ========= DTOs =========

  @Data
  public static class CalendarioDto {
    private Long id;
    private String semestre;
    private LocalDate semestreInicio;
    private LocalDate semestreFin;
    private List<PeriodoDto> periodos;
  }

  @Data
  public static class PeriodoDto {
    private Long id;
    private Long idTipoPeriodo;
    private String tipoPeriodo;
    private LocalDate fechaInicio;
    private LocalDate fechaFin;
  }

  @Data
  public static class TipoPeriodoDto {
    private Long id;
    private String nombre;
  }

  @Data
  public static class CalendarioCreateRequest {
    private String semestre;
    private String semestreInicio;
    private String semestreFin;
    private List<PeriodoCreateRequest> periodos;
  }

  @Data
  public static class PeriodoCreateRequest {
    private Long idTipoPeriodo;
    private String fechaInicio;
    private String fechaFin;
  }
}
