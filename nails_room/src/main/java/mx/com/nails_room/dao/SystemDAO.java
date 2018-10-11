package mx.com.nails_room.dao;

import mx.com.nails_room.model.ConfiguracionDTO;

public interface SystemDAO {

	public ConfiguracionDTO obtenerConfiguracion();
	public void guardar(ConfiguracionDTO configuracion);
}
