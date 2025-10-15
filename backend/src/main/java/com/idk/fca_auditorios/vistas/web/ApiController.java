package com.idk.fca_auditorios.vistas.web;

import com.idk.fca_auditorios.vistas.dto.*;
import com.idk.fca_auditorios.vistas.service.ExportService;
import com.idk.fca_auditorios.vistas.repo.*;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api")
@RequiredArgsConstructor
public class ApiController {

  private final ExportService exportService;

  // Repos para endpoints por tabla (opcionales pero útiles)
  private final RolXPermisoViewRepo rolxpermisoRepo;
  private final UsuarioViewRepo usuarioRepo;
  private final PuestoViewRepo puestoRepo;
  private final EventoOrganizadorViewRepo eventoOrgRepo;
  private final EventoViewRepo eventoRepo;
  private final ParticipacionViewRepo participacionRepo;
  private final IntegranteXGradoViewRepo integrantexgradoRepo;
  private final GradoViewRepo gradoRepo;
  private final ReservacionViewRepo reservacionRepo;
  private final ReservacionXEquipamientoViewRepo rxeRepo;
  private final EquipamientoViewRepo equipamientoRepo;
  private final AreaInventarioViewRepo areaInvRepo;
  private final RecintoViewRepo recintoRepo;
  private final RecintoInventarioViewRepo recintoInvRepo;
  private final FotografiaViewRepo fotografiaRepo;
  private final IntegranteViewRepo integranteRepo;
  private final AuditoriaViewRepo auditoriaRepo;

  /** Devuelve el mega JSON con todas las tablas en el shape de tus proyecciones */
  @GetMapping(value = "/export", produces = MediaType.APPLICATION_JSON_VALUE)
  public Map<String, Object> exportAll() {
    return exportService.buildDataset();
  }

  // --- Endpoints por tabla (GET solo-lectura). Duplica el patrón si necesitas filtros/paginación ---

  @GetMapping("/rolxpermiso") public List<RolXPermisoView> rolxpermiso() { return rolxpermisoRepo.findAllView(); }

  @GetMapping("/usuario") public List<UsuarioView> usuarios() { return usuarioRepo.findAllView(); }

  @GetMapping("/puesto") public List<PuestoView> puestos() { return puestoRepo.findAllView(); }

  @GetMapping("/evento_organizador") public List<EventoOrganizadorView> eventoOrganizador() { return eventoOrgRepo.findAllView(); }

  @GetMapping("/evento") public List<EventoView> eventos() { return eventoRepo.findAllView(); }

  @GetMapping("/participacion") public List<ParticipacionView> participaciones() { return participacionRepo.findAllView(); }

  @GetMapping("/integrantexgrado") public List<IntegranteXGradoView> integrantexgrado() { return integrantexgradoRepo.findAllView(); }

  @GetMapping("/grado") public List<GradoView> grados() { return gradoRepo.findAllView(); }

  @GetMapping("/reservacion") public List<ReservacionView> reservaciones() { return reservacionRepo.findAllView(); }

  @GetMapping("/reservacionxequipamiento") public List<ReservacionXEquipamientoView> reservacionxequipamiento() { return rxeRepo.findAllView(); }

  @GetMapping("/equipamiento") public List<EquipamientoView> equipamiento() { return equipamientoRepo.findAllView(); }

  @GetMapping("/area_inventario") public List<AreaInventarioView> areaInventario() { return areaInvRepo.findAllView(); }

  @GetMapping("/recinto") public List<RecintoView> recintos() { return recintoRepo.findAllView(); }

  @GetMapping("/recinto_inventario") public List<RecintoInventarioView> recintoInventario() { return recintoInvRepo.findAllView(); }

  @GetMapping("/fotografia") public List<FotografiaView> fotografias() { return fotografiaRepo.findAllView(); }

  @GetMapping("/integrante") public List<IntegranteView> integrantes() { return integranteRepo.findAllView(); }

  @GetMapping("/auditoria") public List<AuditoriaView> auditorias() { return auditoriaRepo.findAllView(); }
}
