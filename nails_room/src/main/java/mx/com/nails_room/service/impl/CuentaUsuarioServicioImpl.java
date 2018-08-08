package mx.com.nails_room.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mx.com.nails_room.dao.CuentaUsuarioDAO;
import mx.com.nails_room.model.UsuarioDTO;
import mx.com.nails_room.service.CuentaUsuarioServicio;

@Service ("cuentaUsuarioServicio")
public class CuentaUsuarioServicioImpl implements CuentaUsuarioServicio{

	@Autowired
	private CuentaUsuarioDAO cuentaUsuarioDao;
	
	@Override
	public UsuarioDTO validar(UsuarioDTO usuario) {
		// TODO Auto-generated method stub
		return cuentaUsuarioDao.validar(usuario);
	}

}
