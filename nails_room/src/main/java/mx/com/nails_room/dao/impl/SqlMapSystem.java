package mx.com.nails_room.dao.impl;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import mx.com.nails_room.dao.SystemDAO;
import mx.com.nails_room.model.ConfiguracionDTO;

public class SqlMapSystem extends SqlSessionDaoSupport implements SystemDAO{

	@Override
	public ConfiguracionDTO obtenerConfiguracion() {
		// TODO Auto-generated method stub
		return getSqlSession().selectOne("obtenerConfiguracion");
	}

	@Override
	public void guardar(ConfiguracionDTO configuracion) {
		// TODO Auto-generated method stub
		getSqlSession().update("guardarConfiguracion",configuracion);
	}

}
