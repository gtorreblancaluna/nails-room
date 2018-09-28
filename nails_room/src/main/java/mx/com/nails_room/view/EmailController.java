package mx.com.nails_room.view;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import mx.com.nails_room.service.EmailService;
import mx.com.nails_room.service.impl.EmailServiceImpl;

@Controller
public class EmailController {
	
	@GetMapping(value = "/email.do")
	public String mostrarInicio(HttpServletRequest request, Model model) {		
		
		return "email";
	}	
	
	@PostMapping(value = "/email.do", params = "enviar")
	public String enviarEmail(HttpServletRequest request, Model model) {
		@SuppressWarnings("resource")
		ApplicationContext context = 
	             new ClassPathXmlApplicationContext("Spring-Mail.xml");
	    	 
	    	EmailServiceImpl mm = (EmailServiceImpl) context.getBean("emailService");
	        mm.sendMail(
	        		"gtorreblancaluna@gmail.com",
	    		   "gerardo.torreblanca85@gmail.com",
	    		   "Testing123", 
	    		   "Testing only \n\n Hello Spring Email Sender");
	        
		return "email";
	}

}
