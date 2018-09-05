package mx.com.nails_room.commons;

public interface ApplicationConstants {	
	/** ----------------------------------------------------------------------------
	 *  VALORES ESTATICOS PARA EL MANEJO DEL CATALOGO C_ESTADO_VENTA EN LA BASE DE DATOS
	 * ------------------------------------------------------------------------------
	 * */	
	/** estado de la venta REGISTRADO = 1 */
	public static final Integer VENTA_PREVENTA = 1;
	/** estado de la venta CANCELADO = 2 */
	public static final Integer VENTA_CANCELADO = 2;
	/** estado de la venta AUTORIZADO = 3 */
	public static final Integer VENTA_FINALIZADO = 3;
	
	/** ----------------------------------------------------------------------------
	 *  VALORES ESTATICOS PARA EL MANEJO DEL CATALOGO C_PUESTO EN LA BASE DE DATOS
	 * ------------------------------------------------------------------------------
	 * */
	/** estado para el puesto ADMINISTRADOR = 1 */
	public static final Integer PUESTO_ADMINISTRADOR = 1;
	/** estado para el puesto VENDEDOR = 2 */
	public static final Integer PUESTO_MOSTRADOR = 2;
	/** estado para el puesto CHOFER = 3 */
	public static final Integer PUESTO_VENDEDOR = 3;
	/** estado para el puesto PROVEEDOR = 4 */
	public static final Integer PUESTO_APLICADOR = 4;
	
	/** VALORES PARA ESTADO DE LA CITA */
	/** estado de la cita APARTADO = 1 */
	public static final int CITA_APARTADO = 1;
	/** estado de la cita en proceso = 2 */
	public static final int CITA_EN_PROCESO = 2;
	/** estado de la cita finalizado = 3 */
	public static final int CITA_FINALIZADO = 3;
	/** estado de la cita cancelado = 3 */
	public static final int CITA_CANCELADO = 4;
	

	/** Mascara fecha grande */
	public static final String MASK_DATE_FORMAT = "EEEEEEEE dd 'de' MMMMMMMMMMMMMM, yyyy";
	/** ruta para tomar las imagenes en PDF */
	public static final String RUTA_IMAGENES_PDF = "C:/herramientas/eclipseoxygen-nails-room/webapps/nails_room/images/";
	
}
