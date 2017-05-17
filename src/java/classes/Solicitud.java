/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package classes;

/**
 *
 * @author ALDO ERNESTO
 */
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;




public class Solicitud {
    
    String idCentr;
    public void setId(String idCentr) {
        this.idCentr = idCentr;
    }

    public List<ProductosSoli> BuscarTodos() throws SQLException {
        
        String query = "select * from SolicitudAdopcion where idCentro="+idCentr+";";
        try(Connection con = Conection.getConnection()) {
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            List<ProductosSoli> list = new ArrayList<>(); 
            while(rs.next()) {				
                list.add(crearDTO(rs)); 
                
            }
            return list;
        }
    }
    
    
    
    private ProductosSoli crearDTO(ResultSet rs) throws SQLException {
        ProductosSoli p = new ProductosSoli();
        p.setPerro(rs.getString("idPerro"));
        p.setUsuario(rs.getString("idUsuario"));
        p.setCasa(rs.getString("casa"));
        p.setEdad(rs.getString("MayorEdad"));
        p.setExperiencia(rs.getString("experiencia"));
        p.setMascotas(rs.getString("otrasmascotas"));
        p.setFinalidad(rs.getString("finalidad"));
        p.setFamilia(rs.getString("familiainformada"));
        p.setResponsable(rs.getString("responsable"));
         p.setTiempo(rs.getString("tiempo"));
         p.setLugar(rs.getString("lugar"));
         p.setXq(rs.getString("porque"));
         p.setVisitas(rs.getString("visitas"));
         p.setDonativo(rs.getString("donativo"));
        return p;
    }
    
   
}