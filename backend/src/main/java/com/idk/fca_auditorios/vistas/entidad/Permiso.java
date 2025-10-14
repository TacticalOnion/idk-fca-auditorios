package com.idk.fca_auditorios.vistas.entidad;

import jakarta.persistence.*;

@Entity
@Table(name = "permiso")
public class Permiso {
@Id
@Column(name = "id_permiso")
private Short idPermiso;


public Short getIdPermiso() { return idPermiso; }
public void setIdPermiso(Short idPermiso) { this.idPermiso = idPermiso; }
}