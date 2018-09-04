package mx.com.nails_room.dao;

import java.util.List;

import mx.com.nails_room.model.CajaDTO;
import mx.com.nails_room.model.DetalleCajaDTO;

public interface CajaDAO {
	public CajaDTO obtenerCajaAbierta();
	public boolean abrirCaja(CajaDTO caja);
	public boolean ingresarDetalleCaja(DetalleCajaDTO detalleCaja);
	public boolean cerrarCaja(CajaDTO caja);
	public List<CajaDTO> obtenerCajaPorFechas(String feInicial, String feFinal);
	public void eliminarMovimiento (int id);
}
