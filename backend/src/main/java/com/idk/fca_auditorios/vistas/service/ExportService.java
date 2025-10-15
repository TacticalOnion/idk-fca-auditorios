package com.idk.fca_auditorios.vistas.service;

import com.idk.fca_auditorios.vistas.repo.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Arma el dataset completo para /api/export
 * Mantiene el orden de las claves con LinkedHashMap (útil para debugging/consistencia).
 */
@Service
@RequiredArgsConstructor
public class ExportService {

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

  public Map<String, Object> buildDataset() {
    Map<String, Object> out = new LinkedHashMap<>();

    // El orden es opcional; aquí agrupado de forma lógica.
    out.put("usuario", usuarioRepo.findAllView());
    out.put("puesto", puestoRepo.findAllView());
    out.put("rolxpermiso", rolxpermisoRepo.findAllView());

    out.put("integrante", integranteRepo.findAllView());
    out.put("grado", gradoRepo.findAllView());
    out.put("integrantexgrado", integrantexgradoRepo.findAllView());

    out.put("evento", eventoRepo.findAllView());
    out.put("evento_organizador", eventoOrgRepo.findAllView());
    out.put("participacion", participacionRepo.findAllView());

    out.put("recinto", recintoRepo.findAllView());
    out.put("recinto_inventario", recintoInvRepo.findAllView());
    out.put("equipamiento", equipamientoRepo.findAllView());
    out.put("area_inventario", areaInvRepo.findAllView());
    out.put("fotografia", fotografiaRepo.findAllView());

    out.put("reservacion", reservacionRepo.findAllView());
    out.put("reservacionxequipamiento", rxeRepo.findAllView());

    out.put("auditoria", auditoriaRepo.findAllView());

    return out;
    }
}

