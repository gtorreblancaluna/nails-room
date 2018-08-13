package mx.com.nails_room.dao.impl;

import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import mx.com.nails_room.dao.VentasDAO;
import mx.com.nails_room.forms.FiltroVentas;
import mx.com.nails_room.model.VentasDTO;

public class SqlMapVentas extends SqlSessionDaoSupport implements VentasDAO {

	@Override
	public List<VentasDTO> obtenerPorFiltro(FiltroVentas filtroVentas) {
		// TODO Auto-generated method stub
		return getSqlSession().selectList("obtenerVentasPorFiltro",filtroVentas);
	}

	@Override
	public void agregar(VentasDTO ventasDTO) {
		// TODO Auto-generated method stub

	}

	@Override
	public List<VentasDTO> obtenerPuestos() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void editar(VentasDTO ventasDTO) {
		// TODO Auto-generated method stub

	}

	@Override
	public void eliminar(VentasDTO ventasDTO) {
		// TODO Auto-generated method stub

	}

}
