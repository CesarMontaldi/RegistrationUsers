package servlets;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
 
import org.apache.commons.compress.utils.IOUtils;
import org.apache.tomcat.util.codec.binary.Base64;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.fasterxml.jackson.databind.ObjectMapper;

import beandto.DTOGraficoSalarioUser;
import dao.DAOTelefoneRepository;
import dao.DAOUsuarioRepository;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.ModelTelefone;
import model.ModelUsuario;
import util.ReportUtil;



@MultipartConfig
@WebServlet("/ServletUsuarioController")
public class ServletUsuarioController extends ServletGenericUtil {
	private static final long serialVersionUID = 1L;
	
	private DAOUsuarioRepository daoUsuarioRepository = new DAOUsuarioRepository();
	
	private DAOTelefoneRepository daoTelefoneRepository = new DAOTelefoneRepository();
 
    public ServletUsuarioController() {

    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			String acao = request.getParameter("acao");
			
			if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("deletar")) { /* deletando usuário */
				String idUser = request.getParameter("id");
				
				daoUsuarioRepository.deletarUser(idUser);
			 
				request.setAttribute("msg", "Excluido com sucesso!");
				
				RequestDispatcher redireciona = request.getRequestDispatcher("principal/profile.jsp");
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
				
				ModelUsuario user = daoUsuarioRepository.consultaUsuarioId(Long.parseLong(id));
				ModelTelefone fone = daoTelefoneRepository.consultaFone(Long.parseLong(id));
				
				request.setAttribute("msg", "Usuário em edição");
				request.setAttribute("totalPagina", daoUsuarioRepository.totalPaginas(this.getUserLogado(request)));
				
				
				request.setAttribute("user", user);
				request.setAttribute("foneuser", fone.getNumero());
				RequestDispatcher redireciona = request.getRequestDispatcher("principal/cadastroUsuario.jsp");
				redireciona.forward(request, response);
				
			}
			else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("profileUser")) {
				String id = request.getParameter("id");
				
				ModelUsuario user = daoUsuarioRepository.consultaUsuarioID(Long.parseLong(id));
				
				
				request.setAttribute("msg", "Usuário em edição");
				request.setAttribute("modelUsuario", user);
				RequestDispatcher redireciona = request.getRequestDispatcher("principal/profile.jsp");
				redireciona.forward(request, response);
				
			}
			else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("listarUser")) { /* buscando todos usuário */
				
				List<ModelUsuario> modelUsuarios = daoUsuarioRepository.consultaUsuarioList(super.getUserLogado(request));
				request.setAttribute("modelUsuarios", modelUsuarios);
				request.setAttribute("msg", "Usuários carregados");
				
				ModelUsuario user = daoUsuarioRepository.consultaUsuarioId(super.getUserLogado(request));
				int paginaAtual = 1;
				
				
				request.setAttribute("pagina", paginaAtual);
				request.setAttribute("modelUsuario", user);
				request.setAttribute("totalPagina", daoUsuarioRepository.totalPaginas(this.getUserLogado(request)));
				request.getRequestDispatcher("principal/usuarios.jsp").forward(request, response);
				
			}
			else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("downloadFoto")) { /* Fazer Download de foto, arquivos */
				
				String id = request.getParameter("id");
				
				ModelUsuario user = daoUsuarioRepository.consultaUsuarioId(id, super.getUserLogado(request));
				if (user.getFotouser() != null && !user.getFotouser().isEmpty()) {
					
					response.setHeader("Content-Disposition", "attachment;filename=arquivo." + user.getExtensaofotouser());
					response.getOutputStream().write(new Base64().decodeBase64(user.getFotouser().split("\\,")[1]));
				}
			}
			
			else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("paginar")) { 
				
				int offset = 5;
				int paginaAtual = Integer.parseInt(request.getParameter("pagina"));
				String paginacao = request.getParameter("paginacao");	
				int totalPagina = daoUsuarioRepository.totalPaginas(this.getUserLogado(request));
				
				
				if (paginacao.equals("previous")) {
					paginaAtual --;
					offset = (offset * paginaAtual) - 5;
				}
				
				else if (paginacao.equals("next")) {
					offset *= paginaAtual;
					paginaAtual ++;
				}
				
				List<ModelUsuario> modelUsuarios = daoUsuarioRepository.consultaUsuarioListPaginada(super.getUserLogado(request), offset);
				request.setAttribute("modelUsuarios", modelUsuarios);

				
				request.setAttribute("pagina", paginaAtual);
				request.setAttribute("totalPagina", totalPagina);
				request.getRequestDispatcher("principal/usuarios.jsp").forward(request, response);
			}
			
			else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("imprimirRelatorioUser")) {
				
				String dataInicial = request.getParameter("dataInicial");
				String dataFinal = request.getParameter("dataFinal");
				
				//List<ModelUsuario> modelUsuarios = daoUsuarioRepository.consultaUsuariosRelatorio(super.getUserLogado(request));
				
				if (dataInicial == null || dataInicial.isEmpty() & dataFinal == null || dataFinal.isEmpty()) {
					request.setAttribute("listUsers", daoUsuarioRepository.consultaUsuariosRelatorio(super.getUserLogado(request)));
				}  
				else {
					
					request.setAttribute("listUsers", daoUsuarioRepository.consultaUsuariosRelatorioPorData(super.getUserLogado(request), dataInicial, dataFinal));
				}
				
				request.setAttribute("dataInicial", dataInicial);
				request.setAttribute("dataFinal", dataFinal);
				request.getRequestDispatcher("principal/userRelatorio.jsp").forward(request, response);
				
			}
			
			else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("imprimirRelatorioPdf") || acao.equalsIgnoreCase("imprimirRelatorioEcxel")) {
				
				String dataInicial = request.getParameter("dataInicial");
				String dataFinal = request.getParameter("dataFinal");
				
				List<ModelUsuario> modelUsuarios = null;
				
				if (dataInicial == null || dataInicial.isEmpty() & dataFinal == null || dataFinal.isEmpty()) {
					
					modelUsuarios = daoUsuarioRepository.consultaUsuariosRelatorio(super.getUserLogado(request));
				}
				else {
					modelUsuarios = daoUsuarioRepository.consultaUsuariosRelatorioPorData(super.getUserLogado(request), dataInicial, dataFinal);
					
				}
				
				HashMap<String, Object> params = new HashMap<String, Object>();
				params.put("PARAM_SUB_REPORT", request.getServletContext().getRealPath("relatorio") + File.separator);
				
				byte[] relatorio = null;
				String extensao = "";
				
				if (acao.equalsIgnoreCase("imprimirRelatorioPdf")) {
					relatorio = new ReportUtil().geraRelatorioPDF(modelUsuarios, "relatorio-user", params, request.getServletContext());
					extensao = "pdf";
				}
				
				if (acao.equalsIgnoreCase("imprimirRelatorioEcxel")) {
					relatorio = new ReportUtil().geraRelatorioExcel(modelUsuarios, "relatorio-user", params, request.getServletContext());
					extensao = "xls";
				}
				
				response.setHeader("Content-Disposition", "attachment;filename=arquivo." + extensao);
				response.getOutputStream().write(relatorio);
			}
			
			else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("graficoSalario")) {
				
				String dataInicial = request.getParameter("dataInicial");
				String dataFinal = request.getParameter("dataFinal");
				
				if (dataInicial == null || dataInicial.isEmpty() & dataFinal == null || dataFinal.isEmpty()) {
					
					DTOGraficoSalarioUser dtoGraficoSalarioUser = daoUsuarioRepository.montarGraficoMediaSalario(super.getUserLogado(request));
				
					ObjectMapper mapper = new ObjectMapper();
					
					String json = mapper.writeValueAsString(dtoGraficoSalarioUser);
					
					response.getWriter().write(json);
					
				}else {
					
					DTOGraficoSalarioUser dtoGraficoSalarioUser = daoUsuarioRepository.montarGraficoMediaSalarioPorData(super.getUserLogado(request), dataInicial, dataFinal);
					
					ObjectMapper mapper = new ObjectMapper();
					
					String json = mapper.writeValueAsString(dtoGraficoSalarioUser);
					
					response.getWriter().write(json);
					
				}
				
				
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
			
			String msg = "";
			
			String acao = request.getParameter("acao");
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
			
			String telefone = request.getParameter("telefone");
			String dataNascimento = request.getParameter("dataNascimento");
			String rendaMensal = request.getParameter("rendaMensal");
			
			rendaMensal = rendaMensal.split("\\ ")[1].replaceAll("\\.", "").replaceAll("\\,", ".");

			
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
			modelUsuario.setDataNascimento(Date.valueOf(new SimpleDateFormat("yyyy-mm-dd").format(new SimpleDateFormat("dd/mm/yyyy").parse(dataNascimento))));
			modelUsuario.setRendamensal(Double.valueOf(rendaMensal));

			
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
				
				modelUsuario = daoUsuarioRepository.gravarUsuario(modelUsuario, super.getUserLogado(request));
			} 
			
			modelUsuario = daoUsuarioRepository.consultaUsuario(email);
			
			/*if(daoTelefoneRepository.existeFone(telefone, modelUsuario.getId())) {
				
				request.setAttribute("foneuser", telefone);
			}*/
			
			if (!daoTelefoneRepository.existeFone(telefone, modelUsuario.getId())) {
				ModelTelefone modelTelefone = new ModelTelefone();
				
				modelTelefone.setNumero(telefone);
				modelTelefone.setUsuario_id(modelUsuario);
				modelTelefone.setUsuario_cad(super.getUserLogadoObj(request));
				
				modelTelefone = daoTelefoneRepository.gravaTelefone(modelTelefone);
				
				//request.setAttribute("foneuser", modelTelefone.getNumero());
			}
			
			 if (id != null && !id.isEmpty() && acao.equalsIgnoreCase("cadastrar") || acao == "atualizar") {
				
				 msg = "Usuário atualizado com sucesso!";
			 } 
			 else if (acao.equalsIgnoreCase("cadastrar")) {
				msg = "Usuário cadastrado com sucesso!";
			 }
			
			
			request.setAttribute("totalPagina", daoUsuarioRepository.totalPaginas(this.getUserLogado(request)));
			
			if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("cadastrar") || acao.equalsIgnoreCase("atualizarCadastro")) {
				
				request.setAttribute("msg", msg);
				request.setAttribute("user", modelUsuario);
				request.setAttribute("foneuser", telefone);
				
				RequestDispatcher redireciona = request.getRequestDispatcher("principal/cadastroUsuario.jsp");
				redireciona.forward(request, response);
			}
			
			else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("atualizar")) {
				
				request.setAttribute("msg", msg);
				request.setAttribute("modelUsuario", modelUsuario);
				request.setAttribute("foneuser", telefone);
				
				RequestDispatcher redireciona = request.getRequestDispatcher("principal/profile.jsp");
				redireciona.forward(request, response);
			}
		
		}catch (Exception e) {
			e.printStackTrace();
			RequestDispatcher redirecionar = request.getRequestDispatcher("error.jsp");
			request.setAttribute("msgError", e.getMessage());
			redirecionar.forward(request, response);
		}
			
	}

}
