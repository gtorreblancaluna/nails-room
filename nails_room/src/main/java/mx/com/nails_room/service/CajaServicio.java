package mx.com.nails_room.service;
import mx.com.nails_room.model.CajaDTO;
import mx.com.nails_room.model.DetalleCajaDTO;


public interface CajaServicio {
	public CajaDTO obtenerCajaAbierta();
	public boolean abrirCaja(CajaDTO caja);
	public boolean ingresarDetalleCaja(DetalleCajaDTO detalleCaja);
	public boolean cerrarCaja(CajaDTO caja);
}
