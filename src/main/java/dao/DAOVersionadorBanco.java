package dao;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import connection.SingleConnection;

public class DAOVersionadorBanco implements Serializable {

	private static final long serialVersionUID = 1L;

	private Connection connection;
	
	public DAOVersionadorBanco() {
		connection = SingleConnection.getConnection();
	}
	
	public boolean arquivoSqlRodado(String nome_file) throws Exception{
		
		String sql = "select count(1) > 0 as rodado from versionadorbanco where arquivo_sql = ?";
		
		PreparedStatement statement = connection.prepareStatement(sql);
		
		statement.setString(1, nome_file);
		
		ResultSet resultSet = statement.executeQuery();
		
		resultSet.next();
		
		return resultSet.getBoolean("rodado");
	}
	
	public void gravaArquivoRodado(String nome_file) throws SQLException {
		
		String sql = "insert into versionadorbanco(arquivo_sql) values (?)";
		
		PreparedStatement statement = connection.prepareStatement(sql);
		
		statement.setString(1, nome_file);
		
		statement.execute();
	}
}





