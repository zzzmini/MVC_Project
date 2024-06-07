package kr.co.zzz.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.zzz.dto.AdminDto;
import kr.co.zzz.service.AdminService;

@Controller
@RequestMapping("/admin")
public class AdminController {
	@Autowired
	AdminService adminService;
	
	@Autowired
	PasswordEncoder passwordEncoder;
	
	@GetMapping("")
	public String mainView() {
		return "/admin/main";
	}
	@GetMapping("/createAccountForm")
	public String createAccountForm() {
		return "/admin/create_account_form";
	}
	@PostMapping("/createAccountConfirm")
	public String createAccountConfirm(AdminDto adminDto) {
		System.out.println("createAccountConfirm : " + adminDto.toString());
		adminService.adminInsert(adminDto);
		return "/admin/create_account_form";
	}
	@GetMapping("/loginForm")
	public String loginForm() {
		return "/admin/login_form";
	}
	@PostMapping("/loginConfirm")
	public String loginConfirm(AdminDto adminDto, HttpSession session) {
		String nextPage = "/admin/login_ok";
		
		AdminDto adminLoginedDto = adminService.loginConfirm(adminDto);
		if(adminLoginedDto == null) {
			nextPage = "/admin/login_ng";
			return nextPage;
		}
		
		if(passwordEncoder.matches(adminDto.getA_pw(), adminLoginedDto.getA_pw())) {
			session.setAttribute("adminLoginedDto", adminLoginedDto);
			session.setMaxInactiveInterval(60*30); // 60초 * 30 = 30분
			return nextPage;
		} else {
			nextPage = "/admin/login_ng";
			return nextPage;
		}
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/admin";
	}
	
	@GetMapping("listupAdmin")
	public String listupAdmin(Model model) {
		String nextPage = "/admin/admin_list";
		
		List<AdminDto> adminDtos = adminService.adminList();
		model.addAttribute("adminDtos", adminDtos);
		return nextPage;
	}
	
	@GetMapping("/setAdminApproval")
	public String setAdminApproval(@RequestParam("id")String id) {
		String nextPage = "redirect:/admin/listupAdmin";
		int result = adminService.updateAdminAccount(id);
		return nextPage;
	}
	
	@GetMapping("/modifyAccountForm")
	public String modifyAccountForm(HttpSession session) {
		String nextPage = "/admin/modify_account_form";
		
		AdminDto adminDto = (AdminDto)session.getAttribute("adminLoginedDto");
		// 현재 로그인 상태인지 확인 

		if(adminDto == null) {
			// 로그인 상태 : 수정 페이지 이동
			nextPage = "redirect:/admin/loginForm";
		}

		// 로그 아웃 상태(세션 만료) : 로그인 페이지로 이동 
		return nextPage;
	}
	@PostMapping("/modifyAccountConfirm")
	public String modifyAccountConfirm(AdminDto adminDto, HttpSession session) {
		System.out.println("adminDto ====  " + adminDto.toString());
		String nextPage = "redirect:/admin/listupAdmin";
		
		int result = adminService.modifyAccountConfirm(adminDto);
		// 수정 후 관리자 리스트 페이지로 이동
		if(result > 0) {
			session.setAttribute("adminLoginedDto", adminDto);
			session.setMaxInactiveInterval(60*30);
		}
		return nextPage;
	}
	
	@GetMapping("/searchAdminConfirm")
	public String searchAdminConfirm(@RequestParam("keyword")String keyword,
			@RequestParam("category")String category, Model model) {
		String nextPage = "/admin/admin_list";
		List<AdminDto> adminDtos = adminService.searchAdmin(category, keyword);
		model.addAttribute("adminDtos", adminDtos);
		return nextPage;
	}
	@GetMapping("/handlerInterceptor")
	public String handlerInterceptor() {
		return "/admin/handler_interceptor";
	}
	@GetMapping("/ajaxTest")
	public String likeIdol() {
		return "/admin/ajax_test";
	}
	
	@PostMapping("/searchAjax")
	@ResponseBody
	public List<AdminDto> getListAdmin(@RequestBody Map<String, String> body) {
		String keyword = body.get("keyword");
		System.out.println("keyword = " + keyword);
	
//		List<AdminDto> adminDtos = adminService.searchAdminOne(keyword);
		List<AdminDto> adminDtos = adminService.adminList();
		System.out.println(adminDtos.toString());
//		body.put("a_id", "admin");
		return adminDtos;
	}
	
	@PostMapping("/searchOneAjax")
	@ResponseBody
	public List<AdminDto> getOneListAdmin(@RequestBody Map<String, String> body) {
		String keyword = body.get("keyword");
		System.out.println("keyword = " + keyword);
	
		List<AdminDto> adminDtos = adminService.searchAdminOne(keyword);
		System.out.println(adminDtos.toString());
		return adminDtos;
	}
	
	@PostMapping("/goTest")
	@ResponseBody
	public Map<String, String> goTest(@RequestBody Map<String, String> body) {
		String keyword = body.get("player");
		System.out.println("player = " + keyword);
		body.put("goal", "33");
		return body;
	}
}
















