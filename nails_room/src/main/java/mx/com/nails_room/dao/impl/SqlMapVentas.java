
package mx.com.nails_room.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import mx.com.nails_room.dao.VentasDAO;
import mx.com.nails_room.forms.FiltroVentas;
import mx.com.nails_room.model.CajaDTO;
import mx.com.nails_room.model.DetalleVentaDTO;
import mx.com.nails_room.model.EstacionTrabajoDTO;
import mx.com.nails_room.model.EstadoVentaDTO;
import mx.com.nails_room.model.VentaDTO;

public class SqlMapVentas extends SqlSessionDaoSupport implements VentasDAO {

	@Override
	public List<VentaDTO> obtenerPorFiltro(FiltroVentas filtroVentas) {
		// TODO Auto-generated method stub
		return getSqlSession().selectList("obtenerVentasPorFiltro",filtroVentas);
	}

	@Override
	public void agregar(VentaDTO venta) {
		venta.setCaja(new CajaDTO());
		venta.getCaja().setCajaId(1);
		getSqlSession().insert("agregarVenta",venta);
		for(DetalleVentaDTO detalle : venta.getDetalleVenta()) {
			// insertamos el detalle de la venta
			Map<String,Object> map = new HashMap<>();
			map.put("detalle", detalle);
			map.put("ventaId", venta.getVentaId());
			// como la primera vez, ponemos como orden de entrada 1
			map.put("ordenEntrada", 1);
			getSqlSession().insert("agregarDetalleVenta",map);
		}

	}

	@Override
	public List<VentaDTO> obtenerPuestos() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void editar(VentaDTO ventasDTO) {
		// TODO Auto-generated method stub

	}

	@Override
	public void eliminar(VentaDTO ventasDTO) {
		// TODO Auto-generated method stub

	}

	@Override
	public List<EstacionTrabajoDTO> obtenerEstacionesTrabajo() {
		// TODO Auto-generated method stub
		return getSqlSession().selectList("obtenerEstacionesTrabajo");
	}

	@Override
	public VentaDTO obtenerVentaPorId(int ventaId) {
		// TODO Auto-generated method stub
		VentaDTO venta = getSqlSession().selectOne("obtenerVentaPorId",ventaId);
		venta.setDetalleVenta(getSqlSession().selectList("obtenerDetalleVentaPorId",ventaId));
		 return venta;
	}

	@Override
	public void actualizarEstado(int estado, int ventaId) {
		Map<String,Object> map = new HashMap<>();
		map.put("ventaId", ventaId);
		map.put("estado",estado);
		getSqlSession().update("actualizarEstadoVenta",map);
		
	}

	@Override
	public List<EstadoVentaDTO> obtenerEstadosVenta() {
		// TODO Auto-generated method stub
		return getSqlSession().selectList("obtenerEstadosVenta");
	}

	@Override
	public void actualizar(VentaDTO venta) {		
		
		getSqlSession().delete("eliminarDetalleVenta",venta.getVentaId());		
		
		// agregamos el detalle de la venta
		for(DetalleVentaDTO detalle : venta.getDetalleVenta()) {
			// insertamos el detalle de la venta
			Map<String,Object> map = new HashMap<>();
			map.put("detalle", detalle);
			map.put("ventaId", venta.getVentaId());
			// como la primera vez, ponemos como orden de entrada 1
			map.put("ordenEntrada", 1);
			getSqlSession().insert("agregarDetalleVenta",map);
		}
		
		getSqlSession().update("actualizarVenta",venta);
		
	}

	@Override
	public float obtenerTotalVenta(int ventaId) {
		return getSqlSession().selectOne("obtenerTotalVenta",ventaId);
	}

}
