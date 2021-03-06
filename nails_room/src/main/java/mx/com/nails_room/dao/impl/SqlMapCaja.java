package mx.com.nails_room.dao.impl;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import mx.com.nails_room.dao.CajaDAO;
import mx.com.nails_room.model.CajaDTO;
import mx.com.nails_room.model.DetalleCajaDTO;

public class SqlMapCaja extends SqlSessionDaoSupport implements CajaDAO {

	@Override
	public CajaDTO obtenerCajaAbierta() {
		// TODO Auto-generated method stub
		CajaDTO caja = getSqlSession().selectOne("obtenerCajaAbierta");
		if(caja != null)
			caja.setDetalleCaja(getSqlSession().selectList("obtenerDetalleCaja",caja.getCajaId()));
		
		return caja;
	}

	@Override
	public boolean abrirCaja(CajaDTO caja) {
		getSqlSession().insert("agregarCaja",caja);
		Map<String,Object> map = new HashMap<>();
		caja.getDetalleCajaDTO().setEsIngreso("1");
		caja.getDetalleCajaDTO().setDescripcion("Apertura caja");
		map.put("cajaId", caja.getCajaId());
		map.put("detalle", caja.getDetalleCajaDTO());
		getSqlSession().insert("agregarDetalleCaja",map);
		return true;
	}

	@Override
	public boolean ingresarDetalleCaja(DetalleCajaDTO detalleCaja) {		
		getSqlSession().insert("ingresarDetalleCaja",detalleCaja);
		return true;
	}

	@Override
	public boolean cerrarCaja(CajaDTO caja) {
		caja.setActivo("0");
		caja.setFechaCierre(new Timestamp(System.currentTimeMillis()));
		getSqlSession().update("cerrarCaja",caja);
		return false;
	}

	@Override
	public List<CajaDTO> obtenerCajaPorFechas(String feInicial, String feFinal) {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<>();
		map.put("fechaInicial", feInicial);
		map.put("fechaFinal", feFinal);
		return getSqlSession().selectList("obtenerCajaPorFechas",map);
	}

	@Override
	public void eliminarMovimiento(int id) {
		getSqlSession().delete("eliminarMovimiento",id);		
	}

	@Override
	public CajaDTO obtenerCajaPorId(int cajaId) {
		// TODO Auto-generated method stub
		CajaDTO caja = getSqlSession().selectOne("obtenerCajaPorId",cajaId);
		if(caja != null)
			caja.setDetalleCaja(getSqlSession().selectList("obtenerDetalleCaja",caja.getCajaId()));
		
		return caja;
	}

}
