package model;

import java.io.Serializable;

public class ModelUsuario implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Long id;
	private String nome;
	private String email;
	private String senha;
	private boolean useradmin;
	
	
	public String getNome() {
		return nome;
	}
	
	public void setNome(String nome) {
		this.nome = nome;
	}
	
	public void setId(Long id) {
		this.id = id;
	}
	
	public Long getId() {
		return id;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getEmail() {
		return email;
	}
	
	public String getSenha() {
		return senha;
	}
	public void setSenha(String senha) {
		this.senha = senha;
	}
	
	
	
	public boolean getUseradmin() {
		return useradmin;
	}

	public void setUseradmin(boolean useradmin) {
		this.useradmin = useradmin;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public boolean isNovo() {
	    
		if (this.id == null) {
			return true;/* Inserir novo */
		}else if(this.id != null && this.id > 0) {
			return false;/* Atualizar */
		}
		return isNovo();
	}
	
}
