package mx.com.proyect.puntoventa.web.dao.impl;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;
import mx.com.proyect.puntoventa.web.dao.AccountDAO;
import mx.com.proyect.puntoventa.web.forms.LoginForm;
import mx.com.proyect.puntoventa.web.model.AccountDTO;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Component;

public class SqlMapAccountDao extends SqlSessionDaoSupport implements AccountDAO {

	@Override
	public List<AccountDTO> getAll() {
		// TODO Auto-generated method stub
		return getSqlSession().selectList("getAllUsers");
	}

	@Override
	public AccountDTO findById(Long id) {
		return ((AccountDTO) getSqlSession().selectOne("findByIdUser", id));
	}

	@Override
	public void update(AccountDTO account) {
		getSqlSession().update("updateUser",account);
		
	}

	@Override
	public void remove(AccountDTO account) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void insert(AccountDTO account) {
		Timestamp l = new Timestamp(System.currentTimeMillis());
		account.setAddDate(l);
		account.setAdmin(account.getFgAdmin()==null ? "0":"1");
		getSqlSession().insert("insertUser", account);
		
	}

	@Override
	public AccountDTO validateUser(LoginForm loginForm) {
		return ((AccountDTO) getSqlSession().selectOne("validateUser", loginForm));
	}

}
