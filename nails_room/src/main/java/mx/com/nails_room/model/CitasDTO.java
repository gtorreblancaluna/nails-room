package mx.com.nails_room.model;

import java.sql.Timestamp;

public class CitasDTO {

	private int citaId;
	private ClienteDTO cliente;
	private EstadoCitaDTO estadoCita;
	private Timestamp fechaRegistro;
	private Timestamp fechaCita;
	private String descripcion;
	// para la vista
	private String fechaCitaString;
	
	public String getFechaCitaString() {
		return fechaCitaString;
	}
	public void setFechaCitaString(String fechaCitaString) {
		this.fechaCitaString = fechaCitaString;
	}
	public int getCitaId() {
		return citaId;
	}
	public void setCitaId(int citaId) {
		this.citaId = citaId;
	}
	public ClienteDTO getCliente() {
		return cliente;
	}
	public void setCliente(ClienteDTO cliente) {
		this.cliente = cliente;
	}
	public EstadoCitaDTO getEstadoCita() {
		return estadoCita;
	}
	public void setEstadoCita(EstadoCitaDTO estadoCita) {
		this.estadoCita = estadoCita;
	}
	public Timestamp getFechaRegistro() {
		return fechaRegistro;
	}
	public void setFechaRegistro(Timestamp fechaRegistro) {
		this.fechaRegistro = fechaRegistro;
	}
	public Timestamp getFechaCita() {
		return fechaCita;
	}
	public void setFechaCita(Timestamp fechaCita) {
		this.fechaCita = fechaCita;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	
	
	
}
