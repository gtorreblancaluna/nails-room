package mx.com.nails_room.service.facade;

import static mx.com.nails_room.commons.ApplicationConstants.VENTA_FINALIZADO;

import java.io.IOException;
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

import mx.com.nails_room.forms.FiltroVentas;
import mx.com.nails_room.model.CajaDTO;
import mx.com.nails_room.model.DetalleCajaDTO;
import mx.com.nails_room.model.VentaDTO;
import mx.com.nails_room.service.CajaServicio;
import mx.com.nails_room.service.VentasServicio;

@Controller
public class CajaFacade {
	
	@Autowired
	private CajaServicio cajaServicio;
	@Autowired
	private VentasServicio ventasServicio;
	
	@RequestMapping(value = "/obtenerCajasPorFecha.do")
	@ResponseBody
	public String obtenerCajasPorFecha(@RequestBody String fechas) {
		Map<String,Object> myMap = new HashMap<>();
		ObjectMapper mapper = new ObjectMapper();
		String json = "";
		
		List<CajaDTO> cajas = cajaServicio.obtenerCajaPorFechas(fechas, fechas);	
		myMap.put("cajas", cajas);
		
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
	
	@RequestMapping(value = "/obtenerDetalleCajaPorId.do")
	@ResponseBody
	public String obtenerDetalleCajaPorId(@RequestBody String cajaId) {
		Map<String,Object> myMap = new HashMap<>();
		ObjectMapper mapper = new ObjectMapper();
		float ingresos = 0f;
		float egresos = 0f;
		float totalVentas = 0f;
		String json = "";
		
		CajaDTO caja = cajaServicio.obtenerCajaPorId(new Integer(cajaId));	
		myMap.put("caja", caja);
		
		FiltroVentas filtroVentas = new FiltroVentas();
		filtroVentas.setEstadoVentaFiltro(VENTA_FINALIZADO+"");
		filtroVentas.setCajaId(caja.getCajaId());
		List<VentaDTO> ventas = ventasServicio.obtenerPorFiltro(filtroVentas);
		ventas.stream().forEach(t -> t.setTotalVenta(ventasServicio.obtenerTotalVenta(t.getVentaId())));
		myMap.put("ventas", ventas);
		
		
		for (DetalleCajaDTO detalleCaja : caja.getDetalleCaja()) {
			if(detalleCaja.getEsIngreso().equals("1"))
				ingresos += detalleCaja.getMonto();
			else
				egresos += detalleCaja.getMonto();
		}
		
		for(VentaDTO venta : ventas) {
			totalVentas += venta.getTotalVenta();
		}
		
		myMap.put("totalCaja",((totalVentas + ingresos)-egresos));
		myMap.put("ingresos",ingresos);
		myMap.put("egresos",egresos);
		myMap.put("totalVentas",totalVentas);
		
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
