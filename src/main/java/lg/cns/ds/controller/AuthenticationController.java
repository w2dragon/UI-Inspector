package lg.cns.ds.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lg.cns.ds.domain.User;
import lg.cns.ds.service.UserDetailServiceImpl;

@Controller
public class AuthenticationController {
	@Autowired
	UserDetailServiceImpl service;

	@GetMapping("/login")
	public String getLogin() {
		return "login";
	}
	
	@RequestMapping(value="/checkUser", method=RequestMethod.POST)
	@ResponseBody
	public String checkUser(User vo) {
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		
//		reqMap.put("userId", userId);
//		reqMap.put("userName", userName);

		returnMap = service.checkUser(vo);
		
		return (String) returnMap.get("RESULT");
	}
	
	@RequestMapping(value="/changePass", method=RequestMethod.POST)
	@ResponseBody
	public String getPwdChange(User vo) {
		HashMap<String, Object> returnMap = new HashMap<String, Object>();

		returnMap = service.changePass(vo);
		
		return (String) returnMap.get("RESULT");
	}
	
}
