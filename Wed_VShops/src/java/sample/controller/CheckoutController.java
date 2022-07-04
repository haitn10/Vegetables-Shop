/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.product.Cart;
import sample.product.ProductDAO;
import sample.product.ProductDTO;
import sample.user.UserDTO;

/**
 *
 * @author HTN
 */
@WebServlet(name = "CheckoutController", urlPatterns = {"/CheckoutController"})
public class CheckoutController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String LOGIN_ERROR = "login.jsp";
    private static final String ADD_ERROR = "LoadController";
    private static final String CART_ERROR = "viewCart.jsp";
    private static final String SUCCESS = "ConfirmController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            if (session != null) {
                Cart cart = (Cart) session.getAttribute("CART");
                UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
//                kiểm tra login và cart
                if (loginUser != null) {
                    if (cart != null) {
                        if (cart.getCart().size() > 0) {
                            for (ProductDTO product : cart.getCart().values()) {
//                                kiểm tra quantity trong DB
                                ProductDAO dao = new ProductDAO();
                                boolean check = dao.checkQuantity(product.getProductID(),product.getQuantity());
                                if (!check) {
                                    url = SUCCESS;
                                } else {
                                    request.setAttribute("MESSAGE", "The quantity of "+ product.getProductName() +" is not enough in stock!");
                                    url = CART_ERROR; 
                                }   
                            }
                        } else {
                            url = ADD_ERROR;
                            request.setAttribute("MESSAGE", "Please select the product before checkout!");
                        }
                    } else {
                        url = ADD_ERROR;
                        request.setAttribute("MESSAGE", "Please select the product before checkout!");
                    }
                } else {
                    url = LOGIN_ERROR;
                    request.setAttribute("ERROR", "Please login before checkout!");
                }

            }
        } catch (Exception e) {
            log("Error at CheckoutController: " + e.toString());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
