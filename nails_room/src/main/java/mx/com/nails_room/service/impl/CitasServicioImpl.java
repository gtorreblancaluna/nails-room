package mx.com.nails_room.service.impl;

import static mx.com.nails_room.commons.ApplicationConstants.CITA_APARTADO;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mx.com.nails_room.dao.CitasDAO;
import mx.com.nails_room.dao.ClienteDAO;
import mx.com.nails_room.forms.FiltroCitas;
import mx.com.nails_room.model.CitasDTO;
import mx.com.nails_room.model.EstadoCitaDTO;
import mx.com.nails_room.service.CitasServicio;

@Service("citasServicio")
public class CitasServicioImpl implements CitasServicio {

	@Autowired
	private CitasDAO citasDao;
	@Autowired
	private ClienteDAO clienteDao;
	
	@Override
	public List<CitasDTO> obtenerCitasPorFiltro(FiltroCitas filtro) {
		return citasDao.obtenerCitasPorFiltro(filtro);
	}

	@Override
	public void agregar(CitasDTO cita) {
		if(cita.getCliente() == null || cita.getCliente().getClienteId() == 0 ) {
			// Se va a agregar el cliente primero
			clienteDao.agregar(cita.getCliente());
		}
		try {
			cita.setFechaCitaString(cita.getFechaCitaString().replace("T", " "));
		    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm");
		    Date parsedDate = dateFormat.parse(cita.getFechaCitaString());
		    Timestamp timestamp = new java.sql.Timestamp(parsedDate.getTime());
		    cita.setFechaCita(timestamp);
		} catch(Exception e) { //this generic but you can control another types of exception
		    System.out.println(e); 
		}
		
		cita.setEstadoCita(new EstadoCitaDTO());
		cita.getEstadoCita().setEstadoCitaId(CITA_APARTADO);
		citasDao.agregar(cita);
		
	}

	@Override
	public List<EstadoCitaDTO> obtenerEstadosCitas() {
		// TODO Auto-generated method stub
		return citasDao.obtenerEstadosCitas();
	}

	@Override
	public void actualizarEstado(CitasDTO cita) {
		// TODO Auto-generated method stub
		citasDao.actualizarEstado(cita);
	}

}
