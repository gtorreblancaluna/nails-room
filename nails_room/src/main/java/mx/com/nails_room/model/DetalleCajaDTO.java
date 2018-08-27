package mx.com.nails_room.model;

public class DetalleCajaDTO {
	
	private int detalleCajaId;
	private int cajaId;
	private String esIngreso;
	private float monto;
	private String descripcion;
	public int getDetalleCajaId() {
		return detalleCajaId;
	}
	public void setDetalleCajaId(int detalleCajaId) {
		this.detalleCajaId = detalleCajaId;
	}
	public int getCajaId() {
		return cajaId;
	}
	public void setCajaId(int cajaId) {
		this.cajaId = cajaId;
	}
	public String getEsIngreso() {
		return esIngreso;
	}
	public void setEsIngreso(String esIngreso) {
		this.esIngreso = esIngreso;
	}
	public float getMonto() {
		return monto;
	}
	public void setMonto(float monto) {
		this.monto = monto;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	
	

}
