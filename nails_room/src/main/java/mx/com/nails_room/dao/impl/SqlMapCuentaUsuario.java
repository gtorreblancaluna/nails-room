package mx.com.nails_room.dao.impl;
import org.mybatis.spring.support.SqlSessionDaoSupport;

import mx.com.nails_room.dao.CuentaUsuarioDAO;
import mx.com.nails_room.model.UsuarioDTO;

public class SqlMapCuentaUsuario extends SqlSessionDaoSupport implements CuentaUsuarioDAO{

	@Override
	public UsuarioDTO validar(UsuarioDTO usuarioDTO) {			
		return getSqlSession().selectOne("validar", usuarioDTO);		
	}

}
