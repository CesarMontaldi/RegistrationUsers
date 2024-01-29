package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.eclipse.jdt.internal.compiler.ast.ForeachStatement;

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
	
	
	public ModelUsuario gravarUsuario(ModelUsuario usuario) throws SQLException {
		
		if (usuario.isNovo()) {
	
			String sql = "insert into users(nome, email, senha) VALUES (?, ?, ?);";
			PreparedStatement preparedSql = connection.prepareStatement(sql);
				
			preparedSql.setString(1, usuario.getNome());
			preparedSql.setString(2, usuario.getEmail());
			preparedSql.setString(3, usuario.getSenha());
			
			preparedSql.execute();
			connection.commit();
		
		}else {
			String sql = "update users SET nome=?, email=?, senha=? WHERE id = "+usuario.getId()+";";
			
			PreparedStatement preparedSql = connection.prepareStatement(sql);
			
			preparedSql.setString(1, usuario.getNome());
			preparedSql.setString(2, usuario.getEmail());
			preparedSql.setString(3, usuario.getSenha());
			
			preparedSql.executeUpdate();
			connection.commit();
		}
		
		return this.consultaUsuario(usuario.getEmail());
	}
	
	
	public ModelUsuario consultaUsuario(String email) throws SQLException {
		
		ModelUsuario user = new ModelUsuario();

		String sql = "select * from users where upper(email) = upper(?)";
		
		PreparedStatement statement = connection.prepareStatement(sql);
		
		statement.setString(1, email);
		
		ResultSet resultado = statement.executeQuery();
		
		while (resultado.next()) {
			user.setId(resultado.getLong("id"));
			user.setNome(resultado.getString("nome"));
			user.setEmail(resultado.getString("email"));
			user.setSenha(resultado.getString("senha"));
		}
		return user;
	}
	
	public boolean validarLogin(String login) throws Exception {
		
		String sql = "select count(1) > 0 as existe from users where upper(email) = upper(?)";

		PreparedStatement statement = connection.prepareStatement(sql);
		
		statement.setString(1, login);
		
		ResultSet resultado = statement.executeQuery();
		
		resultado.next();
		return resultado.getBoolean("existe");

	}

}



