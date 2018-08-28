package mx.com.nails_room.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mx.com.nails_room.dao.CajaDAO;
import mx.com.nails_room.model.CajaDTO;
import mx.com.nails_room.model.DetalleCajaDTO;
import mx.com.nails_room.service.CajaServicio;

@Service("cajaServicio")
public class CajaServicioImpl implements CajaServicio {
	
	@Autowired
	private CajaDAO cajaDao;
	
	@Override
	public CajaDTO obtenerCajaAbierta() {
		// TODO Auto-generated method stub
		return cajaDao.obtenerCajaAbierta();
	}

	@Override
	public boolean abrirCaja(CajaDTO caja) {
		cajaDao.abrirCaja(caja);
		return false;
	}

	@Override
	public boolean ingresarDetalleCaja(DetalleCajaDTO detalleCaja) {
		cajaDao.ingresarDetalleCaja(detalleCaja);
		return false;
	}

	@Override
	public boolean cerrarCaja(CajaDTO caja) {
		cajaDao.cerrarCaja(caja);
		return false;
	}

}
