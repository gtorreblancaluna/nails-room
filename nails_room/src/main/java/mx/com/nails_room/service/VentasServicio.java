package mx.com.nails_room.service;

import java.util.List;
import mx.com.nails_room.forms.FiltroUsuario;
import mx.com.nails_room.forms.FiltroVentas;
import mx.com.nails_room.model.ClienteDTO;
import mx.com.nails_room.model.VentasDTO;

public interface VentasServicio {

	public List<VentasDTO> obtenerPorFiltro(FiltroVentas filtroVentas);
	public void agregar(VentasDTO ventasDTO);
	public List<VentasDTO> obtenerPuestos();
	public void editar(VentasDTO ventasDTO);
	public void eliminar(VentasDTO ventasDTO);
	
}
