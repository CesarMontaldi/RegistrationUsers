package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import connection.SingleConnection;
import model.ModelUsuario;

public class DAOLoginRepository {
	
	private Connection connection;
	
	public DAOLoginRepository() {
		connection = SingleConnection.getConnection();
	}
	
	public boolean validarAutenticacao(ModelUsuario modelUsuario) throws SQLException {
		
		String sql = "select * from users where upper(email) = upper(?) and upper(senha) = upper(?) ";
		
		PreparedStatement statement = connection.prepareStatement(sql);
		
		statement.setString(1, modelUsuario.getEmail());
		statement.setString(2, modelUsuario.getSenha());
		
		ResultSet resultSet = statement.executeQuery();
		
		if (resultSet.next()) {
			return true;/* autenticado */
		}
		
		return false;/* não autenticado */
	}

}
