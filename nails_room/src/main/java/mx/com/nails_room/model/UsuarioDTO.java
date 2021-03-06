package mx.com.nails_room.model;

import java.sql.Timestamp;

public class UsuarioDTO extends DatosGeneralesPersonaDTO{
		
	private int usuarioId;
	private PuestoDTO puestoDTO;
	private String contrasenia;
	private Timestamp fechaAlta;
	private String esAdmin;	
	private float comision;
	private String activo;
	
	public String getActivo() {
		return activo;
	}
	public void setActivo(String activo) {
		this.activo = activo;
	}
	public int getUsuarioId() {
		return usuarioId;
	}
	public void setUsuarioId(int usuarioId) {
		this.usuarioId = usuarioId;
	}
	public PuestoDTO getPuestoDTO() {
		return puestoDTO;
	}
	public void setPuestoDTO(PuestoDTO puestoDTO) {
		this.puestoDTO = puestoDTO;
	}
	public String getContrasenia() {
		return contrasenia;
	}
	public void setContrasenia(String contrasenia) {
		this.contrasenia = contrasenia;
	}
	public Timestamp getFechaAlta() {
		return fechaAlta;
	}
	public void setFechaAlta(Timestamp fechaAlta) {
		this.fechaAlta = fechaAlta;
	}
	public String getEsAdmin() {
		return esAdmin;
	}
	public void setEsAdmin(String esAdmin) {
		this.esAdmin = esAdmin;
	}
	public float getComision() {
		return comision;
	}
	public void setComision(float comision) {
		this.comision = comision;
	}
	
	

}
