package mx.com.nails_room.model;

public class PuestoDTO {
	
	private int puestoId;
	private String descripcion;
	private String activo;	
	
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public int getPuestoId() {
		return puestoId;
	}
	public void setPuestoId(int puestoId) {
		this.puestoId = puestoId;
	}
	
	public String getActivo() {
		return activo;
	}
	public void setActivo(String activo) {
		this.activo = activo;
	}
	
	

}
