package mx.com.nails_room.service.facade;

import java.io.IOException;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import mx.com.nails_room.forms.FiltroArticulo;
import mx.com.nails_room.forms.FiltroVentas;
import mx.com.nails_room.model.ArticuloDTO;
import mx.com.nails_room.model.CajaDTO;
import mx.com.nails_room.model.ClienteDTO;
import mx.com.nails_room.model.DetalleCajaDTO;
import mx.com.nails_room.model.VentaDTO;
import mx.com.nails_room.service.CajaServicio;
import mx.com.nails_room.service.ClienteServicio;
import mx.com.nails_room.service.InventarioServicio;
import mx.com.nails_room.service.VentasServicio;

@Controller
public class VentasFacade {
	
	@Autowired
	private ClienteServicio clienteServicio;
	@Autowired
	private InventarioServicio inventarioServicio;
	@Autowired
	private VentasServicio ventasServicio;
	@Autowired
	private CajaServicio cajaServicio;
	
	@RequestMapping(value = "/mostrarClientesPorFiltro.do")
	@ResponseBody
	public String mostrarClientesPorFiltro(@RequestBody String valor) {
		Map<String,Object> myMap = new HashMap<>();
		ObjectMapper mapper = new ObjectMapper();
		String json = "";
		List<ClienteDTO> clientes =  clienteServicio.obtenerClientesPorNombre(valor);
		
		myMap.put("clientes", clientes);	
		
		 try {
	            json = mapper.writeValueAsString(myMap);
	        } catch (JsonProcessingException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        } catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}	
		 
		return json;
	}
	
	@RequestMapping(value = "/mostrarArticulosPorFiltro.do")
	@ResponseBody
	public String mostrarArticulosPorFiltro(@RequestBody String valor) {
		Map<String,Object> myMap = new HashMap<>();
		ObjectMapper mapper = new ObjectMapper();
		String json = "";
		FiltroArticulo filtroArticulo = new FiltroArticulo();
		filtroArticulo.setDescripcionFiltro(valor);
		List<ArticuloDTO> articulos =  inventarioServicio.obtenerPorFiltro(filtroArticulo);
		
		myMap.put("articulos", articulos);	
		
		 try {
	            json = mapper.writeValueAsString(myMap);
	        } catch (JsonProcessingException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        } catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}	
		 
		return json;
	}
	
	@RequestMapping(value = "/obtenerVentaPorId.do")
	@ResponseBody
	public String obtenerVentaPorId(@RequestBody String ventaId) {
		Map<String,Object> myMap = new HashMap<>();
		ObjectMapper mapper = new ObjectMapper();
		String json = "";
		
		VentaDTO venta =  ventasServicio.obtenerVentaPorId(new Integer(ventaId));
		
		myMap.put("venta", venta);
		
		 try {
	            json = mapper.writeValueAsString(myMap);
	        } catch (JsonProcessingException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        } catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}	
		 
		return json;
	}
	
	@RequestMapping(value = "/obtenerComisiones.do")
	@ResponseBody
	public String obtenerComisionesHoy(@RequestBody String fecha) {
		Map<String,Object> myMap = new HashMap<>();
		
		ObjectMapper mapper = new ObjectMapper();
		String json = "";
		FiltroVentas filtroVentas = new FiltroVentas();
		if(fecha.equals("hoy")) {	
			// viene vacio, no indico fecha
			LocalDate hoy = LocalDate.now();
			filtroVentas.setFechaInicioFiltro(hoy.toString());
			filtroVentas.setFechaFinFiltro(hoy.toString());
		}else {
			filtroVentas.setFechaInicioFiltro(fecha);
			filtroVentas.setFechaFinFiltro(fecha);
		}
		
		List<VentaDTO> ventas =  ventasServicio.obtenerPorFiltro(filtroVentas);
		List<VentaDTO> ventasComisiones =  ventasServicio.obtenerVentasAgrupadasPorUsuario(filtroVentas);
		if(ventas != null) {
			ventas.stream().forEach(t -> t.setTotalVenta(ventasServicio.obtenerTotalVenta(t.getVentaId())));
			for(VentaDTO venta : ventas) {				
				float usuarioComision = (venta.getUsuario().getComision() / 100);
				venta.setTotalComision( venta.getTotalVenta() * usuarioComision  );
			}
		}
		myMap.put("ventas", ventas);
		myMap.put("ventasComisiones", ventasComisiones);
		 try {
	            json = mapper.writeValueAsString(myMap);
	        } catch (JsonProcessingException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        } catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}	
		 
		return json;
	}
	
	@RequestMapping(value = "/pagarComisionPodIdVenta.do")
	@ResponseBody
	public String pagarComisionPodIdVenta(@RequestBody String ventaId) {
		Map<String,Object> myMap = new HashMap<>();		
		ObjectMapper mapper = new ObjectMapper();
		String json = "";
//		String[] param = parametros.split("-");
		VentaDTO venta = ventasServicio.obtenerVentaPorId(new Integer(ventaId));	
		if(venta == null || venta.getComisionPagada().equals("1")) {
			myMap.put("mensaje", "ERROR. Esta comisi\u00F3n ya se pag\u00F3 -.- ");
			 try {
		            json = mapper.writeValueAsString(myMap);
		        } catch (JsonProcessingException e) {
		            // TODO Auto-generated catch block
		            e.printStackTrace();
		        } catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}			 
			return json;
		}
		venta.setComisionPagada("1");
		ventasServicio.actualizarVenta(venta);
		venta.setTotalVenta(ventasServicio.obtenerTotalVenta(venta.getVentaId()));
		float usuarioComision = (venta.getUsuario().getComision() / 100);
		venta.setTotalComision( venta.getTotalVenta() * usuarioComision  );
		DetalleCajaDTO detalle = new DetalleCajaDTO();
		detalle.setCajaId(venta.getCaja().getCajaId());
		detalle.setEsIngreso("0");
		detalle.setMonto(venta.getTotalComision());
		detalle.setDescripcion("Pago comision a "+venta.getUsuario().getNombre()+" "+venta.getUsuario().getAp_materno());
		cajaServicio.ingresarDetalleCaja(detalle);
		myMap.put("mensaje", "Se registr\u00F3 con \u00E9xito :) ");
		 try {
	            json = mapper.writeValueAsString(myMap);
	        } catch (JsonProcessingException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        } catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}	
		 
		return json;
	}
	
	@RequestMapping(value = "/pagarComisiones.do")
	@ResponseBody
	public String pagarComisiones(@RequestBody String parametros) {
		// declaracion de objetos a utilizar
		Map<String,Object> myMap = new HashMap<>();
		StringBuilder builder = new StringBuilder();
		ObjectMapper mapper = new ObjectMapper();
		String json = "";
		VentaDTO venta = null;		
		// obtenemos la caja abierta
//		CajaDTO caja = cajaServicio.obtenerCajaAbierta();
//		if(caja == null) {			
//			myMap.put("mensaje", "ERROR. No se encontr\u00F3 caja abierta");			
//			 try {
//		            json = mapper.writeValueAsString(myMap);
//		        } catch (JsonProcessingException e) {
//		            // TODO Auto-generated catch block
//		            e.printStackTrace();
//		        } catch (IOException e) {
//					// TODO Auto-generated catch block
//					e.printStackTrace();
//				}			 
//			return json;
//		}
		String[] param = parametros.split("-");
		for(String ventaId : param){ // recorremos las comisiones a pagar	
			try {			
				venta = ventasServicio.obtenerVentaPorId(new Integer(ventaId));			
			}catch (NumberFormatException e) {
				builder.append("ERROR GRAVE. No s\u00E9 recibi\u00F3 parametro correcto para venta id: "+ventaId+"\n");
			}
			
			if(venta != null && venta.getComisionPagada().equals("1")) {
				builder.append(("ERROR. La comisi\u00F3n ya se pag\u00F3 para: "+venta.getUsuario().getNombre()+", venta id: "+venta.getVentaId()+"\n"));
			}else if(venta != null){
				venta.setComisionPagada("1");
				ventasServicio.actualizarVenta(venta);
				venta.setTotalVenta(ventasServicio.obtenerTotalVenta(venta.getVentaId()));
				float usuarioComision = (venta.getUsuario().getComision() / 100);
				venta.setTotalComision( venta.getTotalVenta() * usuarioComision  );
				DetalleCajaDTO detalle = new DetalleCajaDTO();
				detalle.setCajaId(venta.getCaja().getCajaId());
				detalle.setEsIngreso("0");
				detalle.setMonto(venta.getTotalComision());
				detalle.setDescripcion("Pago comision a "+venta.getUsuario().getNombre()+" "+venta.getUsuario().getAp_materno()+", venta id: "+ventaId);
				cajaServicio.ingresarDetalleCaja(detalle);
				builder.append("\u00C9XITO. se pag\u00F3 la comisi\u00F3n para: "+venta.getUsuario().getNombre()+", venta id: "+ventaId+"\n");
			}else {
				builder.append("ERROR GRAVE. No se encontr\u00F3 la venta id: "+ventaId+" :(\n");
			}
		} // fin for each	
		
		myMap.put("mensaje", builder+"");
		 try {
	            json = mapper.writeValueAsString(myMap);
	        } catch (JsonProcessingException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        } catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}	
		 
		return json;
	}

}
