package mx.com.nails_room.service;

import java.util.List;

import mx.com.nails_room.forms.FiltroCitas;
import mx.com.nails_room.model.CitasDTO;
import mx.com.nails_room.model.EstadoCitaDTO;

public interface CitasServicio {
	
	public List<CitasDTO> obtenerCitasPorFiltro(FiltroCitas filtro);
	public List<EstadoCitaDTO> obtenerEstadosCitas();
	public void agregar(CitasDTO cita);
	public void actualizarEstado(CitasDTO cita);

}
