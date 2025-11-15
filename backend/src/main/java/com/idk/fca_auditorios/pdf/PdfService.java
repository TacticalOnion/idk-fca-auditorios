package com.idk.fca_auditorios.pdf;

import com.lowagie.text.Document;
import com.lowagie.text.Paragraph;
import com.lowagie.text.FontFactory;
import com.lowagie.text.pdf.PdfWriter;

import com.idk.fca_auditorios.storage.LocalStorageService;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.io.FileOutputStream;
import java.nio.file.Path;
import java.util.List;
import java.util.Map;

/**
 * Genera:
 *  - Semblanza del ponente (encabezados Nombre / Reconocimiento / Experiencia / Grado) :contentReference[oaicite:11]{index=11}
 *  - Reconocimiento por participación en evento :contentReference[oaicite:12]{index=12}
 */
@Service
public class PdfService {
  private final JdbcTemplate jdbc;
  private final LocalStorageService storage;

  public PdfService(JdbcTemplate jdbc, LocalStorageService storage) {
    this.jdbc = jdbc; this.storage = storage;
    storage.ensureDirs();
  }

  public Path generarSemblanza(Long idPonente, String fileName) throws Exception {
    String nombre = jdbc.queryForObject("""
      SELECT concat_ws(' ', nombre, apellido_paterno, apellido_materno)
      FROM ponente WHERE id_ponente=?
      """, String.class, idPonente);

    List<Map<String,Object>> reconocimientos = jdbc.queryForList("""
      SELECT r.titulo, r.organizacion, r.anio, r.descripcion
      FROM reconocimiento r
      JOIN semblanzaxreconocimiento sxr ON sxr.id_reconocimiento = r.id_reconocimiento
      JOIN semblanza s ON s.id_semblanza = sxr.id_semblanza
      WHERE s.id_ponente = ?
      """, idPonente);

    List<Map<String,Object>> experiencias = jdbc.queryForList("""
      SELECT e.puesto, e.fecha_inicio, e.fecha_fin, emp.nombre as empresa, p.nombre as pais
      FROM experiencia e
      JOIN empresa emp ON emp.id_empresa = e.id_empresa
      JOIN pais p ON p.id_pais = emp.id_pais
      JOIN semblanzaxexperiencia sxe ON sxe.id_experiencia = e.id_experiencia
      JOIN semblanza s ON s.id_semblanza = sxe.id_semblanza
      WHERE s.id_ponente = ?
      """, idPonente);

    List<Map<String,Object>> grados = jdbc.queryForList("""
      SELECT g.titulo, g.anio, n.nombre as nivel, i.nombre as institucion, p.nombre as pais
      FROM grado g
      JOIN nivel n ON n.id_nivel = g.id_nivel
      JOIN institucion i ON i.id_institucion = g.id_institucion
      JOIN pais p ON p.id_pais = g.id_pais
      JOIN semblanzaxgrado sxg ON sxg.id_grado = g.id_grado
      JOIN semblanza s ON s.id_semblanza = sxg.id_semblanza
      WHERE s.id_ponente = ?
      """, idPonente);

    Path out = storage.resolveSemblanza(fileName);
    try (FileOutputStream fos = new FileOutputStream(out.toFile())) {
      Document doc = new Document();
      PdfWriter.getInstance(doc, fos);
      doc.open();
      doc.add(new Paragraph("# " + nombre, FontFactory.getFont(FontFactory.HELVETICA_BOLD, 16)));
      doc.add(new Paragraph(" "));

      doc.add(new Paragraph("## Reconocimiento", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 14)));
      for (var r : reconocimientos) {
        doc.add(new Paragraph(String.format("- %s, %s, %s. %s",
            r.get("titulo"), r.get("organizacion"), r.get("anio"), r.getOrDefault("descripcion",""))));
      }
      doc.add(new Paragraph(" "));

      doc.add(new Paragraph("## Experiencia", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 14)));
      for (var e : experiencias) {
        doc.add(new Paragraph(String.format("- %s (%s a %s) - %s, %s",
            e.get("puesto"), e.get("fecha_inicio"), e.get("fecha_fin"), e.get("empresa"), e.get("pais"))));
      }
      doc.add(new Paragraph(" "));

      doc.add(new Paragraph("## Grado", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 14)));
      for (var g : grados) {
        doc.add(new Paragraph(String.format("- %s, %s - %s, %s (%s)",
            g.get("titulo"), g.get("anio"), g.get("nivel"), g.get("institucion"), g.get("pais"))));
      }
      doc.close();
    }
    return out;
  }

  public Path generarReconocimiento(Long idPonente, Long idEvento, String fileName) throws Exception {
    String nombre = jdbc.queryForObject("""
      SELECT concat_ws(' ', nombre, apellido_paterno, apellido_materno)
      FROM ponente WHERE id_ponente=?
      """, String.class, idPonente);
    String evento = jdbc.queryForObject("SELECT nombre FROM evento WHERE id_evento=?", String.class, idEvento);

    Path out = storage.resolveReconocimiento(fileName);
    try (FileOutputStream fos = new FileOutputStream(out.toFile())) {
      Document doc = new Document();
      PdfWriter.getInstance(doc, fos);
      doc.open();
      doc.add(new Paragraph("Reconocimiento", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18)));
      doc.add(new Paragraph(" "));
      doc.add(new Paragraph("Se reconoce que " + nombre + " participó en el " + evento + "."));
      doc.close();
    }
    return out;
  }
}
