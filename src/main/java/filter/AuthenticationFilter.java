package filter;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import connection.SingleConnection;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;


@WebFilter(urlPatterns = {"/principal/*"})/* Intercepta todas as requisições do projeto ou mapeamento */
public class AuthenticationFilter implements Filter {

	private static Connection connection;
	
    public AuthenticationFilter() {

    }
    
    /* Encerra o processo quando o servidor é parado */
    /* Mata os processos de conexão com o banco */
	public void destroy() {
		try {
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/* Intercepta as requisições e as respostas no sistema */
	/* Tudo que fizer no sistema vai passar por aqui */
	/* Validação d autenticação, commit ou rolback de transações do banco, validar e fazer redirecionamento de paginas */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		try {
		
			HttpServletRequest req = (HttpServletRequest) request;
			HttpSession session = req.getSession();
			
			String usuarioLogado = (String) session.getAttribute("usuario");
			
			String urlParaAutenticar = req.getServletPath();/* URL que esta sendo acessada */
			
			/* Validar se esta logado senão redireciona para tela de login */
			if (usuarioLogado == null && /* Verifica se o usuario esta logado e se ele existe na base de dados */
					 !urlParaAutenticar.equalsIgnoreCase("/principal/ServletLogin")) { /* Verifica se o usuario esta tentando acessar uma pagina diferente da ServletLogin */
				
				RequestDispatcher redireciona = request.getRequestDispatcher("/index.jsp?url=" + urlParaAutenticar);
				request.setAttribute("msg", "Por favor realize o login!");
				redireciona.forward(request, response);
				return; /* Para a execução e redireciona para o login */
			
			} else {
				chain.doFilter(request, response);
			}
			
			connection.commit(); /* Deu tudo certo, então comita as alterações no banco de dados. */
		
		}catch (Exception e) {
			e.printStackTrace();
			try {
				connection.rollback();
			} catch (SQLException c) {
				c.printStackTrace();
			}
		}
	}
	
	
	/* Inicia os processos ou recursos quando o servidor sobe o projeto */
	/* Inicia a conexão com o banco */
	public void init(FilterConfig fConfig) throws ServletException {
		connection = SingleConnection.getConnection();
	}

}



