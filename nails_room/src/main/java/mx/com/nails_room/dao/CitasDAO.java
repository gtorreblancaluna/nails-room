package mx.com.nails_room.dao;

import java.util.List;

import mx.com.nails_room.forms.FiltroCitas;
import mx.com.nails_room.model.CitasDTO;
import mx.com.nails_room.model.EstadoCitaDTO;

public interface CitasDAO {
	public List<CitasDTO> obtenerCitasPorFiltro(FiltroCitas filtro);
	public void agregar(CitasDTO cita);
	public List<EstadoCitaDTO> obtenerEstadosCitas();
	public void actualizarEstado(CitasDTO cita);

}
