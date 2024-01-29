package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import connection.SingleConnection;
import model.ModelUsuario;

public class DAOUsuarioRepository {
	
	private Connection connection;
	
	public DAOUsuarioRepository() {
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
	
	public void gravarUsuario(ModelUsuario usuario) throws SQLException {
		
	
		String sql = "INSERT INTO users(nome, email, senha) VALUES (?, ?, ?);";
		PreparedStatement preparedSql = connection.prepareStatement(sql);
			
		preparedSql.setString(1, usuario.getNome());
		preparedSql.setString(2, usuario.getEmail());
		preparedSql.setString(3, usuario.getSenha());
		
		preparedSql.execute();
		connection.commit();

	}

}



