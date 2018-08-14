package mx.com.nails_room.model;

public class DetalleVentaDTO {
	
	private int detalleVentaId;
	private int ventaId;
	private ArticuloDTO articulo;
	private Float cantidad;
	private Float precioArticulo;
	private int ordenEntrada;
	public int getDetalleVentaId() {
		return detalleVentaId;
	}
	public void setDetalleVentaId(int detalleVentaId) {
		this.detalleVentaId = detalleVentaId;
	}
	public int getVentaId() {
		return ventaId;
	}
	public void setVentaId(int ventaId) {
		this.ventaId = ventaId;
	}
	public ArticuloDTO getArticulo() {
		return articulo;
	}
	public void setArticulo(ArticuloDTO articulo) {
		this.articulo = articulo;
	}
	public Float getCantidad() {
		return cantidad;
	}
	public void setCantidad(Float cantidad) {
		this.cantidad = cantidad;
	}
	public Float getPrecioArticulo() {
		return precioArticulo;
	}
	public void setPrecioArticulo(Float precioArticulo) {
		this.precioArticulo = precioArticulo;
	}
	public int getOrdenEntrada() {
		return ordenEntrada;
	}
	public void setOrdenEntrada(int ordenEntrada) {
		this.ordenEntrada = ordenEntrada;
	}
	
	

}
