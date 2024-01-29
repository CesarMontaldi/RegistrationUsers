package servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelUsuario;

import java.io.IOException;

import dao.DAOUsuarioRepository;


@WebServlet("/ServletUsuarioController")
public class ServletUsuarioController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private DAOUsuarioRepository daoUsuarioRepository = new DAOUsuarioRepository();
 
    public ServletUsuarioController() {

    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			String id = request.getParameter("id");
			String nome = request.getParameter("nome");
			String email = request.getParameter("email");
			String senha = request.getParameter("senha");
			
			ModelUsuario modelUsuario = new ModelUsuario();
			
			modelUsuario.setId(id != null && !id.isEmpty() ? Long.parseLong(id) : null);
			modelUsuario.setNome(nome);
			modelUsuario.setEmail(email);
			modelUsuario.setSenha(senha);
			
			modelUsuario = daoUsuarioRepository.gravarUsuario(modelUsuario);
			
			request.setAttribute("msg", "Operação realizada com sucesso!");
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
