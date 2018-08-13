package mx.com.nails_room.service;

import java.util.List;
import mx.com.nails_room.forms.FiltroArticulo;
import mx.com.nails_room.model.ArticuloDTO;

public interface InventarioServicio {
	public List<ArticuloDTO> obtenerPorFiltro(FiltroArticulo filtroArticulo);
	public void agregar(ArticuloDTO articuloDTO);
	public void editar(ArticuloDTO articuloDTO);
	public void eliminar(ArticuloDTO articuloDTO);
	
}
