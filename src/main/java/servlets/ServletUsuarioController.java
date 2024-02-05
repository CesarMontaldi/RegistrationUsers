package servlets;

import java.io.IOException;
import java.util.List;


import org.apache.tomcat.jakartaee.commons.compress.utils.IOUtils;
import org.apache.tomcat.util.codec.binary.Base64;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.fasterxml.jackson.databind.ObjectMapper;

import dao.DAOUsuarioRepository;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.ModelUsuario;



@MultipartConfig
@WebServlet("/ServletUsuarioController")
public class ServletUsuarioController extends ServletGenericUtil {
	private static final long serialVersionUID = 1L;
	
	private DAOUsuarioRepository daoUsuarioRepository = new DAOUsuarioRepository();
 
    public ServletUsuarioController() {

    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			String acao = request.getParameter("acao");
			
			if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("deletar")) { /* deletando usuário */
				String idUser = request.getParameter("id");
				
				daoUsuarioRepository.deletarUser(idUser);
				
				List<ModelUsuario> modelUsuarios = daoUsuarioRepository.consultaUsuarioList(super.getUserLogado(request));
				request.setAttribute("modelUsuarios", modelUsuarios);
				
				request.setAttribute("msg", "Excluido com sucesso!");
				request.setAttribute("totalPagina", daoUsuarioRepository.totalPaginas(this.getUserLogado(request)));
				
				RequestDispatcher redireciona = request.getRequestDispatcher("principal/cadastroUsuario.jsp");
				redireciona.forward(request, response);
				
			}
			else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("deletarAjax")) { /* deletando usuário com Ajax */
				String idUser = request.getParameter("id");
				
				daoUsuarioRepository.deletarUser(idUser);
				
				response.getWriter().write("Excluido com sucesso!");

			}
			else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("buscarUserAjax")) { /* buscando usuário com Ajax */
				String nomeBusca = request.getParameter("nomeBusca");
				
				List<ModelUsuario> dadosJsonUser = daoUsuarioRepository.consultaUsuarioList(nomeBusca, super.getUserLogado(request));
				
				ObjectMapper mapper = new ObjectMapper();
				
				String json = mapper.writeValueAsString(dadosJsonUser);
				
				response.addHeader("totalPagina", "" + daoUsuarioRepository.consultaUsuarioListTotalPaginacao(nomeBusca, super.getUserLogado(request)));
				response.getWriter().write(json);
				
			}
			else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("buscarUserAjaxPage")) { /* buscando usuário com Ajax */
				String nomeBusca = request.getParameter("nomeBusca");
				String pagina = request.getParameter("pagina");
				
				List<ModelUsuario> dadosJsonUser = daoUsuarioRepository.consultaUsuarioListOffSet(nomeBusca, super.getUserLogado(request), Integer.parseInt(pagina));
				
				ObjectMapper mapper = new ObjectMapper();
				
				String json = mapper.writeValueAsString(dadosJsonUser);
				
				response.addHeader("totalPagina", "" + daoUsuarioRepository.consultaUsuarioListTotalPaginacao(nomeBusca, super.getUserLogado(request)));
				response.getWriter().write(json);
				
			}
			
			else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("buscarEditar")) { /* buscando usuário para editar */
				String id = request.getParameter("id");
				
				ModelUsuario user = daoUsuarioRepository.consultaUsuarioId(id, super.getUserLogado(request));
				
				List<ModelUsuario> modelUsuarios = daoUsuarioRepository.consultaUsuarioList(super.getUserLogado(request));
				request.setAttribute("modelUsuarios", modelUsuarios);
				
				request.setAttribute("msg", "Usuário em edição");
				request.setAttribute("totalPagina", daoUsuarioRepository.totalPaginas(this.getUserLogado(request)));
				
				RequestDispatcher redireciona = request.getRequestDispatcher("principal/cadastroUsuario.jsp");
				request.setAttribute("modelUsuario", user);
				redireciona.forward(request, response);
				
			}
			else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("listarUser")) { /* buscando todos usuário */
				
				List<ModelUsuario> modelUsuarios = daoUsuarioRepository.consultaUsuarioList(super.getUserLogado(request));

				
				request.setAttribute("msg", "Usuários carregados");
				request.setAttribute("modelUsuarios", modelUsuarios);
				request.setAttribute("totalPagina", daoUsuarioRepository.totalPaginas(this.getUserLogado(request)));
				
				request.getRequestDispatcher("principal/cadastroUsuario.jsp").forward(request, response);
				
			}
			else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("downloadFoto")) { /* Fazer Download de foto, arquivos */
				
				String id = request.getParameter("id");
				
				ModelUsuario user = daoUsuarioRepository.consultaUsuarioId(id, super.getUserLogado(request));
				if (user.getFotouser() != null && !user.getFotouser().isEmpty()) {
					
					response.setHeader("Content-Disposition", "attachment;filename=arquivo." + user.getExtensaofotouser());
					response.getOutputStream().write(new Base64().decodeBase64(user.getFotouser().split("\\,")[1]));
				}
			}
			
			else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("paginar")) { /* Fazer Download de foto, arquivos */
				
				Integer offset = Integer.parseInt(request.getParameter("pagina"));
				
				List<ModelUsuario> modelUsuarios = daoUsuarioRepository.consultaUsuarioListPaginada(super.getUserLogado(request), offset);
				request.setAttribute("modelUsuarios", modelUsuarios);
				
				request.setAttribute("totalPagina", daoUsuarioRepository.totalPaginas(this.getUserLogado(request)));
				request.getRequestDispatcher("principal/cadastroUsuario.jsp").forward(request, response);
			}
			
			else {
				List<ModelUsuario> modelUsuarios = daoUsuarioRepository.consultaUsuarioList(super.getUserLogado(request));
				request.setAttribute("modelUsuarios", modelUsuarios);
				
				request.setAttribute("totalPagina", daoUsuarioRepository.totalPaginas(this.getUserLogado(request)));
				request.getRequestDispatcher("principal/cadastroUsuario.jsp").forward(request, response);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			RequestDispatcher redirecionar = request.getRequestDispatcher("error.jsp");
			request.setAttribute("msgError", e.getMessage());
			redirecionar.forward(request, response);
		}
		
		

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try { /* Salva ou atualiza usuário */
			
			String msg = "Operação realizada com sucesso!";
			
			String id = request.getParameter("id");
			String nome = request.getParameter("nome");
			String email = request.getParameter("email");
			String senha = request.getParameter("senha");
			String perfil = request.getParameter("perfil");
			String sexo = request.getParameter("sexo");
			
			String cep = request.getParameter("cep");
			String logradouro = request.getParameter("logradouro");
			String bairro = request.getParameter("bairro");
			String cidade = request.getParameter("cidade");
			String uf = request.getParameter("uf");
			String numero = request.getParameter("numero");
			
			ModelUsuario modelUsuario = new ModelUsuario();
			
			modelUsuario.setId(id != null && !id.isEmpty() ? Long.parseLong(id) : null);
			modelUsuario.setNome(nome);
			modelUsuario.setEmail(email);
			modelUsuario.setSenha(senha);
			modelUsuario.setPerfil(perfil);
			modelUsuario.setSexo(sexo);
			
			modelUsuario.setCep(cep);
			modelUsuario.setLogradouro(logradouro);
			modelUsuario.setBairro(bairro);
			modelUsuario.setCidade(cidade);
			modelUsuario.setUf(uf);
			modelUsuario.setNumero(numero);
			
			if (ServletFileUpload.isMultipartContent(request)) {
				
				Part part = request.getPart("fileFoto"); /* Pega a foto da tela. */
				
				if (part.getSize() > 0) {
					
					byte[] foto = IOUtils.toByteArray(part.getInputStream()); /* Converte a imagem para Byte */
					String imagemBase64 = "data:/image" + part.getContentType().split("\\/")[1] + ";base64," + new Base64().encodeBase64String(foto);
					
					modelUsuario.setFotouser(imagemBase64); /* seta a foto */
					modelUsuario.setExtensaofotouser(part.getContentType().split("\\/")[1]); /* seta a extensão da foto */
				}
				
				
			}
			
			
			if (daoUsuarioRepository.validarLogin(modelUsuario.getEmail()) && modelUsuario.getId() == null) {
				msg = "Já existe usuário com o mesmo login, informe outro.";
				
			}else {
				if (modelUsuario.isNovo()) {
					msg = "Usuário cadastrado com sucesso!";
				}else {
					msg = "Usuário atualizado com sucesso!";
				}
				
				modelUsuario = daoUsuarioRepository.gravarUsuario(modelUsuario, super.getUserLogado(request));
			} 
			
			List<ModelUsuario> modelUsuarios = daoUsuarioRepository.consultaUsuarioList(super.getUserLogado(request));
			request.setAttribute("modelUsuarios", modelUsuarios);
			
			request.setAttribute("msg", msg);
			request.setAttribute("totalPagina", daoUsuarioRepository.totalPaginas(this.getUserLogado(request)));
			
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
