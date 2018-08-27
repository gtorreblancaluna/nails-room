package mx.com.nails_room.forms;

public class FiltroVentas {
	
	private String fechaInicioFiltro;
	private String fechaFinFiltro;
	private String descripcionFiltro;
	private String nombreClienteFiltro;
	private String idUsuarioFiltro;
	private String estadoVentaFiltro;
	private int cajaId;	
	
	public int getCajaId() {
		return cajaId;
	}
	public void setCajaId(int cajaId) {
		this.cajaId = cajaId;
	}
	public String getEstadoVentaFiltro() {
		return estadoVentaFiltro;
	}
	public void setEstadoVentaFiltro(String estadoVentaFiltro) {
		this.estadoVentaFiltro = estadoVentaFiltro;
	}
	public String getFechaInicioFiltro() {
		return fechaInicioFiltro;
	}
	public void setFechaInicioFiltro(String fechaInicioFiltro) {
		this.fechaInicioFiltro = fechaInicioFiltro;
	}
	public String getFechaFinFiltro() {
		return fechaFinFiltro;
	}
	public void setFechaFinFiltro(String fechaFinFiltro) {
		this.fechaFinFiltro = fechaFinFiltro;
	}
	public String getDescripcionFiltro() {
		return descripcionFiltro;
	}
	public void setDescripcionFiltro(String descripcionFiltro) {
		this.descripcionFiltro = descripcionFiltro;
	}
	public String getNombreClienteFiltro() {
		return nombreClienteFiltro;
	}
	public void setNombreClienteFiltro(String nombreClienteFiltro) {
		this.nombreClienteFiltro = nombreClienteFiltro;
	}
	public String getIdUsuarioFiltro() {
		return idUsuarioFiltro;
	}
	public void setIdUsuarioFiltro(String idUsuarioFiltro) {
		this.idUsuarioFiltro = idUsuarioFiltro;
	}
	
	

}
