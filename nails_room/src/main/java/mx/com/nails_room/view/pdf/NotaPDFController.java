package mx.com.nails_room.view.pdf;

/** 2018.08.28
 * @author Gerardo Torreblanca Luna
 * Controller para imprimir la nota de venta
 * 
 **/

import com.lowagie.text.Document;

import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.Image;
import com.lowagie.text.PageSize;
import com.lowagie.text.Phrase;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;

//import com.lowagie.text.pdf.PdfWriter;
import java.awt.Color;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.Format;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Locale;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import static mx.com.nails_room.commons.ApplicationConstants.MASK_DATE_FORMAT;
import static mx.com.nails_room.commons.ApplicationConstants.RUTA_IMAGENES_PDF;
import mx.com.nails_room.model.DetalleVentaDTO;
import mx.com.nails_room.model.VentaDTO;
import mx.com.nails_room.service.VentasServicio;


@Controller
public class NotaPDFController {

	@Autowired
	private VentasServicio ventaServicio;
	@Autowired
	public MessageSource messageSource;
	
		@RequestMapping(value = "/generar_nota.do", method = RequestMethod.GET)
		public String printPdf(HttpServletRequest request,  HttpServletResponse response) throws IOException {
			String rutaPdfImagen = messageSource.getMessage("ruta.pdf.imagen", null, null);
			String ventaId = ( request.getParameter("ventaId") != null ? request.getParameter("ventaId") : null );
			
			if(ventaId == null)
				throw new RuntimeException("No se encontro la operacion");
			
			VentaDTO venta = ventaServicio.obtenerVentaPorId(new Integer(ventaId));
			
			Document document = null;	   
		    PdfWriter writer = null;
			response.setContentType( "application/pdf" );	   
		    response.setHeader("Content-Disposition","inline; filename=\"" + "nota_venta_"+venta.getVentaId()+".pdf\"");
		    OutputStream bao = response.getOutputStream(); 
		    Format formatoFecha = new SimpleDateFormat(MASK_DATE_FORMAT, new Locale("es", "MX"));	
		    
			try {
//				ByteArrayOutputStream baosPDF = new ByteArrayOutputStream();				
				document = new Document();			
//				writer = PdfWriter.getInstance( document, bao );
				writer = PdfWriter.getInstance(document, bao);
				document.addAuthor(this.getClass().getName());
				document.addCreationDate();
				document.addProducer();
				document.addCreator(this.getClass().getName());
				document.addTitle("Nota de venta");
				document.addKeywords("pdf, itext, Java");
				document.setPageSize( PageSize.LETTER);
				document.setMargins(60f, 60f, 20f, 20f);
				document.newPage();
				document.open();			
					
				
				int cellHeight = 13;			    
			    int fontSizeNormal = 9; //tamaño de fuente normal
			    int fontSizeSmall = 8; // tamaño de fuenta pequeña
			    
			    try {
			    	// añadiendo membretado
			    	PdfContentByte canvas = writer.getDirectContentUnder();
					Image image = Image.getInstance(rutaPdfImagen + RUTA_IMAGENES_PDF + "membretado.png");
					image.scaleAbsolute(PageSize.LETTER.width(), PageSize.LETTER.height());
					image.setAbsolutePosition(0, 0);
					canvas.addImage(image);
			    } catch (Exception e) {					
					e.printStackTrace();
				}
			    
			    
				
				// Informacion de la empresa
				PdfPTable headerInfoTable = new PdfPTable(3);
				headerInfoTable.setTotalWidth(new float[]{ 160, 160, 160 });
				headerInfoTable.setLockedWidth(true);
				headerInfoTable.setWidthPercentage(100f);			   
			    
			    PdfPCell cell = new PdfPCell(new Phrase(" NAILS ROOM ",new Font(Font.HELVETICA, fontSizeNormal, Font.NORMAL)));
		        cell.setFixedHeight(cellHeight);
		        cell.setColspan(3);
		        cell.setBorder(Rectangle.NO_BORDER);
		        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		        headerInfoTable.addCell(cell);
		        
		        cell = new PdfPCell(new Phrase("Direccion: Juan Ruiz de Alarc\u00F3n 94, Universal, CP 39080, Chilpancingo Gro",new Font(Font.HELVETICA, fontSizeNormal, Font.NORMAL)));
		        cell.setFixedHeight(cellHeight);
		        cell.setColspan(3);
		        cell.setBorder(Rectangle.NO_BORDER);
		        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		        headerInfoTable.addCell(cell);
		        
		        cell = new PdfPCell(new Phrase("Telefono: 7475450508",new Font(Font.HELVETICA, fontSizeNormal, Font.NORMAL)));
		        cell.setFixedHeight(cellHeight);
		        cell.setColspan(3);
		        cell.setBorder(Rectangle.NO_BORDER);
		        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		        headerInfoTable.addCell(cell);
		        document.add(headerInfoTable);
		        document.add(new Phrase("\n"));  // salto de linea	   
		        document.add(new Phrase("\n"));  // salto de linea
		        
		        
				PdfPTable tablaInfoVenta = new PdfPTable(3);			
				tablaInfoVenta.setTotalWidth(new float[]{ 200, 160, 160 });
				tablaInfoVenta.setLockedWidth(true);
				
				cell = new PdfPCell(new Phrase("Atendi\u00F3: "+venta.getUsuario().getNombre()+" "+venta.getUsuario().getAp_paterno()+" "+venta.getUsuario().getAp_materno(),new Font(Font.HELVETICA, fontSizeNormal, Font.NORMAL)));
		        cell.setFixedHeight(cellHeight);
//		        cell.setColspan(3);
		        cell.setBorder(Rectangle.NO_BORDER);
		        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		        tablaInfoVenta.addCell(cell);	
		        
		        cell = new PdfPCell(new Phrase("Cliente: "+venta.getCliente().getNombre()+" "+venta.getCliente().getAp_paterno()+" "+venta.getCliente().getAp_materno(),new Font(Font.HELVETICA, fontSizeNormal, Font.NORMAL)));
		        cell.setFixedHeight(cellHeight);
//		        cell.setColspan(3);
		        cell.setBorder(Rectangle.NO_BORDER);
		        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		        tablaInfoVenta.addCell(cell);
		        
		        cell = new PdfPCell(new Phrase("FOLIO: "+venta.getVentaId(),new Font(Font.HELVETICA, fontSizeNormal, Font.NORMAL)));
		        cell.setFixedHeight(cellHeight);
//		        cell.setColspan(3);
		        cell.setBorder(Rectangle.NO_BORDER);
		        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		        tablaInfoVenta.addCell(cell);
		        
		       	  
		        cell = new PdfPCell(new Phrase("Estaci\u00F3n de trabajo: "+venta.getEstacionTrabajo().getDescripcion().toUpperCase(),new Font(Font.HELVETICA, fontSizeNormal, Font.NORMAL)));
		        cell.setFixedHeight(cellHeight);
//		        cell.setColspan(3);
		        cell.setBorder(Rectangle.NO_BORDER);
		        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		        tablaInfoVenta.addCell(cell);
		        
		        cell = new PdfPCell(new Phrase("Estado de la venta: "+venta.getEstadoVenta().getDescripcion(),new Font(Font.HELVETICA, fontSizeNormal, Font.NORMAL)));
		        cell.setFixedHeight(cellHeight);
//		        cell.setColspan(2);
		        cell.setBorder(Rectangle.NO_BORDER);
		        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		        tablaInfoVenta.addCell(cell);
		        
		        cell = new PdfPCell(new Phrase("Tipo de pago: "+(venta.getPagoEfectivo().equals("1") ? "EFECTIVO" : "TARJETA"),new Font(Font.HELVETICA, fontSizeNormal, Font.NORMAL)));
		        cell.setFixedHeight(cellHeight);
//		        cell.setColspan(2);
		        cell.setBorder(Rectangle.NO_BORDER);
		        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		        tablaInfoVenta.addCell(cell);
		        
		        cell = new PdfPCell(new Phrase("Descripci\u00F3n venta: "+venta.getDescripcion(),new Font(Font.HELVETICA, fontSizeNormal, Font.NORMAL)));
		        cell.setFixedHeight(cellHeight);
		        cell.setColspan(3);
		        cell.setBorder(Rectangle.NO_BORDER);
		        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		        tablaInfoVenta.addCell(cell);
		        
		        cell = new PdfPCell(new Phrase("Fecha registro venta: "+formatoFecha.format(venta.getFechaRegistro()),new Font(Font.HELVETICA, fontSizeNormal, Font.NORMAL)));
		        cell.setFixedHeight(cellHeight);
		        cell.setColspan(3);
		        cell.setBorder(Rectangle.NO_BORDER);
		        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		        tablaInfoVenta.addCell(cell);
		        		        
		        document.add(tablaInfoVenta);		      
		        // salto de linea
		        document.add(new Phrase("\n"));
		        // Agregando tabla para los detalles
		        PdfPTable tableDetails = new PdfPTable(6);
		        tableDetails.setTotalWidth(new float[] {60,90,120,90,80,80});
		        tableDetails.setLockedWidth(true);
		        
			    int cellHeightDetails = 12;
			    // tabla para el detalle de la venta
			    // id | cantidad | UM | descripcion articulo/servicio | Tipo |cantidad | precio | subtotal   
			    
//			    cell = new PdfPCell(new Phrase("Id",new Font(Font.HELVETICA, fontSizeNormal, Font.NORMAL)));
//		        cell.setFixedHeight(cellHeight);
////		        cell.setColspan(3);
//		        cell.setBorder(Rectangle.BOTTOM);
//		        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
//		        tableDetails.addCell(cell);
		        
		        cell = new PdfPCell(new Phrase("Cantidad",new Font(Font.HELVETICA, fontSizeNormal, Font.NORMAL)));
		        cell.setFixedHeight(cellHeight);
//		        cell.setColspan(3);
		        cell.setBorder(Rectangle.BOTTOM);
		        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		        tableDetails.addCell(cell);
		        
		        cell = new PdfPCell(new Phrase("U.M.",new Font(Font.HELVETICA, fontSizeNormal, Font.NORMAL)));
		        cell.setFixedHeight(cellHeight);
//		        cell.setColspan(3);
		        cell.setBorder(Rectangle.BOTTOM);
		        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		        tableDetails.addCell(cell);
		        
		        cell = new PdfPCell(new Phrase("Descripci\u00F3n",new Font(Font.HELVETICA, fontSizeNormal, Font.NORMAL)));
		        cell.setFixedHeight(cellHeight);
//		        cell.setColspan(3);
		        cell.setBorder(Rectangle.BOTTOM);
		        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		        tableDetails.addCell(cell);
		        
		        cell = new PdfPCell(new Phrase("Tipo",new Font(Font.HELVETICA, fontSizeNormal, Font.NORMAL)));
		        cell.setFixedHeight(cellHeight);
//		        cell.setColspan(3);
		        cell.setBorder(Rectangle.BOTTOM);
		        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		        tableDetails.addCell(cell);
		        
		       		        
		        cell = new PdfPCell(new Phrase("Precio",new Font(Font.HELVETICA, fontSizeNormal, Font.NORMAL)));
		        cell.setFixedHeight(cellHeight);
//		        cell.setColspan(3);
		        cell.setBorder(Rectangle.BOTTOM);
		        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		        tableDetails.addCell(cell);
		        
		        cell = new PdfPCell(new Phrase("Subtotal",new Font(Font.HELVETICA, fontSizeNormal, Font.NORMAL)));
		        cell.setFixedHeight(cellHeight);
//		        cell.setColspan(3);
		        cell.setBorder(Rectangle.BOTTOM);
		        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		        tableDetails.addCell(cell);

		        Float total = 0f;
		        for(DetalleVentaDTO detalle : venta.getDetalleVenta()) {
		       
		        	// agregar los articulos de la venta
		        	// cantidad
//		        	cell = new PdfPCell(new Phrase(detalle.getArticulo().getArticuloId()+"",new Font(Font.HELVETICA, fontSizeSmall, Font.NORMAL, new Color(80, 80, 80))));
//		        	cell.setBorder(0);
//		        	cell.setHorizontalAlignment(PdfPCell.ALIGN_CENTER);
//		        	cell.setFixedHeight(cellHeightDetails);		 	       
//		 	        tableDetails.addCell(cell);
		 	        
		 	        // cantidad
		 	        cell = new PdfPCell(new Phrase(detalle.getCantidad()+"",new Font(Font.HELVETICA, fontSizeSmall, Font.NORMAL, new Color(80, 80, 80))));
		 	       	cell.setBorder(0);
		 	      	cell.setHorizontalAlignment(PdfPCell.ALIGN_CENTER);
		 	     	cell.setFixedHeight(cellHeightDetails);		 	       
		 	        tableDetails.addCell(cell);
		 	        
		 	        //U.M.
		 	        cell = new PdfPCell(new Phrase(detalle.getArticulo().getUnidadMedida(),new Font(Font.HELVETICA, fontSizeSmall, Font.NORMAL, new Color(80, 80, 80))));
		 	        cell.setFixedHeight(cellHeightDetails);
		 	      	cell.setBorder(0);
		 	     	cell.setHorizontalAlignment(PdfPCell.ALIGN_CENTER);
		 	     	cell.setBorder(Rectangle.NO_BORDER);
		 	        tableDetails.addCell(cell);
		 	        
		 	        //descripcion
		 	        cell = new PdfPCell(new Phrase(detalle.getArticulo().getDescripcion(),new Font(Font.HELVETICA, fontSizeSmall, Font.NORMAL, new Color(80, 80, 80))));
		 	       	cell.setBorder(0);
		 	      	cell.setHorizontalAlignment(PdfPCell.ALIGN_CENTER);
		 	     	cell.setFixedHeight(cellHeightDetails);		 	      
		 	        tableDetails.addCell(cell);
		 	        
		 	        // producto/servicio
		 	        cell = new PdfPCell(new Phrase(detalle.getArticulo().getEsProducto().equals("1") ? "Producto" : "Servicio",new Font(Font.HELVETICA, fontSizeSmall, Font.NORMAL, new Color(80, 80, 80))));
		 	       	cell.setBorder(0);
		 	      	cell.setHorizontalAlignment(PdfPCell.ALIGN_CENTER);
		 	     	cell.setFixedHeight(cellHeightDetails);		 	      
		 	        tableDetails.addCell(cell);	
		 	        
		 	        //precio
		 	        cell = new PdfPCell(new Phrase(NumberFormat.getCurrencyInstance(new Locale("es", "MX")).format(detalle.getPrecioArticulo()),new Font(Font.HELVETICA, fontSizeSmall, Font.NORMAL, new Color(80, 80, 80))));
		 	        cell.setFixedHeight(cellHeightDetails);
		 	      	cell.setBorder(0);
		 	     	cell.setHorizontalAlignment(PdfPCell.ALIGN_RIGHT);
		 	     	cell.setBorder(Rectangle.NO_BORDER);
		 	        tableDetails.addCell(cell);
		 	        
		 	        //subtotal
		 	        String subtotal = NumberFormat.getCurrencyInstance(new Locale("es", "MX")).format(detalle.getCantidad()*detalle.getPrecioArticulo());
		 	        cell = new PdfPCell(new Phrase(subtotal,new Font(Font.HELVETICA, fontSizeSmall, Font.NORMAL, new Color(80, 80, 80))));
		 	       	cell.setFixedHeight(cellHeightDetails);
		 	       	cell.setBorder(0);
		 	       	cell.setHorizontalAlignment(PdfPCell.ALIGN_RIGHT);
		 	        tableDetails.addCell(cell);
		 	        
		 	        total += detalle.getCantidad()*detalle.getPrecioArticulo();
		 	        
		        	
		        }
	 	        
		        cell = new PdfPCell(new Phrase("Total a pagar: "+NumberFormat.getCurrencyInstance(new Locale("es", "MX")).format(total),new Font(Font.HELVETICA, fontSizeSmall, Font.NORMAL)));
		        cell.setFixedHeight(cellHeightDetails);
		        cell.setBorder(Rectangle.NO_BORDER);
		        cell.setColspan(6);	        
		        cell.setHorizontalAlignment(PdfPCell.ALIGN_RIGHT);
		        tableDetails.addCell(cell);
		        
		        document.add(tableDetails);
		        
				
				((ByteArrayOutputStream) bao).writeTo(bao);
				} catch (DocumentException e) {					
					throw new RuntimeException(e);
				} catch (IOException e) {				
					throw new RuntimeException(e);
				} finally {				
					if( document != null && document.isOpen() ) {
				        document.close();
				    }
					if( writer != null ) {
				        writer.close();
				    }
					bao.flush();
					bao.close();			
				}
				
				return null;
			
		}
		
} //end controller