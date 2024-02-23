package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.eclipse.jdt.internal.compiler.ast.ForeachStatement;

import beandto.DTOGraficoSalarioUser;
import connection.SingleConnection;
import model.ModelTelefone;
import model.ModelUsuario;

public class DAOUsuarioRepository {

	private Connection connection;
	
	public DAOUsuarioRepository() {
		connection = SingleConnection.getConnection();
	}

	public boolean validarAutenticacao(ModelUsuario modelUsuario) throws SQLException {

		String sql = "select * from users where upper(email) = upper(?) and senha =?";

		PreparedStatement statement = connection.prepareStatement(sql);

		statement.setString(1, modelUsuario.getEmail());
		statement.setString(2, modelUsuario.getSenha());

		ResultSet resultSet = statement.executeQuery();

		if (resultSet.next()) {
			return true;/* autenticado */
		}

		return false;/* não autenticado */
	}

	public ModelUsuario gravarUsuario(ModelUsuario usuario, Long userLogado) throws SQLException {

		if (usuario.isNovo()) {

			String sql = "insert into users(nome, email, senha, usuario_id, perfil, sexo, cep, logradouro, bairro, cidade, uf, numero, datanascimento, rendamensal) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
			PreparedStatement preparedSql = connection.prepareStatement(sql);

			preparedSql.setString(1, usuario.getNome());
			preparedSql.setString(2, usuario.getEmail());
			preparedSql.setString(3, usuario.getSenha());
			preparedSql.setLong(4, userLogado);
			preparedSql.setString(5, usuario.getPerfil());
			preparedSql.setString(6, usuario.getSexo());
			
			preparedSql.setString(7, usuario.getCep());
			preparedSql.setString(8, usuario.getLogradouro());
			preparedSql.setString(9, usuario.getBairro());
			preparedSql.setString(10, usuario.getCidade());
			preparedSql.setString(11, usuario.getUf());
			preparedSql.setString(12, usuario.getNumero());
			
			preparedSql.setDate(13, usuario.getDataNascimento());
			preparedSql.setDouble(14, usuario.getRendamensal());

			preparedSql.execute();
			connection.commit();
			
				if (usuario.getFotouser() != null && !usuario.getFotouser().isEmpty()) {
					
					sql = "update users set fotouser = ?, extensaofotouser=? where email =?";
					
					preparedSql = connection.prepareStatement(sql);
					
					preparedSql.setString(1, usuario.getFotouser());
					preparedSql.setString(2, usuario.getExtensaofotouser());
					preparedSql.setString(3, usuario.getEmail());
					
					preparedSql.execute();
					connection.commit();
				}

		} else {
			String sql = "update users SET nome=?, email=?, senha=?, perfil=?, sexo=?, cep=?, logradouro=?, bairro=?, cidade=?, uf=?, numero=?, datanascimento=?, rendamensal=? WHERE id = " + usuario.getId() + ";";

			PreparedStatement preparedSql = connection.prepareStatement(sql);

			preparedSql.setString(1, usuario.getNome());
			preparedSql.setString(2, usuario.getEmail());
			preparedSql.setString(3, usuario.getSenha());
			preparedSql.setString(4, usuario.getPerfil());
			preparedSql.setString(5, usuario.getSexo());
			
			preparedSql.setString(6, usuario.getCep());
			preparedSql.setString(7, usuario.getLogradouro());
			preparedSql.setString(8, usuario.getBairro());
			preparedSql.setString(9, usuario.getCidade());
			preparedSql.setString(10, usuario.getUf());
			preparedSql.setString(11, usuario.getNumero());
			
			preparedSql.setDate(12, usuario.getDataNascimento());
			preparedSql.setDouble(13, usuario.getRendamensal());

			preparedSql.executeUpdate();
			connection.commit();
			
				if (usuario.getFotouser() != null && !usuario.getFotouser().isEmpty()) {
					
					sql = "update users set fotouser = ?, extensaofotouser=? where id =?";
					
					preparedSql = connection.prepareStatement(sql);
					
					preparedSql.setString(1, usuario.getFotouser());
					preparedSql.setString(2, usuario.getExtensaofotouser());
					preparedSql.setLong(3, usuario.getId());
					
					preparedSql.execute();
					connection.commit();
				}
		}

		return this.consultaUsuario(usuario.getEmail(), userLogado);
	}

	public List<ModelUsuario> consultaUsuarioList(Long userLogado) throws SQLException {

		List<ModelUsuario> usuarios = new ArrayList<ModelUsuario>();

		String sql = "select * from users where useradmin is false and usuario_id = " + userLogado + " order By nome ASC limit 5";

		PreparedStatement preparedSql = connection.prepareStatement(sql);

		ResultSet resultado = preparedSql.executeQuery();

		while (resultado.next()) {
			ModelUsuario user = new ModelUsuario();

			user.setId(resultado.getLong("id"));
			user.setNome(resultado.getString("nome"));
			user.setEmail(resultado.getString("email"));
			user.setPerfil(resultado.getString("perfil"));
			user.setSexo(resultado.getString("sexo"));

			user.setTelefones(this.listFone(user.getId()));
			
			usuarios.add(user);
		}

		return usuarios;
	}
	
	public List<ModelUsuario> consultaUsuariosRelatorio(Long userLogado) throws SQLException {

		List<ModelUsuario> usuarios = new ArrayList<ModelUsuario>();

		String sql = "select * from users where useradmin is false and usuario_id = " + userLogado + " order By nome ASC";

		PreparedStatement preparedSql = connection.prepareStatement(sql);

		ResultSet resultado = preparedSql.executeQuery();
		
		while (resultado.next()) {
			ModelUsuario user = new ModelUsuario();

			user.setId(resultado.getLong("id"));
			user.setNome(resultado.getString("nome"));
			user.setEmail(resultado.getString("email"));
			user.setPerfil(resultado.getString("perfil"));
			user.setSexo(resultado.getString("sexo"));
			user.setDataNascimento(resultado.getDate("datanascimento"));
			user.setTelefones(this.listFone(user.getId()));
			
			usuarios.add(user);
		}

		return usuarios;
	}
	
	public List<ModelUsuario> consultaUsuariosRelatorioPorData(Long userLogado, String dataInicial, String dataFinal) throws Exception  {
  
		List<ModelUsuario> usuarios = new ArrayList<ModelUsuario>();

		String sql = "select * from users where useradmin is false and usuario_id = " + userLogado + " and datanascimento >= ? and datanascimento <= ? order By nome ASC";

		PreparedStatement preparedSql = connection.prepareStatement(sql);
		preparedSql.setDate(1, Date.valueOf(new SimpleDateFormat("yyyy-mm-dd").format(new SimpleDateFormat("dd/mm/yyyy").parse(dataInicial))));
		preparedSql.setDate(2, Date.valueOf(new SimpleDateFormat("yyyy-mm-dd").format(new SimpleDateFormat("dd/mm/yyyy").parse(dataFinal))));

		ResultSet resultado = preparedSql.executeQuery();
		
		while (resultado.next()) {
			ModelUsuario user = new ModelUsuario();

			user.setId(resultado.getLong("id"));
			user.setNome(resultado.getString("nome"));
			user.setEmail(resultado.getString("email"));
			user.setPerfil(resultado.getString("perfil"));
			user.setSexo(resultado.getString("sexo"));
			user.setDataNascimento(resultado.getDate("datanascimento"));
			user.setTelefones(this.listFone(user.getId()));
			
			usuarios.add(user);
		}

		return usuarios;
	}
	
	public int totalPaginas(Long userLogado) throws SQLException {
		
		String sql = "select count(1) as total from users where usuario_id = " + userLogado;

		PreparedStatement preparedSql = connection.prepareStatement(sql);

		ResultSet resultado = preparedSql.executeQuery();
		
		resultado.next();
		
		Double cadastros = resultado.getDouble("total");
		
		Double porpagina = 5.0;
		
		Double pagina = cadastros/ porpagina;
		
		double resto = pagina % 2;
		
		if (resto > 0) {
			pagina ++;
		}
		
		return pagina.intValue();
	}
	
	public List<ModelUsuario> consultaUsuarioListPaginada(Long userLogado, Integer offset) throws SQLException {

		List<ModelUsuario> usuarios = new ArrayList<ModelUsuario>();

		String sql = "select * from users where useradmin is false and usuario_id = " + userLogado + " order By nome ASC offset "+ offset +" limit 5";

		PreparedStatement preparedSql = connection.prepareStatement(sql);

		ResultSet resultado = preparedSql.executeQuery();

		while (resultado.next()) {
			ModelUsuario user = new ModelUsuario();

			user.setId(resultado.getLong("id"));
			user.setNome(resultado.getString("nome"));
			user.setEmail(resultado.getString("email"));
			user.setPerfil(resultado.getString("perfil"));
			user.setSexo(resultado.getString("sexo"));
			
			user.setTelefones(this.listFone(user.getId()));

			usuarios.add(user);
		}

		return usuarios;
	}
	
	public int consultaUsuarioListTotalPaginacao(String nome, Long userLogado) throws SQLException {

		String sql = "select count(1) as total from users where upper(nome) like upper(?) and useradmin is false and usuario_id = ?";

		PreparedStatement preparedSql = connection.prepareStatement(sql);

		preparedSql.setString(1, "%" + nome + "%");
		preparedSql.setLong(2, userLogado);

		ResultSet resultado = preparedSql.executeQuery();

		resultado.next();
		
		Double cadastros = resultado.getDouble("total");
		
		Double porpagina = 5.0;
		
		Double pagina = cadastros/ porpagina;
		
		double resto = pagina % 2;
		
		if (resto > 0) {
			pagina ++;
		}
		
		return pagina.intValue();
	}

	public List<ModelUsuario> consultaUsuarioList(String nome, Long userLogado) throws SQLException {

		List<ModelUsuario> usuarios = new ArrayList<ModelUsuario>();

		String sql = "select * from users where upper(nome) like upper(?) and useradmin is false and usuario_id = ? order By nome ASC limit 5";

		PreparedStatement preparedSql = connection.prepareStatement(sql);

		preparedSql.setString(1, "%" + nome + "%");
		preparedSql.setLong(2, userLogado);

		ResultSet resultado = preparedSql.executeQuery();

		while (resultado.next()) {
			ModelUsuario user = new ModelUsuario();

			user.setId(resultado.getLong("id"));
			user.setNome(resultado.getString("nome"));
			user.setEmail(resultado.getString("email"));
			user.setPerfil(resultado.getString("perfil"));
			user.setSexo(resultado.getString("sexo"));
			
			user.setTelefones(this.listFone(user.getId()));
			
			usuarios.add(user);
		}

		return usuarios;
	}
	
	public List<ModelUsuario> consultaUsuarioListOffSet(String nome, Long userLogado, Integer offset) throws SQLException {

		List<ModelUsuario> usuarios = new ArrayList<ModelUsuario>();

		String sql = "select * from users where upper(nome) like upper(?) and useradmin is false and usuario_id = ? order By nome ASC offset "+ offset +" limit 5";

		PreparedStatement preparedSql = connection.prepareStatement(sql);

		preparedSql.setString(1, "%" + nome + "%");
		preparedSql.setLong(2, userLogado);

		ResultSet resultado = preparedSql.executeQuery();

		while (resultado.next()) {
			ModelUsuario user = new ModelUsuario();

			user.setId(resultado.getLong("id"));
			user.setNome(resultado.getString("nome"));
			user.setEmail(resultado.getString("email"));
			user.setPerfil(resultado.getString("perfil"));
			user.setSexo(resultado.getString("sexo"));
			
			user.setTelefones(this.listFone(user.getId()));
			
			usuarios.add(user);
		}

		return usuarios;
	}
	
	public ModelUsuario consultaUsuarioLogado(String email) throws SQLException {

		ModelUsuario user = new ModelUsuario();

		String sql = "select * from users where upper(email) = upper(?) ";

		PreparedStatement statement = connection.prepareStatement(sql);

		statement.setString(1, email);

		ResultSet resultado = statement.executeQuery();

		while (resultado.next()) {
			user.setId(resultado.getLong("id"));
			user.setNome(resultado.getString("nome"));
			user.setEmail(resultado.getString("email"));
			user.setSenha(resultado.getString("senha"));
			user.setUseradmin(resultado.getBoolean("useradmin"));
			user.setPerfil(resultado.getString("perfil"));
			user.setSexo(resultado.getString("sexo"));
			user.setFotouser(resultado.getString("fotouser"));
			
			user.setCep(resultado.getString("cep"));
			user.setLogradouro(resultado.getString("logradouro"));
			user.setBairro(resultado.getString("bairro"));
			user.setCidade(resultado.getString("cidade"));
			user.setUf(resultado.getString("uf"));
			user.setNumero(resultado.getString("numero"));
			
			user.setDataNascimento(resultado.getDate("datanascimento"));
			user.setRendamensal(resultado.getDouble("rendamensal"));
			
		}
		return user;
	}

	public ModelUsuario consultaUsuario(String email) throws SQLException {

		ModelUsuario user = new ModelUsuario();

		String sql = "select * from users where upper(email) = upper(?) and useradmin is false ";

		PreparedStatement statement = connection.prepareStatement(sql);

		statement.setString(1, email);

		ResultSet resultado = statement.executeQuery();

		while (resultado.next()) {
			user.setId(resultado.getLong("id"));
			user.setNome(resultado.getString("nome"));
			user.setEmail(resultado.getString("email"));
			user.setSenha(resultado.getString("senha"));
			user.setUseradmin(resultado.getBoolean("useradmin"));
			user.setPerfil(resultado.getString("perfil"));
			user.setSexo(resultado.getString("sexo"));
			user.setFotouser(resultado.getString("fotouser"));
			
			user.setCep(resultado.getString("cep"));
			user.setLogradouro(resultado.getString("logradouro"));
			user.setBairro(resultado.getString("bairro"));
			user.setCidade(resultado.getString("cidade"));
			user.setUf(resultado.getString("uf"));
			user.setNumero(resultado.getString("numero"));
			
			user.setDataNascimento(resultado.getDate("datanascimento"));
			user.setRendamensal(resultado.getDouble("rendamensal"));

		}
		return user;
	}
	
	public ModelUsuario consultaUsuario(String email, Long userLogado) throws SQLException {

		ModelUsuario user = new ModelUsuario();

		String sql = "select * from users where upper(email) = upper(?) and useradmin is false and usuario_id = " + userLogado;

		PreparedStatement statement = connection.prepareStatement(sql);

		statement.setString(1, email);

		ResultSet resultado = statement.executeQuery();

		while (resultado.next()) {
			user.setId(resultado.getLong("id"));
			user.setNome(resultado.getString("nome"));
			user.setEmail(resultado.getString("email"));
			user.setSenha(resultado.getString("senha"));
			user.setPerfil(resultado.getString("perfil"));
			user.setSexo(resultado.getString("sexo"));
			user.setFotouser(resultado.getString("fotouser"));
			
			user.setCep(resultado.getString("cep"));
			user.setLogradouro(resultado.getString("logradouro"));
			user.setBairro(resultado.getString("bairro"));
			user.setCidade(resultado.getString("cidade"));
			user.setUf(resultado.getString("uf"));
			user.setNumero(resultado.getString("numero"));
			
			user.setDataNascimento(resultado.getDate("datanascimento"));
			user.setRendamensal(resultado.getDouble("rendamensal"));

		}
		return user;
	}
	
	public ModelUsuario consultaUsuarioId(Long id) throws SQLException {

		ModelUsuario user = new ModelUsuario();

		String sql = "select * from users where id = ? and useradmin is false";

		PreparedStatement statement = connection.prepareStatement(sql);

		statement.setLong(1, id);
		
		ResultSet resultado = statement.executeQuery();

		while (resultado.next()) {
			user.setId(resultado.getLong("id"));
			user.setNome(resultado.getString("nome"));
			user.setEmail(resultado.getString("email"));
			user.setSenha(resultado.getString("senha"));
			user.setPerfil(resultado.getString("perfil"));
			user.setSexo(resultado.getString("sexo"));
			user.setFotouser(resultado.getString("fotouser"));
			user.setExtensaofotouser(resultado.getString("extensaofotouser"));
			
			user.setCep(resultado.getString("cep"));
			user.setLogradouro(resultado.getString("logradouro"));
			user.setBairro(resultado.getString("bairro"));
			user.setCidade(resultado.getString("cidade"));
			user.setUf(resultado.getString("uf"));
			user.setNumero(resultado.getString("numero"));
			
			user.setDataNascimento(resultado.getDate("datanascimento"));
			user.setRendamensal(resultado.getDouble("rendamensal"));
			
		}
		return user;
	}
	
	public ModelUsuario consultaUsuarioID(Long id) throws SQLException {

		ModelUsuario user = new ModelUsuario();

		String sql = "select * from users where id = ? and useradmin is false";

		PreparedStatement statement = connection.prepareStatement(sql);

		statement.setLong(1, id);
		
		ResultSet resultado = statement.executeQuery();

		while (resultado.next()) {
			user.setId(resultado.getLong("id"));
			user.setNome(resultado.getString("nome"));
			user.setEmail(resultado.getString("email"));
			user.setSenha(resultado.getString("senha"));
			user.setPerfil(resultado.getString("perfil"));
			user.setSexo(resultado.getString("sexo"));
			user.setFotouser(resultado.getString("fotouser"));
			user.setExtensaofotouser(resultado.getString("extensaofotouser"));
			
			user.setCep(resultado.getString("cep"));
			user.setLogradouro(resultado.getString("logradouro"));
			user.setBairro(resultado.getString("bairro"));
			user.setCidade(resultado.getString("cidade"));
			user.setUf(resultado.getString("uf"));
			user.setNumero(resultado.getString("numero"));
			
			user.setDataNascimento(resultado.getDate("datanascimento"));
			user.setRendamensal(resultado.getDouble("rendamensal"));
			
		}
		return user;
	}

	public ModelUsuario consultaUsuarioId(String id, Long userLogado) throws SQLException {

		ModelUsuario user = new ModelUsuario();

		String sql = "select * from users where id = ? and useradmin is false and usuario_id = ?";

		PreparedStatement statement = connection.prepareStatement(sql);

		statement.setLong(1, Long.parseLong(id));
		statement.setLong(2, userLogado);
		
		ResultSet resultado = statement.executeQuery();

		while (resultado.next()) {
			user.setId(resultado.getLong("id"));
			user.setNome(resultado.getString("nome"));
			user.setEmail(resultado.getString("email"));
			user.setSenha(resultado.getString("senha"));
			user.setPerfil(resultado.getString("perfil"));
			user.setSexo(resultado.getString("sexo"));
			user.setFotouser(resultado.getString("fotouser"));
			user.setExtensaofotouser(resultado.getString("extensaofotouser"));
			
			user.setCep(resultado.getString("cep"));
			user.setLogradouro(resultado.getString("logradouro"));
			user.setBairro(resultado.getString("bairro"));
			user.setCidade(resultado.getString("cidade"));
			user.setUf(resultado.getString("uf"));
			user.setNumero(resultado.getString("numero"));
			
			user.setDataNascimento(resultado.getDate("datanascimento"));
			user.setRendamensal(resultado.getDouble("rendamensal"));
			
		}
		return user;
	}
	
	public DTOGraficoSalarioUser montarGraficoMediaSalario(Long userLogado) throws Exception {
		
		String sql = "select avg(rendamensal) as media_salarial, perfil from users where usuario_id =? group by perfil";
		
		PreparedStatement statement = connection.prepareStatement(sql);
		
		statement.setLong(1, userLogado);
		
		ResultSet resultSet = statement.executeQuery();
		
		List<Double> salarios = new ArrayList<Double>();
		List<String> perfils = new ArrayList<String>();
		
		DTOGraficoSalarioUser dtoGraficoSalarioUser = new DTOGraficoSalarioUser();
	
		
		
		while (resultSet.next()) {
			Double media_salarial = resultSet.getDouble("media_salarial");
			String perfil = resultSet.getString("perfil");
			
			salarios.add(media_salarial);
			perfils.add(perfil);
		}
		
		dtoGraficoSalarioUser.setSalarios(salarios);
		dtoGraficoSalarioUser.setPerfils(perfils);
		
		return dtoGraficoSalarioUser;
	}
	
	public DTOGraficoSalarioUser montarGraficoMediaSalarioPorData(Long userLogado, String dataInicial, String dataFinal) throws Exception{
		String sql = "select avg(rendamensal) as media_salarial, perfil from users where usuario_id =? and datanascimento >= ? and datanascimento <= ? group by perfil";
		
		PreparedStatement statement = connection.prepareStatement(sql);
		
		statement.setLong(1, userLogado);
		statement.setDate(2, Date.valueOf(new SimpleDateFormat("yyyy-mm-dd").format(new SimpleDateFormat("dd/mm/yyyy").parse(dataInicial))));
		statement.setDate(3, Date.valueOf(new SimpleDateFormat("yyyy-mm-dd").format(new SimpleDateFormat("dd/mm/yyyy").parse(dataFinal))));
		
		ResultSet resultSet = statement.executeQuery();
		
		List<Double> salarios = new ArrayList<Double>();
		List<String> perfils = new ArrayList<String>();
		
		DTOGraficoSalarioUser dtoGraficoSalarioUser = new DTOGraficoSalarioUser();
	
		
		
		while (resultSet.next()) {
			Double media_salarial = resultSet.getDouble("media_salarial");
			String perfil = resultSet.getString("perfil");
			
			salarios.add(media_salarial);
			perfils.add(perfil);
		}
		
		dtoGraficoSalarioUser.setSalarios(salarios);
		dtoGraficoSalarioUser.setPerfils(perfils);
		
		return dtoGraficoSalarioUser;
	}

	public boolean validarLogin(String email) throws Exception {

		String sql = "select count(1) > 0 as existe from users where upper(email) = upper(?)";

		PreparedStatement statement = connection.prepareStatement(sql);

		statement.setString(1, email);

		ResultSet resultado = statement.executeQuery();

		resultado.next();
		return resultado.getBoolean("existe");

	}

	public void deletarUser(String idUser) throws SQLException {
		String sql = "delete from users where id = ? and useradmin is false";

		PreparedStatement prepareSql = connection.prepareStatement(sql);

		prepareSql.setLong(1, Long.parseLong(idUser));
		prepareSql.executeUpdate();

		connection.commit();
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
			modelTelefone.setUsuario_cad(this.consultaUsuarioId(resultado.getLong("usuario_cad")));
			modelTelefone.setUsuario_id(this.consultaUsuarioId(resultado.getLong("usuario_id")));
			
			telefones.add(modelTelefone);
		}
		
		return telefones;
	}

}
