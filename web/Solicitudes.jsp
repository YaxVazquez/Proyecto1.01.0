<%-- 
    Document   : Solicitudes
    Created on : 17-may-2017, 4:14:15
    Author     : Usuario
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.io.*"%>
<%@page import="classes.ProductosSoli"%>
<%@page import="classes.Solicitud"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<!doctype html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang=""> <!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1" />
        <title>Solicitudes de adopcion - Dogs&CoCentros</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" type="image/x-icon" href="img/holi.ico" />

        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/bootstrap-theme.min.css">
        <link rel="stylesheet" href="css/estilos1.css">
        <link rel="stylesheet" href="css/iconos.css">
        <link href="css/cese.css" rel="stylesheet">

        <script src="js/vendor/modernizr-2.8.3.min.js"></script>
        
            </head>
    <body>
        <!--[if lt IE 8]>
            <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
        <![endif]-->
           <nav class="navbar colos">
          <div class="container-fluid" >
            <div class="navbar-header" >
              <button class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
              </button>
               <p class="navbar-brand hm-lkpa"><span class="icon icon-paw"> </span> Centros Dogs & Co.</p>
            </div>
            
            <div class="collapse navbar-collapse colo" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right enlaces">
               <li><a href="PerfilCentro.jsp">Perfil Centro</a></li>
              <li><a href="DogsCentro.jsp">Perros</a></li>
              <li><a href="SalirP.jsp">Cerrar Sesión</a></li>
            </ul>
              
            </div>
            </div>
</nav>
        <div class="container hi"> <h1 > Solicitudes de adopción </h1> </div>
            <% 
             HttpSession sesion = request.getSession();
          if(sesion.getAttribute("userCentro") == null){
              String e="Inicia sesion o registrate";
              response.sendRedirect("indexP.jsp?e="+e+"");
          }
          else{
           Connection con=null;
                Statement s = null;
                PreparedStatement pstatement=null;
                ResultSet r = null;
                ResultSet x = null;
                 String usuario = (String)sesion.getAttribute("userCentro");
                try {
                    Class.forName("com.mysql.jdbc.Driver").newInstance();
                    con = DriverManager.getConnection("jdbc:mysql://localhost/doggos","root","n0m3l0");
                    s = con.createStatement();
                }
                catch (SQLException error){
                    out.print(error.toString());
                }
        
            }
            %>
            <div style="text-align: center;">
            <% 
                Connection c = null;
                ResultSet r = null;
                Statement s = null;
                 try {
                                Class.forName("com.mysql.jdbc.Driver").newInstance();
                                c = DriverManager.getConnection("jdbc:mysql://localhost/doggos","root","n0m3l0");
                                s = c.createStatement();
                            }
                            catch (SQLException error){
                                out.print(error.toString());
                            }
             r = s.executeQuery("select count(*) from solicitudadopcion where idCentro="+sesion.getAttribute("idCen")+";");
              r.next();
             int nSol=Integer.parseInt(r.getString("count(*)"));
              if(nSol==0){
              out.println("<h3>No tienes solicitudes de adopción</h3>");
                      }
              else 
                  if(nSol==1){
              out.println("<h3>Tienes una solicitud de adopción</h3>");
              }
              else
                  if(nSol<1){
              out.println("<h3>Tienes "+nSol+" solicitudes de adopción</h3>");
                  }
             %>
               <% 
               Solicitud p = new Solicitud();
       
       String idCentr=(String)sesion.getAttribute("idCen");
        p.setId(idCentr);
    ArrayList<ProductosSoli> k = (ArrayList)p.BuscarTodos();
    ArrayList<String> nperros = new ArrayList<String>();
     %>          
    
 
         
         
          <div class="container" style="margin-top: 20px;">
                                                  
    <%for (int i = 0; i < k.size(); i++) {%>
     
        <div class="col-xs-12 col-sm-6 col-md-6">
               <div class="well well-sm">
                <div class="row">
                    
                    <div class="col-sm-6 col-md-8">
                        
                        <h4>Solicitud</h4> 
                        <% nperros.add(i,k.get(i).getIdProductos() );%>
                        <% String nombre=nperros.get(i); %>
                        
                                                <p>
                            Nombre del solicitante: 
                            <%
                                String idSol=k.get(i).getUsuario();
                          r = s.executeQuery("select * from usuario where idUsuario="+idSol+";");
                            r.next();
                            String nomS=r.getString("nombre");
                            String apeS=r.getString("apellido");
                            out.println(nomS+" "+apeS+"<br>");
                            r = s.executeQuery("select * from perro where idPerro="+k.get(i).getPerro()+";");
                            r.next();
                            String nombreP=r.getString("Nombre");
                            out.println("Nombre del perro: <strong>"+nombreP+"</strong><br>");
                            out.println("¿Su casa es propia o rentada? <strong>"+k.get(i).getCasa()+"</strong><br>");
                            out.println("¿Eres mayor de edad? <strong>"+k.get(i).getEdad()+"</strong><br>");
                            out.println("¿Tiene experiencia con otros perros? <strong>"+k.get(i).getExperiencia()+"</strong><br>");
                            out.println("¿Tiene otras mascotas? <strong>"+k.get(i).getMascotas()+"</strong><br>");
                            out.println("¿El perro es para ti, para la familia o para un regalo? <strong>"+k.get(i).getFinalidad()+"</strong><br>");
                            out.println("En caso de que el perro sea para la familia. ¿Todos estan informados y de acuerdo con esto? <strong>"+k.get(i).getFamilia()+"</strong><br>");
                            out.println("¿Quién sería el responsable economicamente? <strong>"+k.get(i).getResponsable()+"</strong><br>");
                            out.println("¿Puedes dedicarle el tiempo necesario? <strong>"+k.get(i).getTiempo()+"</strong><br>");
                            out.println("¿En que parte de la casa viviría? <strong>"+k.get(i).getLugar()+"</strong><br>");
                            out.println("¿Por que quieres adoptar? <strong>"+k.get(i).getXq()+"</strong><br>");
                            out.println("¿Estarías dispuesto a recibir visitas del centro para asegurar el bienestar del perro? <strong>"+k.get(i).getVisitas()+"</strong><br>");
                            out.println("¿Harías algún tipo de donativo al centro? <strong>"+k.get(i).getDonativo()+"</strong><br>");
                            %>
                            <br />
                           
                                                </p>
                        <!-- Split button -->
                        <div class="btn-group">
                            
                            <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                                Descripción<span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu" role="menu">
                                <li></li>
                            </ul>
                        </div>
                        <div class="btn-group"> 
                            <form action='formato.jsp' method='post'>
                                 
                            </form>
                        </div>
                </div>
            </div>
       </div>
    </div>
         <% }%>
        
         
             </div>
        
            </div>
        <script>window.jQuery || document.write('<script src="js/vendor/jquery-1.11.2.min.js"><\/script>')</script>

        <script src="js/vendor/bootstrap.min.js"></script>

        <script src="js/main.js"></script>
    </body>
</html>
