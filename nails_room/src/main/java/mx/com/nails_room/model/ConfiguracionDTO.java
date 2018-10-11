package mx.com.nails_room.model;

public class ConfiguracionDTO {
	
	private int configuracionId;
	private String nombreEmpresa;
	private String telefonoUno;
	private String telefonoDos;
	private String direccionEmpresa;	
	
	public String getDireccionEmpresa() {
		return direccionEmpresa;
	}
	public void setDireccionEmpresa(String direccionEmpresa) {
		this.direccionEmpresa = direccionEmpresa;
	}
	public int getConfiguracionId() {
		return configuracionId;
	}
	public void setConfiguracionId(int configuracionId) {
		this.configuracionId = configuracionId;
	}
	public String getNombreEmpresa() {
		return nombreEmpresa;
	}
	public void setNombreEmpresa(String nombreEmpresa) {
		this.nombreEmpresa = nombreEmpresa;
	}
	public String getTelefonoUno() {
		return telefonoUno;
	}
	public void setTelefonoUno(String telefonoUno) {
		this.telefonoUno = telefonoUno;
	}
	public String getTelefonoDos() {
		return telefonoDos;
	}
	public void setTelefonoDos(String telefonoDos) {
		this.telefonoDos = telefonoDos;
	}
	
	

}
