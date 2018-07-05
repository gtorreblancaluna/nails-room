package mx.com.proyect.puntoventa.web.service;

import java.util.List;

import mx.com.proyect.puntoventa.web.forms.SaleNoteFilter;
import mx.com.proyect.puntoventa.web.forms.SaleNoteForm;
import mx.com.proyect.puntoventa.web.model.SaleNoteDTO;
import mx.com.proyect.puntoventa.web.resultsQuerys.ResultQuerySaleNote;

public interface SaleNoteService {
	
	boolean add(SaleNoteForm saleNoteForm);
	boolean update(SaleNoteForm saleNoteForm);
	boolean delete(SaleNoteForm saleNoteForm);
	List<SaleNoteForm> getAll();
	public List<ResultQuerySaleNote> getByFilter(SaleNoteFilter saleNoteFilter);
	SaleNoteForm getSaleNoteById(Integer id);
	// contendra lo de la tabla y sus detalles completo
	SaleNoteDTO getSaleById(Integer id);
	public List<ResultQuerySaleNote> getSalesToday();
}
