package connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class SingleConnection {
	
	private static String url = "jdbc:postgresql://localhost:5433/cadastro-user?autoReconnect=true";
	private static String user = "postgres";
	private static String password = "postgres";
	private static Connection connection = null;
	
	static {
		conectar();
	}
	
	public SingleConnection() { /* Quando tiver uma instancia vai conectar */
		conectar();
	}
	
	public static Connection getConnection() {
		return connection;
	}
	
	private static void conectar() {
		
		try {
			
			if (connection == null) {
				Class.forName("org.postgresql.Driver"); /* Carrega o Driver de conexão do banco */
				connection = DriverManager.getConnection(url, user, password);
				connection.setAutoCommit(false); /* Para não efetuar alterações no banco sem nosso comando */
			}
			
		} catch (Exception e) {
			e.printStackTrace(); /* Mostra qualquer erro no momento de conectar */
		}
	}
}
