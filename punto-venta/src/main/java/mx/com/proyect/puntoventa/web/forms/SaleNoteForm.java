package mx.com.proyect.puntoventa.web.forms;


import java.sql.Timestamp;
import java.util.List;
import mx.com.proyect.puntoventa.web.model.ItemDTO;
import mx.com.proyect.puntoventa.web.model.SaleDetailDTO;
/* GTL 2018.05.21 
 * POJO para llenar en la vista de NOTA DE VENTA
 * 
 * */ 
public class SaleNoteForm {
	
	private int saleId;
	private String userId;
	private String storeId;
	private String sellerId;
	private String dateSaleNote;
	// almacenara el detalle de la venta para mostrar en la vista
	private List<SaleDetailDTO> saleDetail;
	private List<ItemDTO> items;
	// fecha de registro
	private Timestamp dateTimestamp;
	// fecha de entrega
	private Timestamp dateDelivery;
	private String description;
	
	

	public List<SaleDetailDTO> getSaleDetail() {
		return saleDetail;
	}

	public void setSaleDetail(List<SaleDetailDTO> saleDetail) {
		this.saleDetail = saleDetail;
	}

	public Timestamp getDateDelivery() {
		return dateDelivery;
	}

	public void setDateDelivery(Timestamp dateDelivery) {
		this.dateDelivery = dateDelivery;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getSaleId() {
		return saleId;
	}

	public void setSaleId(int saleId) {
		this.saleId = saleId;
	}

	public String getStoreId() {
		return storeId;
	}

	public void setStoreId(String storeId) {
		this.storeId = storeId;
	}

	public Timestamp getDateTimestamp() {
		return dateTimestamp;
	}

	public void setDateTimestamp(Timestamp dateTimestamp) {
		this.dateTimestamp = dateTimestamp;
	}

	public String getDateSaleNote() {
		return dateSaleNote;
	}

	public void setDateSaleNote(String dateSaleNote) {
		this.dateSaleNote = dateSaleNote;	
	}

	public String getSellerId() {
		return sellerId;
	}

	public void setSellerId(String sellerId) {
		this.sellerId = sellerId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public List<ItemDTO> getItems() {
		return items;
	}

	public void setItems(List<ItemDTO> items) {
		this.items = items;
	}

}
