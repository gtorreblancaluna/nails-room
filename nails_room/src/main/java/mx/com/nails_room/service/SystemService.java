package mx.com.nails_room.service;

import mx.com.nails_room.model.ConfiguracionDTO;

public interface SystemService {
	
	public ConfiguracionDTO obtenerConfiguracion();
	public void guardar(ConfiguracionDTO configuracion);

}
