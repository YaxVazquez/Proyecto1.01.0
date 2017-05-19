/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ws;

import java.sql.ResultSet;
import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;

/**
 *
 * @author chistopher
 */
@WebService(serviceName = "registro")
public class registro {

    /**
     * This is a sample web service operation
     */
    @WebMethod(operationName = "hello")
    public String hello(@WebParam(name = "name") String txt) {
        return "Hello " + txt + " !";
    }
    
     @WebMethod(operationName = "GuardaUsr")
    public String GuardaUsr(@WebParam(name = "nome") String nombre
            , @WebParam(name = "apell") String apellido
            , @WebParam(name = "user") String usuario
            , @WebParam(name = "email") String mail
            , @WebParam(name = "contrax") String contra){
        
        String resultado = "";
        
        BD.Conexion sql = new BD.Conexion();
        try
        {
            sql.conectar();
            ResultSet rsUsr = sql.consulta("select * from Usuario where Correo ='"+mail+"';");
            if(rsUsr.next()){
                ResultSet r2=sql.consulta("call addUser('"+0+"','"+0+"','"+usuario+"','"+nombre+"','"+apellido +"','"+contra+"', '"+mail+"','"+1+"')");

                                cl.cMail1 env= new cl.cMail1();
                                String receptor=mail;
                                String titulo="Verifica tu correo ahora!";
                                String enviar=":DDDDDDDDDDDDDDDDDDDDDDDDDD";
                                
                                try{
                                    env.mandaMAil(receptor, titulo, enviar);
                                }
                                catch(Exception e){
                                    e.getMessage();
                                }
                resultado="1"; 
            }
            else{
                resultado="0";
            }
           
        }
        catch(Exception xxxxD){
            resultado = xxxxD.getMessage();
        }
        
        
        return resultado;
    }
}
