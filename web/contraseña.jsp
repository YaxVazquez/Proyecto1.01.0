<%-- 
    Document   : contraseña
    Created on : 27/11/2016, 09:21:34 AM
    Author     : Yax
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.io.*"%>
<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!--> 
<html class="no-js" lang=""> <!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title>Cambiar contraseña - Dogs & Co</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" type="image/x-icon" href="img/holi.ico" />

        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/bootstrap-theme.min.css">
        <link rel="stylesheet" href="css/iconos.css">
        <link rel="stylesheet" href="css/menu.css">

        <script src="js/vendor/modernizr-2.8.3.min.js"></script>
                <script type="text/javascript">
        <!--
        function contra(e){
            var x = e.which || e.keyCode;
            if((x>=97 && x<=122) || (x>=65 && x<=90) || (x===8|| x ===224 || x ===232|| x===236|| x===242||x===249||x===241) || (x>=48&&x<=57)||(x===8))
                return true;
            else
                return false;
        }
            function validar(contra, repeticion){
                var contraa = contra.value;
                var repetirr = repeticion.value;
                    if(contraa!==repetirr){
                        document.getElementById("con").style.visibility="visible";
                        contra.focus();
                        return false;
                }
                else
                    document.getElementById("texti").style.visibility='hidden';
            }
        -->
        </script>
    </head>
    <body>
        <!--[if lt IE 8]>
            <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
        <![endif]-->
         <%
          HttpSession sesion = request.getSession();
          if(sesion.getAttribute("user") == null){
              String e="Inicia sesion o registrate";
              response.sendRedirect("upsy.html?e="+e+"");
          }
                      String emails = (String)sesion.getAttribute("user");

                            Connection c = null;
                            Statement s = null;
                            ResultSet r = null;
                            PreparedStatement ps = null;

                            try {
                                Class.forName("com.mysql.jdbc.Driver").newInstance();
                                c = DriverManager.getConnection("jdbc:mysql://localhost/doggos","root","n0m3l0");
                                s = c.createStatement();
                            }
                            catch (SQLException error){
                                out.print(error.toString());
                            }

                            try {
                               r = s.executeQuery("select * from Usuario where Correo ='"+ emails +"';");
                               if (r.next()){
                                    String NameUs = r.getString("NombreUsuario");
                                 %>
         <nav class="navbar coloritoxx">
          <div class="container-fluid">
              
            <div class="navbar-header">
              <button class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                <span class="icon-bar hm-icon"></span>
                <span class="icon-bar hm-icon"></span>
                <span class="icon-bar hm-icon"></span>
              </button>
              <a href="PaginaPrincipal.jsp" class="navbar-brand hm-lkbb"><span class="icon icon-paw"> </span>Dogs & Co.</a>
            </div>
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right enlaces3">
                <li><a href="perfil.jsp"> <span class='glyphicon glyphicon-user'></span> <% 
                    out.println(NameUs); 
                   %> </a></li>
                <li> 
                    <a href="" data-toggle="modal" data-target="#filtross"><span class='glyphicon glyphicon-search' ></span> Busca tu perro ideal &nbsp;</a>        
                </li>
                <li> <form action="buscarcentro.jsp" method="post" class="navbar-form navbar-left"> 
                        <div class="input-group">
                            <input type="text" class="form-control campo" id="center" name="center" placeholder="Buscar centros" autocomplete="off" required>
                            <span class="input-group-btn culbtn">
                                <input type="submit" class="btn" value="Buscar" id="Buscar" name="Buscar">
                            </span>
                        </div>
                </form> </li>
              <li class="dropdown">
                  <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="glyphicon glyphicon-cog"></span>Configuracion</a>
                  <ul class="dropdown-menu enlaces2">
                      <li><a href="modificar.jsp">Modificar perfil</a></li>
                      <li><a href="contraseña.jsp">Cambiar contraseña</a></li>
                      <li class="divider"></li>
                      <li><a href="salir.jsp">Salir</a></li>
                  </ul>
              </li>
            </ul>
            </div>  
          </div>
        </nav>
         
        <div class="container centrado">
            <form action="contraseña.jsp" class="form-horizontal" method="post">
                  <div>
                    <h3>Cambiar contraseña</h3>
                  </div>
                  <div class="datox"> 
                      <div id='skambios' class='snc'>
                          Tienes que usar una contraseña diferente*
                      </div>
                      <div id='conuu' class='snc'>
                          Las contraseña anterior es incorrecta*
                      </div>
                      <div class="form-group">
                        <label for="Contraseña" class="col-xs-12 col-sm-12 col-md-2 col-md-offset-3 col-lg-2 col-lg-offset-3 control-label">Contraseña antigua</label>
                        <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
                          <input type="password" class="form-control" name="contraxVieja" id="contraxVieja" placeholder="Contraseña antigua" autocomplete='off' onkeypress='return contra(event)' title="Utiliza solo letras, numeros y - _. Más de 4 caracteres, menos de  20" pattern="[a-zA-Z0-9-_ ]{4,20}" required>
                        </div>
                      </div>
                      <div class="form-group">
                        <label for="Contraseña" class="col-xs-12 col-sm-12 col-md-2 col-md-offset-3 col-lg-2 col-lg-offset-3 control-label">Contraseña nueva</label>
                        <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
                          <input type="password" class="form-control" name="contrax" id="contrax" placeholder="Contraseña nueva" autocomplete='off' onkeypress='return contra(event)' title="Utiliza solo letras, numeros y - _. Más de 4 caracteres, menos de  20" pattern="[a-zA-Z0-9-_ ]{4,20}" required>
                        </div>
                      </div>
                    <div class="form-group">
                        <label for="Repetir" class="col-xs-12 col-sm-12 col-md-2 col-md-offset-3 col-lg-2 col-lg-offset-3 control-label">Confirmar nueva</label>
                        <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
                          <input type="password" class="form-control" name="conf" id="conf" placeholder="Confirmar contraseña nueva" autocomplete='off' pattern="[a-zA-Z0-9-_ ]{4,20}" required>
                        </div>
                    </div>
                    <div id='con' class='snc'>
                        Las contraseñas no coinciden*
                    </div>
                 </div>
                 <div>
                     <br> 
                    <input type='submit' name='cambios' id='cambios' class='btn culbtn2' value='Cambiar!' onClick='return validar(contrax, conf);'>
                 </div>
                </form>
            <br>
                <a href="PaginaPrincipal.jsp"> <button class="btn noculbtn"><span class='glyphicon glyphicon-trash'></span>Cancelar</button> </a>
            </div>
        <%       
                               }
                            }
                            catch (SQLException error){
                                out.print(error.toString());
                            }
        if(request.getParameter("cambios") != null){

            try{
                r = s.executeQuery("select * from Usuario where Correo='"+emails+"';");
                if(r.next()){
                    String idd = request.getParameter("contraxVieja");
                    String con = r.getString("Contraseña"); //parametro de la base
                    String coni = request.getParameter("contrax");
                    String conN = request.getParameter("conf");
                    
                    if(idd.equals(con)){
                                out.println("<script> document.getElementById('conuu').style.visibility='hidden';</script>");
                                if(con.equals(coni)){
                                    out.println("<script> document.getElementById('skambios').style.visibility='visible';</script>");
                                }
                                else{
                                 String queryString="update Usuario set Contraseña ='"+conN+"' where Correo= '"+emails+"' ;";
                                 ps=c.prepareStatement(queryString);
                                 ps.executeUpdate();
                                 out.println("<script> document.getElementById('skambios').style.visibility='hidden';</script>");
                                    out.println("<meta http-equiv='refresh' content='.0000001;URL=http://localhost:8080/Proyecto1.0/PaginaPrincipal.jsp'/>");
                                }
                       }
                       else {
                           out.println("<script> document.getElementById('conuu').style.visibility='visible';</script>");
                       }
                    
                }
            }
                catch (SQLException error){
                            out.print(error.toString());
                }
            }
          
                    %>
                    
                    <div class="modal fade centrado" id ="filtross">    
              <div class="modal-dialog modal-lg">
                <div class="modal-content">
                  <form action="ListaPerros.jsp" class="form-horizontal" method="post">
                  <div class="modal-header colors">
                    <button class="close" aria-hidden="true" data-dismiss="modal">&times;</button>
                    <h3 class="modal-title"><span class="glyphicon glyphicon-filter"></span>Filtros de búsqueda</h3>
                  </div>
                  <div class="modal-body">
                      <div class="form-group">
                        <div class="col-xs-6 col-sm-6 col-md-4 col-lg-4 col-lg-offset-1">
                            <span class="glyphicon glyphicon-leaf"></span> Hembra
                            <input type ="radio" name="sex" value="Hembra" checked>
                        </div>
                        <div class="col-xs-6 col-sm-6 col-md-4 col-lg-4"> 
                            <span class="glyphicon glyphicon-fire"></span> Macho
                            <input type ="radio" name="sex" value="Macho"> 
                        </div>
                     </div>
                      <div class="form-group">
                        <label for="Edad" class="col-xs-8 col-xs-offset-2 col-sm-8 col-sm-offset-2 col-md-1 col-lg-1 col-lg-offset-2">Edad</label>
                        <select name="edad" class="col-xs-8 col-xs-offset-2 col-sm-8  col-sm-offset-2 col-md-4 col-lg-4">
                            <option value="Cachorro">Cachorro</option>
                            <option value="Adulto">Adulto</option>
                        </select>
                      </div>
                      <div class="form-group">
                        <label for="Tamaño" class="col-xs-8 col-xs-offset-2 col-sm-8 col-sm-offset-2 col-md-1 col-lg-1 col-lg-offset-2">Tamaño</label>
                        <select name="tamano" class="col-xs-8 col-xs-offset-2 col-sm-8 col-sm-offset-2 col-md-4 col-lg-4">
                            <option value="Chico">Raza chica</option>
                            <option value="Mediano">Raza mediana</option>
                            <option value="Grande">Raza grande</option>
                        </select>
                      </div>
                      <div class="form-group">
                         <label for="colors" class="col-xs-8 col-xs-offset-2 col-sm-8  col-sm-offset-2 col-md-1 col-lg-1 col-lg-offset-2">Color</label> 
                            <div> 
                                 <label for="colorb" class="col-xs-6 col-xs-offset-1 col-sm-6 col-sm-offset-1 col-md-1 col-lg-1 col-lg-offset-1">Blanco</label>
                                <input type ="checkbox" name="color" value="Blanco" class="col-xs-3 col-sm-3 col-md-1 col-lg-1 col-lg-offset-1"> 
                            </div> 
                            <div>
                                 <label for="colorn" class="col-xs-6 col-xs-offset-1 col-sm-6 col-sm-offset-1 col-md-1 col-lg-1 col-lg-offset-1">Negro</label>
                                <input type ="checkbox" name="color" value="Negro" class="col-xs-3 col-sm-3 col-md-1 col-lg-1 col-lg-offset-1">
                            </div> 
                      </div>
                       <div class="form-group">  
                           <label for="colors" class="col-xs-0 col-sm-1 col-sm-offset-2 col-md-1 col-lg-1 col-lg-offset-2"> &nbsp; </label> 
                            <div>
                                 <label for="colorc" class="col-xs-6 col-xs-offset-1 col-sm-6 col-sm-offset-1 col-md-1 col-lg-1 col-lg-offset-1">Café</label>
                                <input type ="checkbox" name="color" value="Café" class="col-xs-3 col-sm-3 col-md-1 col-lg-1 col-lg-offset-1">
                            </div> 
                            <div>
                                 <label for="colorm" class="col-xs-6 col-xs-offset-1 col-sm-6 col-sm-offset-1 col-md-1 col-lg-1 col-lg-offset-1">Mixto</label>
                                <input type ="checkbox" name="color" value="Otro" class="col-xs-3 col-sm-3 col-md-1 col-lg-1 col-lg-offset-1">
                            </div> 
                       </div>   
                      <p> O si lo prefieres también encuentra <a href="CentroPerros.jsp"> perros por centros </a> </p> 
                  </div>
                 <div class="modal-footer">
                    <input type='submit' name='busk' id='busk' class='btn culbtn2' value='Encuentra!'s>
                    <button class="btn noculbtn" data-dismiss="modal"> Cancelar </button>
                  </div>
                </form>
                </div>
              </div>
            </div>
        <script>window.jQuery || document.write('<script src="js/vendor/jquery-1.11.2.min.js"><\/script>')</script>
        <script src="js/vendor/bootstrap.min.js"></script>
        <script src="js/main.js"></script>
    </body>
</html>