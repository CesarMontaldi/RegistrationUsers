package servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import dao.DAOTelefoneRepository;
import dao.DAOUsuarioRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelTelefone;
import model.ModelUsuario;

@WebServlet("/ServletTelefone")
public class ServletTelefone extends ServletGenericUtil {
	private static final long serialVersionUID = 1L;
	
	private DAOUsuarioRepository daoUsuarioRepository = new DAOUsuarioRepository();
	
	private DAOTelefoneRepository daoTelefoneRepository = new DAOTelefoneRepository();

    public ServletTelefone() {

    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		try {
			 
				 String acao = request.getParameter("acao");
				 String iduser = request.getParameter("iduser");
					 
				 if (acao != null && !acao.isEmpty() && acao.equals("excluir")) {
					 
					 String idfone = request.getParameter("idfone");
					 
					 daoTelefoneRepository.deleteTelefone(Long.parseLong(idfone));
					 
					 ModelUsuario modelUsuario = daoUsuarioRepository.consultaUsuarioId(Long.parseLong(iduser));
					 
					 List<ModelTelefone> listTelefones = daoTelefoneRepository.listFone(Long.parseLong(iduser));
						
					 request.setAttribute("msg", "Telefone excluido com sucesso!");
					 request.setAttribute("listfones", listTelefones);
					 request.setAttribute("usuario", modelUsuario);
					 request.getRequestDispatcher("principal/cadastroTelefone.jsp").forward(request, response);
					 
					 return;
				 }
			
				
				 if (iduser != null && !iduser.isEmpty()) {
					
					ModelUsuario modelUsuario = daoUsuarioRepository.consultaUsuarioId(Long.parseLong(iduser));
					
					List<ModelTelefone> listTelefones = daoTelefoneRepository.listFone(Long.parseLong(iduser));
					
					request.setAttribute("msg", "Telefones carregados com sucesso!");
					request.setAttribute("listfones", listTelefones);
					request.setAttribute("usuario", modelUsuario);
					request.getRequestDispatcher("principal/cadastroTelefone.jsp").forward(request, response);
				 
				 } else {
					 	ModelUsuario modelUsuario = daoUsuarioRepository.consultaUsuarioId(super.getUserLogado(request));
						request.setAttribute("user", modelUsuario);
						request.getRequestDispatcher("principal/cadastroUsuario.jsp").forward(request, response);
				 }
				
			 
			} catch (NumberFormatException | SQLException e) {
				e.printStackTrace();
			}
		 }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			String id = request.getParameter("id");
			String numero = request.getParameter("numero");
			
			ModelTelefone telefone = new ModelTelefone();
			
			ModelUsuario modelUsuario = daoUsuarioRepository.consultaUsuarioId(Long.parseLong(id));
			
			if(!daoTelefoneRepository.existeFone(numero, Long.parseLong(id))) {
			
				telefone.setNumero(numero);
				telefone.setUsuario_id(modelUsuario);
				telefone.setUsuario_cad(super.getUserLogadoObj(request));
				
				daoTelefoneRepository.gravaTelefone(telefone);
				
				
				request.setAttribute("msg_salvar", "Telefone salvo com sucesso!");
				
			}else {
				request.setAttribute("msg_salvar", "Telefone já existe!");
			}
			
			modelUsuario = daoUsuarioRepository.consultaUsuarioId(Long.parseLong(id));
			
			List<ModelTelefone> listTelefones = daoTelefoneRepository.listFone(modelUsuario.getId());
			
			request.setAttribute("usuario", modelUsuario);
			request.setAttribute("listfones", listTelefones);
			request.setAttribute("userfone", telefone);
			request.getRequestDispatcher("principal/cadastroTelefone.jsp").forward(request, response);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
	}

}
