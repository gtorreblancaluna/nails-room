package mx.com.nails_room.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mx.com.nails_room.dao.InventarioDAO;
import mx.com.nails_room.forms.FiltroArticulo;
import mx.com.nails_room.model.ArticuloDTO;
import mx.com.nails_room.service.InventarioServicio;

@Service
public class InventarioServicioImpl implements InventarioServicio {
	
	@Autowired
	private InventarioDAO inventarioDao;

	@Override
	public List<ArticuloDTO> obtenerPorFiltro(FiltroArticulo filtroArticulo) {
		// TODO Auto-generated method stub
		return inventarioDao.obtenerPorFiltro(filtroArticulo);
	}

	@Override
	public void agregar(ArticuloDTO articuloDTO) {
		inventarioDao.agregar(articuloDTO);

	}

	@Override
	public void editar(ArticuloDTO articuloDTO) {
		// TODO Auto-generated method stub

	}

	@Override
	public void eliminar(ArticuloDTO articuloDTO) {
		// TODO Auto-generated method stub

	}

}
