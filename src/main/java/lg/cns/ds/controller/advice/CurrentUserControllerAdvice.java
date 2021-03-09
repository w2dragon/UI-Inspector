package lg.cns.ds.controller.advice;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import lg.cns.ds.domain.User;

@ControllerAdvice
public class CurrentUserControllerAdvice {

	@ModelAttribute("currentUser")
	public User getCurrentuser() {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if (principal == null || !(principal instanceof User)) {
			return null;
		} else {
			return (User) principal;
		}
	}
}
