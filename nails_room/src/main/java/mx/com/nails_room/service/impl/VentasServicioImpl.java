package mx.com.nails_room.service.impl;

import static mx.com.nails_room.commons.ApplicationConstants.VENTA_PREVENTA;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import mx.com.nails_room.dao.ClienteDAO;
import mx.com.nails_room.dao.InventarioDAO;
import mx.com.nails_room.dao.VentasDAO;
import mx.com.nails_room.forms.FiltroVentas;
import mx.com.nails_room.model.ArticuloDTO;
import mx.com.nails_room.model.EstacionTrabajoDTO;
import mx.com.nails_room.model.EstadoVentaDTO;
import mx.com.nails_room.model.VentaDTO;
import mx.com.nails_room.service.VentasServicio;
import static mx.com.nails_room.commons.ApplicationConstants.VENTA_FINALIZADO;

@Service
public class VentasServicioImpl implements VentasServicio {
	
	@Autowired
	private VentasDAO ventasDao;
	@Autowired
	private ClienteDAO clienteDao;
	@Autowired
	private InventarioDAO inventarioDao;

	@Override
	public List<VentaDTO> obtenerPorFiltro(FiltroVentas filtroVentas) {
		// TODO Auto-generated method stub
		return ventasDao.obtenerPorFiltro(filtroVentas);
	}

	@Override
	public void agregar(VentaDTO venta) {
		if(venta.getCliente() == null || venta.getCliente().getClienteId() == 0 ) {
			// Se va a agregar el cliente primero
			clienteDao.agregar(venta.getCliente());
		}
		venta.setEstadoVenta(new EstadoVentaDTO());
		venta.getEstadoVenta().setEstadoVentaId(VENTA_PREVENTA);
		ventasDao.agregar(venta);
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
		return ventasDao.obtenerEstacionesTrabajo();
	}

	@Override
	public void finalizar(VentaDTO venta) {
//		venta = this.obtenerVentaPorId(venta.getVentaId());
		// vamos a descontar articulos del inventario
		venta.getDetalleVenta().stream().forEach(t -> {
			ArticuloDTO articulo = inventarioDao.obtenerPorId(t.getArticulo().getArticuloId());
			if(articulo.getEsProducto().equals("1")) {
				// solo se descuenta los productos
				float cantExistente = articulo.getCantidadExistente();
				float cantDescontar = t.getCantidad();
				float total = cantExistente - cantDescontar;
				articulo.setCantidadExistente(total);
				inventarioDao.editar(articulo);		
			}
		});
		
		this.actualizarEstado(VENTA_FINALIZADO,venta.getVentaId());
	}

	@Override
	public VentaDTO obtenerVentaPorId(int ventaId) {
		// TODO Auto-generated method stub
		return ventasDao.obtenerVentaPorId(ventaId);
	}

	@Override
	public void actualizarEstado(int estado,int ventaId) {
		ventasDao.actualizarEstado(estado,ventaId);
		
	}

	@Override
	public List<EstadoVentaDTO> obtenerEstadosVenta() {
		// TODO Auto-generated method stub
		return ventasDao.obtenerEstadosVenta();
	}

	@Override
	public void actualizar(VentaDTO venta) {
//		if(venta.getCliente() == null || venta.getCliente().getClienteId() == 0 ) {
//			// Se va a agregar el cliente primero
//			clienteDao.agregar(venta.getCliente());
//		}		
		if(venta.getCliente().getClienteId()<0) {
			// es un id negativo , significa que eligio un cliente de la lista
			venta.getCliente().setClienteId((venta.getCliente().getClienteId()*-1));
		}else{
			// actualizamos el cliente
			clienteDao.editar(venta.getCliente());
		}		
		ventasDao.actualizar(venta);
		
	}

	@Override
	public float obtenerTotalVenta(int ventaId) {
		// TODO Auto-generated method stub
		return ventasDao.obtenerTotalVenta(ventaId);
	}

	@Override
	public List<VentaDTO> obtenerVentasAgrupadasPorUsuario(FiltroVentas filtroVentas) {
		// TODO Auto-generated method stub
		return ventasDao.obtenerVentasAgrupadasPorUsuario(filtroVentas);
	}

	@Override
	public void actualizarVenta(VentaDTO venta) {
		ventasDao.actualizarVenta(venta);
		
	}

}
