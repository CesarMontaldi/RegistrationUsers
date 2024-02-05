package model;

import java.io.Serializable;
import java.util.Objects;

public class ModelTelefone implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Long id;
	private String numero;
	private ModelUsuario usuario_id;
	private ModelUsuario usuario_cad;
	
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getNumero() {
		return numero;
	}
	public void setNumero(String numero) {
		this.numero = numero;
	}
	public ModelUsuario getUsuario_id() {
		return usuario_id;
	}
	public void setUsuario_id(ModelUsuario usuario_id) {
		this.usuario_id = usuario_id;
	}
	public ModelUsuario getUsuario_cad() {
		return usuario_cad;
	}
	public void setUsuario_cad(ModelUsuario usuario_cad) {
		this.usuario_cad = usuario_cad;
	}
	
	
	@Override
	public int hashCode() {
		return Objects.hash(id);
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ModelTelefone other = (ModelTelefone) obj;
		return Objects.equals(id, other.id);
	}
	
	
}
