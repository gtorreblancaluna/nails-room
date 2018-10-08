package mx.com.nails_room.service.impl;

import java.util.List;

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

	@Override
	public List<CajaDTO> obtenerCajaPorFechas(String feInicial, String feFinal) {
		// TODO Auto-generated method stub
		return cajaDao.obtenerCajaPorFechas(feInicial, feFinal);
	}

	@Override
	public void eliminarMovimiento(int id) {
		cajaDao.eliminarMovimiento(id);		
	}

	@Override
	public CajaDTO obtenerCajaPorId(int cajaId) {
		// TODO Auto-generated method stub
		return cajaDao.obtenerCajaPorId(cajaId);
	}

}
