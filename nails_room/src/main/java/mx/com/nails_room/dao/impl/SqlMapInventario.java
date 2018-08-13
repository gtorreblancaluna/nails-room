package mx.com.nails_room.dao.impl;

import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import mx.com.nails_room.dao.InventarioDAO;
import mx.com.nails_room.forms.FiltroArticulo;
import mx.com.nails_room.model.ArticuloDTO;

public class SqlMapInventario extends SqlSessionDaoSupport implements InventarioDAO {

	@Override
	public List<ArticuloDTO> obtenerPorFiltro(FiltroArticulo filtroArticulo) {
		// TODO Auto-generated method stub
		return getSqlSession().selectList("obtenerArticulosPorFiltro",filtroArticulo);
	}

	@Override
	public void agregar(ArticuloDTO articuloDTO) {
		getSqlSession().insert("agregarArticulo",articuloDTO);
	}

	@Override
	public void editar(ArticuloDTO articuloDTO) {
		// TODO Auto-generated method stub

	}

	@Override
	public void eliminar(ArticuloDTO articuloDTO) {
		// TODO Auto-generated method stub

	}

}
