package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import connection.SingleConnection;
import model.ModelTelefone;

public class DAOTelefoneRepository {
	
	private Connection connection;
	
	private DAOUsuarioRepository daoUsuarioRepository = new DAOUsuarioRepository();
	
	public DAOTelefoneRepository() {
		connection = SingleConnection.getConnection();
	}
	
	public ModelTelefone gravaTelefone(ModelTelefone modelTelefone) throws SQLException {
		
		String sql = "insert into telefone (numero, usuario_id, usuario_cad) values(?, ?, ?)";
		
		PreparedStatement statement = connection.prepareStatement(sql);
		statement.setString(1, modelTelefone.getNumero());
		statement.setLong(2, modelTelefone.getUsuario_id().getId());
		statement.setLong(3, modelTelefone.getUsuario_cad().getId());
		
		statement.execute();
		
		connection.commit();
		
		return modelTelefone;
	}
	
	public List<ModelTelefone> listFone(Long idUser) throws SQLException {
		
		List<ModelTelefone> telefones = new ArrayList<ModelTelefone>();
		
		String sql = "select * from telefone where usuario_id = ?";
		
		PreparedStatement statement = connection.prepareStatement(sql);
		
		statement.setLong(1, idUser);
		
		ResultSet resultado = statement.executeQuery();
		
		while(resultado.next()) {
			
			ModelTelefone modelTelefone = new ModelTelefone();
			
			modelTelefone.setId(resultado.getLong("id"));
			modelTelefone.setNumero(resultado.getString("numero"));
			modelTelefone.setUsuario_cad(daoUsuarioRepository.consultaUsuarioId(resultado.getLong("usuario_cad")));
			modelTelefone.setUsuario_id(daoUsuarioRepository.consultaUsuarioId(resultado.getLong("usuario_id")));
			
			telefones.add(modelTelefone);
		}
		
		return telefones;
	}
	
	public void deleteTelefone(Long id) throws SQLException {
		
		String sql = "delete from telefone where id =?";
		
		PreparedStatement statement = connection.prepareStatement(sql);
		statement.setLong(1, id);
		
		statement.executeUpdate();
		connection.commit();
	}

}





