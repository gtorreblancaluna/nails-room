package mx.com.nails_room.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import mx.com.nails_room.dao.VentasDAO;
import mx.com.nails_room.forms.FiltroVentas;
import mx.com.nails_room.model.VentasDTO;
import mx.com.nails_room.service.VentasServicio;

@Service
public class VentasServicioImpl implements VentasServicio {
	
	private VentasDAO ventasDao;

	@Override
	public List<VentasDTO> obtenerPorFiltro(FiltroVentas filtroVentas) {
		// TODO Auto-generated method stub
		return ventasDao.obtenerPorFiltro(filtroVentas);
	}

	@Override
	public void agregar(VentasDTO ventasDTO) {
		// TODO Auto-generated method stub

	}

	@Override
	public List<VentasDTO> obtenerPuestos() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void editar(VentasDTO ventasDTO) {
		// TODO Auto-generated method stub

	}

	@Override
	public void eliminar(VentasDTO ventasDTO) {
		// TODO Auto-generated method stub

	}

}
