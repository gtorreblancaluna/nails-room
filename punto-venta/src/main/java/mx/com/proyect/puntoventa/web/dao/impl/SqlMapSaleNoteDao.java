package mx.com.proyect.puntoventa.web.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import mx.com.proyect.puntoventa.web.dao.SaleNoteDAO;
import mx.com.proyect.puntoventa.web.forms.SaleNoteForm;
import mx.com.proyect.puntoventa.web.model.ItemDTO;

public class SqlMapSaleNoteDao extends SqlSessionDaoSupport implements SaleNoteDAO {

	@Override
	public boolean add(SaleNoteForm saleNoteForm) {
		getSqlSession().insert("addSaleNote",saleNoteForm);
		// insertamos los detalles				
		for(ItemDTO item : saleNoteForm.getItems()) {
			Map<String,Object> param = new HashMap<>();
			param.put("saleId", saleNoteForm.getSaleId());
			param.put("itemId", item.getItemId());
			param.put("amount", item.getAmountEntry());
			getSqlSession().insert("addSaleNoteDetails",param);
		}
		return true;
	}

	@Override
	public boolean update(SaleNoteForm saleNoteForm) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean delete(SaleNoteForm saleNoteForm) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public List<SaleNoteForm> getAll() {
		// TODO Auto-generated method stub
		return null;
	}

}