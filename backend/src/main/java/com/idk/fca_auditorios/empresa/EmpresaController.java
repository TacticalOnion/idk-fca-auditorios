package com.idk.fca_auditorios.empresa;

import com.idk.fca_auditorios.empresa.dto.EmpresaRequest;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/empresa")
public class EmpresaController {

    private final JdbcTemplate jdbc;

    public EmpresaController(JdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }

    // Obtener todas las empresas (para llenar selects)
    @GetMapping
    public List<Map<String, Object>> list() {
        return jdbc.queryForList("""
            SELECT id_empresa, nombre
            FROM empresa
            ORDER BY nombre
        """);
    }

    // Crear empresa desde modal
    @PostMapping
    @PreAuthorize("hasRole('FUNCIONARIO')")
    public Map<String, Object> create(@RequestBody EmpresaRequest req) {

        Integer id = jdbc.queryForObject("""
            INSERT INTO empresa (nombre, id_pais)
            VALUES (?, ?)
            RETURNING id_empresa
        """, Integer.class, req.nombre, req.idPais);

        return Map.of(
                "idEmpresa", id,
                "message", "Empresa creada correctamente"
        );
    }
}
