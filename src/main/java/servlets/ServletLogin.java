package servlets;

import java.io.IOException;

import dao.DAOUsuarioRepository;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelUsuario;

/* O chamado Controller são as servlets */
@WebServlet(urlPatterns = {"/principal/ServletLogin", "/ServletLogin"})/* Mapeamento de URL que vem da tela. */
public class ServletLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private DAOUsuarioRepository daoUsuarioRepository = new DAOUsuarioRepository();
  
    public ServletLogin() {

    }

    /* Recebe os dados pela URL em parametros */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String acao = request.getParameter("acao");
		
		if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("logout")) {
		
			request.getSession().invalidate(); /* invalida a sessão */
			RequestDispatcher redirecionar = request.getRequestDispatcher("index.jsp");
			redirecionar.forward(request, response);

		} else {
			doPost(request, response);
		}
	}

	/* Recebe os dados enviados por um formulario */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
		String senha = request.getParameter("senha");
		String url = request.getParameter("url");
		
		
		try {
				if (email != null && !email.isEmpty() && senha != null && !senha.isEmpty()) {
				
					ModelUsuario modelUsuario = new ModelUsuario();
					modelUsuario.setEmail(email);
					modelUsuario.setSenha(senha);
					
					ModelUsuario user = daoUsuarioRepository.consultaUsuario(email);
					
					if (daoUsuarioRepository.validarAutenticacao(modelUsuario)) {/* Simulando login */
	
						request.getSession().setAttribute("usuario", user.getNome()); /* Coloca o usuario na sessão para manter ele logado */
						
						/* Verifica se o usuario esta tentando acessar alguma pagina do sistema, senão redireciona ele para pagina inicial do sistema */
						if (url == null || url.equals("null")) {
							url = "principal/principal.jsp"; 
						}
						
						RequestDispatcher redirecionar = request.getRequestDispatcher(url);
						redirecionar.forward(request, response);
						
					} else {
						RequestDispatcher redirecionar = request.getRequestDispatcher("/index.jsp");
						request.setAttribute("msg", "Informe o login e senha corretamente!");
						redirecionar.forward(request, response);
					}
						
				}else {
					RequestDispatcher redirecionar = request.getRequestDispatcher("/index.jsp");
					request.setAttribute("msg", "Informe o login e senha corretamente!");
					redirecionar.forward(request, response);
				} 
				
		}catch (Exception e) {
			e.printStackTrace();
			RequestDispatcher redirecionar = request.getRequestDispatcher("error.jsp");
			request.setAttribute("msgError", e.getMessage());
			redirecionar.forward(request, response);
			}
		

	}
	

}
