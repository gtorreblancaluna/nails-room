package mx.com.nails_room.model;

import java.sql.Timestamp;

public class ArticuloDTO {

	private int articuloId;
	private Timestamp fechaAlta;
	private String descripcion;
	private String unidadMedida;
	private float precioVenta;
	private float cantidadExistente;
	private String esProducto;
	private String activo;
	
	public int getArticuloId() {
		return articuloId;
	}
	public void setArticuloId(int articuloId) {
		this.articuloId = articuloId;
	}
	public Timestamp getFechaAlta() {
		return fechaAlta;
	}
	public void setFechaAlta(Timestamp fechaAlta) {
		this.fechaAlta = fechaAlta;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public String getUnidadMedida() {
		return unidadMedida;
	}
	public void setUnidadMedida(String unidadMedida) {
		this.unidadMedida = unidadMedida;
	}
	public float getPrecioVenta() {
		return precioVenta;
	}
	public void setPrecioVenta(float precioVenta) {
		this.precioVenta = precioVenta;
	}
	public float getCantidadExistente() {
		return cantidadExistente;
	}
	public void setCantidadExistente(float cantidadExistente) {
		this.cantidadExistente = cantidadExistente;
	}
	public String getEsProducto() {
		return esProducto;
	}
	public void setEsProducto(String esProducto) {
		this.esProducto = esProducto;
	}
	public String getActivo() {
		return activo;
	}
	public void setActivo(String activo) {
		this.activo = activo;
	}
	
	
}
