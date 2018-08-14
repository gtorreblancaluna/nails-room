package mx.com.nails_room.service.impl;

import static mx.com.nails_room.commons.ApplicationConstants.VENTA_PREVENTA;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import mx.com.nails_room.dao.ClienteDAO;
import mx.com.nails_room.dao.VentasDAO;
import mx.com.nails_room.forms.FiltroVentas;
import mx.com.nails_room.model.EstacionTrabajoDTO;
import mx.com.nails_room.model.EstadoVentaDTO;
import mx.com.nails_room.model.VentaDTO;
import mx.com.nails_room.service.VentasServicio;

@Service
public class VentasServicioImpl implements VentasServicio {
	
	@Autowired
	private VentasDAO ventasDao;
	@Autowired
	private ClienteDAO clienteDao;

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

}
