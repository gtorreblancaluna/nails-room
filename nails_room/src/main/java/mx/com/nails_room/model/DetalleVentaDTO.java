package mx.com.nails_room.model;

public class DetalleVentaDTO {
	
	private int detalleVentaId;
	private int ventaId;
	private ArticuloDTO articulo;
	private Float cantidad;
	private Float precioArticulo;
	private int ordenEntrada;
	
	// variables para mostrar en el reporte
	private int cantidadVendida;
	private float totalVendidoPorArticulo;
	private String nombreCliente;
	
	
	
	public String getNombreCliente() {
		return nombreCliente;
	}
	public void setNombreCliente(String nombreCliente) {
		this.nombreCliente = nombreCliente;
	}
	public int getCantidadVendida() {
		return cantidadVendida;
	}
	public void setCantidadVendida(int cantidadVendida) {
		this.cantidadVendida = cantidadVendida;
	}
	public float getTotalVendidoPorArticulo() {
		return totalVendidoPorArticulo;
	}
	public void setTotalVendidoPorArticulo(float totalVendidoPorArticulo) {
		this.totalVendidoPorArticulo = totalVendidoPorArticulo;
	}
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
