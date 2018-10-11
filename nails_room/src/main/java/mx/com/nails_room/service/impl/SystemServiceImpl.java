package mx.com.nails_room.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mx.com.nails_room.dao.SystemDAO;
import mx.com.nails_room.model.ConfiguracionDTO;
import mx.com.nails_room.service.SystemService;

@Service("systemService")
public class SystemServiceImpl implements SystemService{
	
	@Autowired
	private SystemDAO systemDao;

	@Override
	public ConfiguracionDTO obtenerConfiguracion() {
		// TODO Auto-generated method stub
		return systemDao.obtenerConfiguracion();
	}

	@Override
	public void guardar(ConfiguracionDTO configuracion) {
		// TODO Auto-generated method stub
		systemDao.guardar(configuracion);
	}

}
