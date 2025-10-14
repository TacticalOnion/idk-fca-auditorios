package com.idk.fca_auditorios.vistas.web;

import com.idk.fca_auditorios.vistas.repo.*;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class VistasController {

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
    
    public VistasController(
            RolXPermisoViewRepo rolxpermisoRepo,
            UsuarioViewRepo usuarioRepo,
            PuestoViewRepo puestoRepo,
            EventoOrganizadorViewRepo eventoOrgRepo,
            EventoViewRepo eventoRepo,
            ParticipacionViewRepo participacionRepo,
            IntegranteXGradoViewRepo integrantexgradoRepo,
            GradoViewRepo gradoRepo,
            ReservacionViewRepo reservacionRepo,
            ReservacionXEquipamientoViewRepo rxeRepo,
            EquipamientoViewRepo equipamientoRepo,
            AreaInventarioViewRepo areaInvRepo,
            RecintoViewRepo recintoRepo,
            RecintoInventarioViewRepo recintoInvRepo,
            FotografiaViewRepo fotografiaRepo,
            IntegranteViewRepo integranteRepo,
            AuditoriaViewRepo auditoriaRepo
    ) {
        this.rolxpermisoRepo = rolxpermisoRepo;
        this.usuarioRepo = usuarioRepo;
        this.puestoRepo = puestoRepo;
        this.eventoOrgRepo = eventoOrgRepo;
        this.eventoRepo = eventoRepo;
        this.participacionRepo = participacionRepo;
        this.integrantexgradoRepo = integrantexgradoRepo;
        this.gradoRepo = gradoRepo;
        this.reservacionRepo = reservacionRepo;
        this.rxeRepo = rxeRepo;
        this.equipamientoRepo = equipamientoRepo;
        this.areaInvRepo = areaInvRepo;
        this.recintoRepo = recintoRepo;
        this.recintoInvRepo = recintoInvRepo;
        this.fotografiaRepo = fotografiaRepo;
        this.integranteRepo = integranteRepo;
        this.auditoriaRepo = auditoriaRepo;
    }

    @GetMapping("/vista/rolxpermiso")
    public String rolxpermiso(Model model) {
        model.addAttribute("items", rolxpermisoRepo.findAllView());
        return "rolxpermiso";
    }

    @GetMapping("/vista/usuario")
    public String usuario(Model model) {
        model.addAttribute("items", usuarioRepo.findAllView());
        return "usuario";
    }

    @GetMapping("/vista/puesto")
    public String puesto(Model model) {
        model.addAttribute("items", puestoRepo.findAllView());
        return "puesto";
    }

    @GetMapping("/vista/evento_organizador")
    public String eventoOrganizador(Model model) {
        model.addAttribute("items", eventoOrgRepo.findAllView());
        return "evento_organizador";
    }

    @GetMapping("/vista/evento")
    public String evento(Model model) {
        model.addAttribute("items", eventoRepo.findAllView());
        return "evento";
    }

    @GetMapping("/vista/participacion")
    public String participacion(Model model) {
        model.addAttribute("items", participacionRepo.findAllView());
        return "participacion";
    }

    @GetMapping("/vista/integrantexgrado")
    public String integrantexgrado(Model model) {
        model.addAttribute("items", integrantexgradoRepo.findAllView());
        return "integrantexgrado";
    }

    @GetMapping("/vista/grado")
    public String grado(Model model) {
        model.addAttribute("items", gradoRepo.findAllView());
        return "grado";
    }

    @GetMapping("/vista/reservacion")
    public String reservacion(Model model) {
        model.addAttribute("items", reservacionRepo.findAllView());
        return "reservacion";
    }

    @GetMapping("/vista/reservacionxequipamiento")
    public String reservacionxequipamiento(Model model) {
        model.addAttribute("items", rxeRepo.findAllView());
        return "reservacionxequipamiento";
    }

    @GetMapping("/vista/equipamiento")
    public String equipamiento(Model model) {
        model.addAttribute("items", equipamientoRepo.findAllView());
        return "equipamiento";
    }

    @GetMapping("/vista/area_inventario")
    public String areaInventario(Model model) {
        model.addAttribute("items", areaInvRepo.findAllView());
        return "area_inventario";
    }

    @GetMapping("/vista/recinto")
    public String recinto(Model model) {
        model.addAttribute("items", recintoRepo.findAllView());
        return "recinto";
    }

    @GetMapping("/vista/recinto_inventario")
    public String recintoInventario(Model model) {
        model.addAttribute("items", recintoInvRepo.findAllView());
        return "recinto_inventario";
    }

    @GetMapping("/vista/fotografia")
    public String fotografia(Model model) {
        model.addAttribute("items", fotografiaRepo.findAllView());
        return "fotografia";
    }

     @GetMapping("/vista/integrante")
    public String integrante(Model model) {
        model.addAttribute("items", integranteRepo.findAllView());
        return "integrante";
    }

    @GetMapping("/vista/auditoria")
    public String auditoria(Model model) {
        model.addAttribute("items", auditoriaRepo.findAllView());
        return "auditoria";
    }
}
