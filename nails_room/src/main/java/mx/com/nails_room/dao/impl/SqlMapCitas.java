package mx.com.nails_room.dao.impl;

import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import mx.com.nails_room.dao.CitasDAO;
import mx.com.nails_room.forms.FiltroCitas;
import mx.com.nails_room.model.CitasDTO;
import mx.com.nails_room.model.EstadoCitaDTO;

public class SqlMapCitas extends SqlSessionDaoSupport implements CitasDAO {

	@Override
	public List<CitasDTO> obtenerCitasPorFiltro(FiltroCitas filtro) {
		// TODO Auto-generated method stub
		return getSqlSession().selectList("obtenerCitasPorFiltro",filtro);
	}

	@Override
	public void agregar(CitasDTO cita) {
		getSqlSession().insert("agregarCita",cita);
		
	}

	@Override
	public List<EstadoCitaDTO> obtenerEstadosCitas() {
		// TODO Auto-generated method stub
		return getSqlSession().selectList("obtenerEstadosCitas");
	}

	@Override
	public void actualizarEstado(CitasDTO cita) {
		getSqlSession().update("actualizarEstado",cita);
		
	}

}
