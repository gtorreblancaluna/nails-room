package mx.com.nails_room.model;

public class EstacionTrabajoDTO {
	
	private int estacionTrabajoId;
	private String descripcion;
	private String activo;
	private int orden;
	public int getEstacionTrabajoId() {
		return estacionTrabajoId;
	}
	public void setEstacionTrabajoId(int estacionTrabajoId) {
		this.estacionTrabajoId = estacionTrabajoId;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public String getActivo() {
		return activo;
	}
	public void setActivo(String activo) {
		this.activo = activo;
	}
	public int getOrden() {
		return orden;
	}
	public void setOrden(int orden) {
		this.orden = orden;
	}
	
	

}
