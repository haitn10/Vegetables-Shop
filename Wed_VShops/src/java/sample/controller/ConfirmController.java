/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.order.OrderDAO;
import sample.order.OrderDTO;
import sample.order.OrderDetailDAO;
import sample.order.OrderDetailDTO;
import sample.product.Cart;
import sample.product.ProductDAO;
import sample.product.ProductDTO;
import sample.user.UserDTO;

/**
 *
 * @author HTN
 */
@WebServlet(name = "ConfirmController", urlPatterns = {"/ConfirmController"})
public class ConfirmController extends HttpServlet {

    private static final String ERROR = "viewCart.jsp";
    private static final String SUCCESS = "checkout.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            Random rand = new Random();
            boolean checkDuplicate;
            String detailID,orderID;
            double total = 0;
            
            HttpSession session = request.getSession();
            Cart cart = (Cart) session.getAttribute("CART");
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            OrderDAO order = new OrderDAO();
            OrderDetailDAO orderDetail = new OrderDetailDAO();
            
//            lấy orderID,detail ngẫu nhiên và kiểm tra
            do {
                int number1 = rand.nextInt(999999);
                orderID = String.valueOf(number1);
                checkDuplicate = order.checkDuplicate(orderID);
            } while (checkDuplicate);
            do {
                int number2 = rand.nextInt(999999);
                detailID = String.valueOf(number2);
                checkDuplicate = orderDetail.checkDuplicate(detailID);
            } while (checkDuplicate);

//            tạo list orderDetail và total trong order
            List<ProductDTO> listproduct = new ArrayList<>();
            List<OrderDetailDTO> listDetail = new ArrayList<>();
            for (ProductDTO product : cart.getCart().values()) {
                total += product.getPrice() * product.getQuantity();
                double price = product.getPrice() * product.getQuantity();
                listDetail.add(new OrderDetailDTO(detailID, price, product.getQuantity(), orderID, product.getProductID()));
                listproduct.add(new ProductDTO(product.getProductID(), product.getProductName(), product.getImage(), product.getPrice(), product.getQuantity(), "", "", "",1));
            }

//            add order,orderDetail vào DB
            OrderDTO listOrder = new OrderDTO(orderID, total, loginUser.getUserID());
            boolean addOrder = order.add(listOrder);
            if (addOrder) {
                for (OrderDetailDTO detail : listDetail) {
                    boolean addOrderDetail = orderDetail.add(detail);
                    if (addOrderDetail) {
//                        trừ quantity trong DB                   
                        ProductDAO dao = new ProductDAO();
                        boolean updateQuantity = dao.updateQuantity(detail.getProductID(), detail.getQuantity());
                        if (updateQuantity) {
                            url = SUCCESS;
                        }
                    }
                }
            }
//            trả kết quả và xóa session trên CART
            request.setAttribute("LIST_PRODUCT", listproduct);
            session.removeAttribute("CART");

        } catch (Exception e) {
            log("Error at ConfirmController: " + e.toString());
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
