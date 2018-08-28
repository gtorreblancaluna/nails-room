package mx.com.nails_room.service;

import java.util.List;
import mx.com.nails_room.forms.FiltroUsuario;
import mx.com.nails_room.forms.FiltroVentas;
import mx.com.nails_room.model.ClienteDTO;
import mx.com.nails_room.model.EstacionTrabajoDTO;
import mx.com.nails_room.model.EstadoVentaDTO;
import mx.com.nails_room.model.VentaDTO;

public interface VentasServicio {

	public List<VentaDTO> obtenerPorFiltro(FiltroVentas filtroVentas);
	public void agregar(VentaDTO ventasDTO);
	public void finalizar(VentaDTO ventasDTO);
	public List<VentaDTO> obtenerPuestos();
	public void editar(VentaDTO ventasDTO);
	public void eliminar(VentaDTO ventasDTO);
	public List<EstacionTrabajoDTO> obtenerEstacionesTrabajo();
	public VentaDTO obtenerVentaPorId(int ventaId);
	public void actualizarEstado(int estado,int ventaId);
	public List<EstadoVentaDTO> obtenerEstadosVenta();
	public void actualizar(VentaDTO venta);
	public float obtenerTotalVenta(int ventaId);
	public List<VentaDTO> obtenerVentasAgrupadasPorUsuario(FiltroVentas filtroVentas);
	
}
