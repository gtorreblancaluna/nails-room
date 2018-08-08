package mx.com.nails_room.model;

import java.io.Serializable;

public class UserSession implements Serializable{

	private static final long serialVersionUID = 1L;
	private UsuarioDTO usuario;
	 
	 public UserSession( UsuarioDTO usuario )
	  {
	    this.usuario = usuario;
	  }

	public UsuarioDTO getUsuario() {
		return usuario;
	}

	public void setUsuario(UsuarioDTO usuario) {
		this.usuario = usuario;
	}


	 

}
