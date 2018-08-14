package mx.com.nails_room.service.facade;

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

import mx.com.nails_room.forms.FiltroArticulo;
import mx.com.nails_room.model.ArticuloDTO;
import mx.com.nails_room.model.ClienteDTO;
import mx.com.nails_room.service.ClienteServicio;
import mx.com.nails_room.service.InventarioServicio;

@Controller
public class VentasFacade {
	
	@Autowired
	private ClienteServicio clienteServicio;
	@Autowired
	private InventarioServicio inventarioServicio;
	
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

}
