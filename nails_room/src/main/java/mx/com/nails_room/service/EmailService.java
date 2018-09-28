package mx.com.nails_room.service;

public interface EmailService {
	public void sendMail(String from, String to, String subject, String msg);
}
