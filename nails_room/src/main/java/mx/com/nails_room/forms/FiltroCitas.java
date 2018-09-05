package mx.com.nails_room.forms;

public class FiltroCitas {
	
	private String fechaInicio;
	private String fechaFin;
	private String descripcion;
	private String nombreCliente;
	private String apPaternoCliente;
	private String apMaternoCliente;
	private int estadoCitaId;
	private int idUsuario;	
	
	public String getApPaternoCliente() {
		return apPaternoCliente;
	}
	public void setApPaternoCliente(String apPaternoCliente) {
		this.apPaternoCliente = apPaternoCliente;
	}
	public String getApMaternoCliente() {
		return apMaternoCliente;
	}
	public void setApMaternoCliente(String apMaternoCliente) {
		this.apMaternoCliente = apMaternoCliente;
	}
	public int getEstadoCitaId() {
		return estadoCitaId;
	}
	public void setEstadoCitaId(int estadoCitaId) {
		this.estadoCitaId = estadoCitaId;
	}
	public String getFechaInicio() {
		return fechaInicio;
	}
	public void setFechaInicio(String fechaInicio) {
		this.fechaInicio = fechaInicio;
	}
	public String getFechaFin() {
		return fechaFin;
	}
	public void setFechaFin(String fechaFin) {
		this.fechaFin = fechaFin;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public String getNombreCliente() {
		return nombreCliente;
	}
	public void setNombreCliente(String nombreCliente) {
		this.nombreCliente = nombreCliente;
	}
	public int getIdUsuario() {
		return idUsuario;
	}
	public void setIdUsuario(int idUsuario) {
		this.idUsuario = idUsuario;
	}
	
	

}
