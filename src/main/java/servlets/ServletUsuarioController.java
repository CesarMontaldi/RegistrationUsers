package servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelUsuario;

import java.io.IOException;
import java.util.List;

import com.fasterxml.jackson.databind.ObjectMapper;

import dao.DAOUsuarioRepository;


@WebServlet("/ServletUsuarioController")
public class ServletUsuarioController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private DAOUsuarioRepository daoUsuarioRepository = new DAOUsuarioRepository();
 
    public ServletUsuarioController() {

    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			String acao = request.getParameter("acao");
			
			if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("deletar")) {
				String idUser = request.getParameter("id");
				
				daoUsuarioRepository.deletarUser(idUser);
				
				List<ModelUsuario> modelUsuarios = daoUsuarioRepository.consultaUsuarioList();
				request.setAttribute("modelUsuarios", modelUsuarios);
				
				request.setAttribute("msg", "Excluido com sucesso!");
				
				RequestDispatcher redireciona = request.getRequestDispatcher("principal/cadastroUsuario.jsp");
				redireciona.forward(request, response);
				
			}
			else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("deletarAjax")) {
				String idUser = request.getParameter("id");
				
				daoUsuarioRepository.deletarUser(idUser);
				
				response.getWriter().write("Excluido com sucesso!");

			}
			else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("buscarUserAjax")) {
				String nomeBusca = request.getParameter("nomeBusca");
				
				List<ModelUsuario> dadosJsonUser = daoUsuarioRepository.consultaUsuarioList(nomeBusca);
				
				ObjectMapper mapper = new ObjectMapper();
				
				String json = mapper.writeValueAsString(dadosJsonUser);
				
				response.getWriter().write(json);
				
			}
			else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("buscarEditar")) {
				String id = request.getParameter("id");
				
				ModelUsuario user = daoUsuarioRepository.consultaUsuarioId(id);
				
				List<ModelUsuario> modelUsuarios = daoUsuarioRepository.consultaUsuarioList();
				request.setAttribute("modelUsuarios", modelUsuarios);
				
				request.setAttribute("msg", "Usuário em edição");
				RequestDispatcher redireciona = request.getRequestDispatcher("principal/cadastroUsuario.jsp");
				request.setAttribute("modelUsuario", user);
				redireciona.forward(request, response);
				
			}
			else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("listarUser")) {
				
				List<ModelUsuario> modelUsuarios = daoUsuarioRepository.consultaUsuarioList();

				
				request.setAttribute("msg", "Usuários carregados");
				request.setAttribute("modelUsuarios", modelUsuarios);
				request.getRequestDispatcher("principal/cadastroUsuario.jsp").forward(request, response);
				
			}
			else {
				List<ModelUsuario> modelUsuarios = daoUsuarioRepository.consultaUsuarioList();
				request.setAttribute("modelUsuarios", modelUsuarios);
				
				RequestDispatcher redireciona = request.getRequestDispatcher("principal/cadastroUsuario.jsp");
				redireciona.forward(request, response);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			RequestDispatcher redirecionar = request.getRequestDispatcher("error.jsp");
			request.setAttribute("msgError", e.getMessage());
			redirecionar.forward(request, response);
		}

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			
			String msg = "Operação realizada com sucesso!";
			
			String id = request.getParameter("id");
			String nome = request.getParameter("nome");
			String email = request.getParameter("email");
			String senha = request.getParameter("senha");
			
			ModelUsuario modelUsuario = new ModelUsuario();
			
			modelUsuario.setId(id != null && !id.isEmpty() ? Long.parseLong(id) : null);
			modelUsuario.setNome(nome);
			modelUsuario.setEmail(email);
			modelUsuario.setSenha(senha);
			
			if (daoUsuarioRepository.validarLogin(modelUsuario.getEmail()) && modelUsuario.getId() == null) {
				msg = "Já existe usuário com o mesmo login, informe outro.";
				
			}else {
				if (modelUsuario.isNovo()) {
					msg = "Usuário cadastrado com sucesso!";
				}else {
					msg = "Usuário atualizado com sucesso!";
				}
				
				modelUsuario = daoUsuarioRepository.gravarUsuario(modelUsuario);
			}
			
			List<ModelUsuario> modelUsuarios = daoUsuarioRepository.consultaUsuarioList();
			request.setAttribute("modelUsuarios", modelUsuarios);
			
			request.setAttribute("msg", msg);
			RequestDispatcher redireciona = request.getRequestDispatcher("principal/cadastroUsuario.jsp");
			request.setAttribute("modelUsuario", modelUsuario);
			redireciona.forward(request, response);
		
		}catch (Exception e) {
			e.printStackTrace();
			RequestDispatcher redirecionar = request.getRequestDispatcher("error.jsp");
			request.setAttribute("msgError", e.getMessage());
			redirecionar.forward(request, response);
		}
			
	}

}
