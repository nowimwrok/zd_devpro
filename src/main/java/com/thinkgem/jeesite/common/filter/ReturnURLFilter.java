package com.thinkgem.jeesite.common.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

/**
 * Servlet Filter implementation class ReturnURLFilter
 */
@WebFilter(urlPatterns = {"/zd/wlpt/hall/car","/zd/wlpt/hall/goods","/zd/wlpt/hall/bids","/zd/wlpt/info/index","/zd/wlpt/info/policy/index","/zd/wlpt/toshop","/zd/wlpt/personal/index","/zd/wlpt/goods/goodsQuote","/zd/wlpt/showdetail"})
public class ReturnURLFilter implements Filter {

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		String query=((HttpServletRequest) request).getQueryString();
		String basePath=((HttpServletRequest) request).getRequestURI();
		String url="";
		if(query==null){
			query="";
			url=basePath;
		}else{
			url=basePath+"?"+query;
		}
		((HttpServletRequest) request).getSession().setAttribute("return_url", url);
		chain.doFilter(request, response);
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}
}
