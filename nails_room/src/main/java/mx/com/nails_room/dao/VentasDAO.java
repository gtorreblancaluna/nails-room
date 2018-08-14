package mx.com.nails_room.dao;

import java.util.List;

import mx.com.nails_room.forms.FiltroVentas;
import mx.com.nails_room.model.EstacionTrabajoDTO;
import mx.com.nails_room.model.VentaDTO;

public interface VentasDAO {
	
	public List<VentaDTO> obtenerPorFiltro(FiltroVentas filtroVentas);
	public void agregar(VentaDTO venta);
	public List<VentaDTO> obtenerPuestos();
	public void editar(VentaDTO ventasDTO);
	public void eliminar(VentaDTO ventasDTO);
	public List<EstacionTrabajoDTO> obtenerEstacionesTrabajo();

}
