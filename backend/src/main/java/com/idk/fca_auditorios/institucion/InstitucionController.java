package com.idk.fca_auditorios.institucion;

import com.idk.fca_auditorios.institucion.dto.InstitucionRequest;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/institucion")
public class InstitucionController {

    private final JdbcTemplate jdbc;

    public InstitucionController(JdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }

    @GetMapping
    public List<Map<String, Object>> list() {
        return jdbc.queryForList("""
            SELECT id_institucion, nombre, siglas
            FROM institucion
            ORDER BY nombre
        """);
    }

    @PostMapping
    @PreAuthorize("hasRole('FUNCIONARIO')")
    public Map<String, Object> create(@RequestBody InstitucionRequest req) {

        Integer id = jdbc.queryForObject("""
            INSERT INTO institucion (nombre, siglas)
            VALUES (?, ?)
            RETURNING id_institucion
        """, Integer.class, req.nombre, req.siglas);

        return Map.of(
                "idInstitucion", id,
                "message", "Institución creada correctamente"
        );
    }
}
