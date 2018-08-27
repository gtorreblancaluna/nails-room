package mx.com.nails_room.model;

import java.sql.Timestamp;
import java.util.List;

public class CajaDTO {

	private int cajaId;
	private UsuarioDTO usuario;
	private Timestamp fechaApertura;
	private Timestamp fechaCierre;
	private String activo;
	private String descripcion;
	private DetalleCajaDTO detalleCajaDTO;
	private List<DetalleCajaDTO> detalleCaja;
	
	public DetalleCajaDTO getDetalleCajaDTO() {
		return detalleCajaDTO;
	}
	public void setDetalleCajaDTO(DetalleCajaDTO detalleCajaDTO) {
		this.detalleCajaDTO = detalleCajaDTO;
	}
	public List<DetalleCajaDTO> getDetalleCaja() {
		return detalleCaja;
	}
	public void setDetalleCaja(List<DetalleCajaDTO> detalleCaja) {
		this.detalleCaja = detalleCaja;
	}
	public int getCajaId() {
		return cajaId;
	}
	public void setCajaId(int cajaId) {
		this.cajaId = cajaId;
	}
	public UsuarioDTO getUsuario() {
		return usuario;
	}
	public void setUsuario(UsuarioDTO usuario) {
		this.usuario = usuario;
	}
	public Timestamp getFechaApertura() {
		return fechaApertura;
	}
	public void setFechaApertura(Timestamp fechaApertura) {
		this.fechaApertura = fechaApertura;
	}
	public Timestamp getFechaCierre() {
		return fechaCierre;
	}
	public void setFechaCierre(Timestamp fechaCierre) {
		this.fechaCierre = fechaCierre;
	}
	public String getActivo() {
		return activo;
	}
	public void setActivo(String activo) {
		this.activo = activo;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	
	
}
