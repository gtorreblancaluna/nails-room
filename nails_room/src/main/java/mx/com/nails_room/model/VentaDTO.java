package mx.com.nails_room.model;

import java.sql.Timestamp;
import java.util.List;

public class VentaDTO {
	
	private int ventaId;
	private ClienteDTO cliente;
	private ArticuloDTO articulo;
	private UsuarioDTO usuario;
	private CajaDTO caja;	
	private EstacionTrabajoDTO estacionTrabajo;
	private String descripcion;
	private String pagoEfectivo;
	private String pagoTarjeta;
	private Timestamp fechaRegistro;
	private EstadoVentaDTO estadoVenta;	
	private List<DetalleVentaDTO> detalleVenta;
	private String comisionPagada;
	// suma total de la venta
	private float totalVenta;
	// total de comision por la venta
	private float totalComision;	
	// bandera para indicar si desea imprimir nota despues de guardar la venta
	private boolean imprimirNota;
	
	public boolean isImprimirNota() {
		return imprimirNota;
	}
	public void setImprimirNota(boolean imprimirNota) {
		this.imprimirNota = imprimirNota;
	}
	public String getComisionPagada() {
		return comisionPagada;
	}
	public void setComisionPagada(String comisionPagada) {
		this.comisionPagada = comisionPagada;
	}
	public float getTotalComision() {
		return totalComision;
	}
	public void setTotalComision(float totalComision) {
		this.totalComision = totalComision;
	}
	public float getTotalVenta() {
		return totalVenta;
	}
	public void setTotalVenta(float totalVenta) {
		this.totalVenta = totalVenta;
	}
	public List<DetalleVentaDTO> getDetalleVenta() {
		return detalleVenta;
	}
	public void setDetalleVenta(List<DetalleVentaDTO> detalleVenta) {
		this.detalleVenta = detalleVenta;
	}
	public EstadoVentaDTO getEstadoVenta() {
		return estadoVenta;
	}
	public void setEstadoVenta(EstadoVentaDTO estadoVenta) {
		this.estadoVenta = estadoVenta;
	}
	public int getVentaId() {
		return ventaId;
	}
	public void setVentaId(int ventaId) {
		this.ventaId = ventaId;
	}
	public Timestamp getFechaRegistro() {
		return fechaRegistro;
	}
	public void setFechaRegistro(Timestamp fechaRegistro) {
		this.fechaRegistro = fechaRegistro;
	}
	public ClienteDTO getCliente() {
		return cliente;
	}
	public void setCliente(ClienteDTO cliente) {
		this.cliente = cliente;
	}
	public ArticuloDTO getArticulo() {
		return articulo;
	}
	public void setArticulo(ArticuloDTO articulo) {
		this.articulo = articulo;
	}
	public UsuarioDTO getUsuario() {
		return usuario;
	}
	public void setUsuario(UsuarioDTO usuario) {
		this.usuario = usuario;
	}
	public CajaDTO getCaja() {
		return caja;
	}
	public void setCaja(CajaDTO caja) {
		this.caja = caja;
	}
	public EstacionTrabajoDTO getEstacionTrabajo() {
		return estacionTrabajo;
	}
	public void setEstacionTrabajo(EstacionTrabajoDTO estacionTrabajo) {
		this.estacionTrabajo = estacionTrabajo;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public String getPagoEfectivo() {
		return pagoEfectivo;
	}
	public void setPagoEfectivo(String pagoEfectivo) {
		this.pagoEfectivo = pagoEfectivo;
	}
	public String getPagoTarjeta() {
		return pagoTarjeta;
	}
	public void setPagoTarjeta(String pagoTarjeta) {
		this.pagoTarjeta = pagoTarjeta;
	}

}
