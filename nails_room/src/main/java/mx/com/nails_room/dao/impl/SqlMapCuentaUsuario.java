package mx.com.nails_room.dao.impl;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import mx.com.nails_room.dao.CuentaUsuarioDAO;
import mx.com.nails_room.forms.FiltroUsuario;
import mx.com.nails_room.model.UsuarioDTO;

public class SqlMapCuentaUsuario extends SqlSessionDaoSupport implements CuentaUsuarioDAO{

	@Override
	public UsuarioDTO validar(UsuarioDTO usuarioDTO) {			
		return getSqlSession().selectOne("validar", usuarioDTO);		
	}

	@Override
	public List<UsuarioDTO> obtenerUsuariosPorFiltro(FiltroUsuario filtroUsuario) {
		// TODO Auto-generated method stub
		return getSqlSession().selectList("obtenerUsuariosPorFiltro",filtroUsuario);
	}

	@Override
	public void insertar(UsuarioDTO usuarioDTO) {
		getSqlSession().insert("insertarUsuario",usuarioDTO);
		
	}

	@Override
	public List<UsuarioDTO> obtenerPuestos() {
		// TODO Auto-generated method stub
		return getSqlSession().selectList("obtenerPuestos");
	}

	@Override
	public void editar(UsuarioDTO usuarioDTO) {
		getSqlSession().update("editarUsuario",usuarioDTO);
	}

	@Override
	public List<UsuarioDTO> obtenerTodosUsuarios() {
		// TODO Auto-generated method stub
		return getSqlSession().selectList("obtenerTodosUsuarios");
	}

}
