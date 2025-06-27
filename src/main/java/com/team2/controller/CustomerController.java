package com.team2.controller;

import com.team2.model.CustomerVO;
import com.team2.service.CustomerService;
import com.team2.service.EmailService; //  이메일 서비스 import

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.Map;
import java.util.Random; //  인증코드 생성을 위한 import

@RequestMapping("/customer")
@Controller
public class CustomerController {

    private static final Logger logger = LoggerFactory.getLogger(CustomerController.class);

    @Autowired // 의존성 주입: Spring이 CustomerService 구현체를 자동으로 주입함
    private CustomerService customerService;

    @Autowired //  이메일 서비스 주입
    private EmailService emailService;

    // [GET] /customer → 회원가입 페이지 반환
    @GetMapping("")
    public String customer() {
        return "customer/join";
    }

    // [GET] /customer/login → 로그인 페이지 반환
    @GetMapping("/login")
    public String customerLogin() {
        return "customer/login";
    }

    // [POST] /customer/join → 회원가입 폼 전송 처리 + 백엔드 유효성 검사 추가
    @PostMapping("/join")
    public String registerCustomer(@ModelAttribute CustomerVO customer, Model model, HttpSession session) {
        try {
            //  이메일 인증 여부 확인 (세션에 저장된 인증 상태 확인)
            Boolean isVerified = (Boolean) session.getAttribute("emailVerified");
            if (isVerified == null || !isVerified) {
                model.addAttribute("error", "이메일 인증을 완료해야 회원가입이 가능합니다.");
                return "customer/join";
            }

            // 🔒 유효성 검사 로직 시작
            if (customer.getCustomerName() == null || customer.getCustomerName().trim().isEmpty()) {
                model.addAttribute("error", "이름을 입력하세요.");
                return "customer/join";
            }

            if (customer.getCustomerTel() == null || !customer.getCustomerTel().matches("^01[0-9]{8,9}$")) {
                model.addAttribute("error", "전화번호 형식이 올바르지 않습니다. (예: 01012345678)");
                return "customer/join";
            }

            if (customer.getCustomerEmail() == null || !customer.getCustomerEmail().matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
                model.addAttribute("error", "유효한 이메일 주소를 입력하세요.");
                return "customer/join";
            }

            if (customer.getCustomerLoginId() == null || customer.getCustomerLoginId().trim().isEmpty()) {
                model.addAttribute("error", "아이디를 입력하세요.");
                return "customer/join";
            }

            if (customer.getCustomerPassword() == null || customer.getCustomerPassword().length() < 8) {
                model.addAttribute("error", "비밀번호는 8자 이상이어야 합니다.");
                return "customer/join";
            }

            if (customer.getCustomerAge() <= 0) {
                model.addAttribute("error", "나이를 올바르게 입력하세요.");
                return "customer/join";
            }
            // 🔓 유효성 검사 통과

            // DB 저장 (암호화 포함된 서비스 로직 수행)
            customerService.registerCustomer(customer);
            System.out.println(customer.getIsMarketingUseAgreed()); // 콘솔 확인용

            return "redirect:/customer/login"; // 가입 완료 시 로그인 페이지로 이동

        } finally {
            //  회원가입 후 인증 세션 정리 (실패해도 무조건 삭제)
            session.removeAttribute("emailVerificationCode");
            session.removeAttribute("emailVerified");
        }
    }

    // [POST] /customer/login → 로그인 폼 전송 처리
    @PostMapping("/login")
    public String login(@RequestParam String customerLoginId,
                        @RequestParam String customerPassword,
                        HttpSession session,
                        Model model) {

        // 로그인 입력값 검증
        if (customerLoginId == null || customerLoginId.trim().isEmpty() ||
                customerPassword == null || customerPassword.trim().isEmpty()) {
            model.addAttribute("error", "아이디와 비밀번호를 모두 입력하세요.");
            return "customer/login";
        }

        // 로그인 처리 시도
        try {
            CustomerVO customer = customerService.login(customerLoginId, customerPassword);
            System.out.println("2222");
            System.out.println(customer);
            session.setAttribute("loginCustomer", customer); // 로그인 객체 저장
            session.setAttribute("loginCustomerId", customer.getCustomerId()); // ID 별도 저장 (기존 로직 호환)
            return "redirect:/"; // 홈페이지로 이동
        } catch (IllegalStateException e) {
            String message = e.getMessage();
            switch (message) {
                case "LOCKED":
                    model.addAttribute("error", "잠긴 계정입니다");
                    return "customer/login";
                case "UNKNOWN_ID":
                    model.addAttribute("error", "존재하지 않는 아이디입니다.");
                    return "customer/login";
                case "WRONG_PASSWORD":
                    model.addAttribute("error", "비밀번호가 일치하지 않습니다.");
                    return "customer/login";
                case "DELETED":
                    model.addAttribute("error", "탈퇴한 계정입니다.");
                    return "customer/login";
                default:
                    model.addAttribute("error", "다시 시도하십셔.");
                    return "customer/login";
            }
        }
    }

    // [GET] /customer/check-id → 아이디 중복 체크
    @GetMapping(value = "/check-id", produces = "text/plain")
    @ResponseBody
    public String checkLoginIdDuplicate(@RequestParam String customerLoginId) {
        boolean isDuplicate = customerService.isLoginIdDuplicate(customerLoginId);
        return String.valueOf(isDuplicate); // true 또는 false 반환
    }

    // [GET] /customer/check-email → 이메일 중복 체크
    @GetMapping(value = "/check-email", produces = "text/plain")
    @ResponseBody
    public String checkEmailDuplicate(@RequestParam String customerEmail) {

        // 💡 이메일이 null이거나 빈 값인 경우 비정상 처리
        if (customerEmail == null || customerEmail.trim().isEmpty()) {
            return "invalid";
        }

        boolean isDuplicate = customerService.isEmailDuplicate(customerEmail);
        return String.valueOf(isDuplicate);
    }

    // 이메일 인증코드 전송
    @PostMapping("/sendEmailVerification")
    @ResponseBody
    public String sendEmailVerification(@RequestParam("customerEmail") String customerEmail,
                                        HttpSession session) {

        // 6자리 난수 생성
        String verificationCode = String.valueOf(new Random().nextInt(900000) + 100000);

        // 이메일 전송
        emailService.sendVerificationEmail(customerEmail, verificationCode);

        // 세션 저장
        session.setAttribute("emailVerificationCode", verificationCode);
        session.setAttribute("emailVerified", false);

        return "success";
    }

    // 인증코드 확인 처리
    @PostMapping("/verifyEmailCode")
    @ResponseBody
    public String verifyEmailCode(@RequestParam("inputCode") String inputCode,
                                  HttpSession session) {

        String savedCode = (String) session.getAttribute("emailVerificationCode");

        if (savedCode != null && savedCode.equals(inputCode)) {
            session.removeAttribute("emailVerificationCode");
            session.setAttribute("emailVerified", true);
            return "success";
        } else {
            return "fail";
        }
    }

    // 비밀번호 찾기 페이지 반환
    @GetMapping("/findPassword")
    public String showFindPasswordPage() {
        return "customer/findPassword";
    }

    // (필요 시 중복 submit 방지를 위한 post도 유지)
    @PostMapping("/findPassword")
    public String findPassword() {
        return "customer/findPassword";
    }

    // 인증코드 전송 (비밀번호 재설정용)
    @PostMapping("/sendCode")
    @ResponseBody
    public ResponseEntity<?> sendPasswordResetCode(@RequestBody Map<String, String> data,
                                                   HttpSession session) {
        String loginId = data.get("customerLoginId");
        String email = data.get("customerEmail");

        CustomerVO customer = customerService.findCustomerByLoginIdAndEmail(loginId, email);
        if (customer == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("일치하는 회원 없음");
        }

        String code = emailService.generateCode();
        emailService.sendVerificationEmail(email, code);

        session.setAttribute("verifyCode", code);
        session.setAttribute("verifyId", loginId);
        return ResponseEntity.ok("이메일 전송 완료");
    }

    // 인증코드 확인 (비밀번호 찾기)
    @PostMapping("/verifyCode")
    @ResponseBody
    public String verifyPasswordResetCode(@RequestBody Map<String, String> data,
                                          HttpSession session) {
        String inputCode = data.get("code");
        String savedCode = (String) session.getAttribute("verifyCode");

        if (inputCode != null && inputCode.equals(savedCode)) {
            return "success";
        } else {
            return "fail";
        }
    }

    // 비밀번호 변경 처리
    @PostMapping("/changePassword")
    public String changePassword(@RequestParam String customerLoginId,
                                 @RequestParam String newPassword,
                                 @RequestParam String confirmPassword,
                                 HttpSession session,
                                 Model model) {
        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute("error", "비밀번호가 일치하지 않습니다.");
            return "customer/findPassword";
        }

        String verifiedId = (String) session.getAttribute("verifyId");
        System.out.println("verifiedId = " + !verifiedId.equals(customerLoginId));
        System.out.println("customerLoginId = " + customerLoginId);
        System.out.println("verifiedId = " + verifiedId);
        if (verifiedId == null || !verifiedId.equals(customerLoginId)) {
            model.addAttribute("error", "인증되지 않은 사용자입니다.");
            return "customer/findPassword";
        }

        customerService.updatePassword(customerLoginId, newPassword);
        session.invalidate(); // 로그인 관련 세션 정보 초기화
        return "redirect:/customer/login";
    }

    // [GET] /customer/logout → 로그아웃 처리
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
    @GetMapping("/withdraw")
    public String withdraw(HttpSession session) {
        CustomerVO loginCustomer = (CustomerVO) session.getAttribute("loginCustomer");

        if (loginCustomer != null) {
            int customerId = loginCustomer.getCustomerId();
            customerService.deactivateCustomer(customerId);  // 상태 3으로 업데이트
            session.invalidate();  // 세션 초기화
        }
        return "redirect:/";
    }

    @PostMapping("/update")
    public String updateCustomerSettings(
            HttpSession session,
            @ModelAttribute CustomerVO updatedCustomerVo, // 폼 데이터가 CustomerVO 객체에 바인딩됩니다.
            @RequestParam("currentPassword") String currentPassword,
            RedirectAttributes ra) {

        CustomerVO loginCustomer = (CustomerVO) session.getAttribute("loginCustomer");

        // 1. 로그인 여부 확인
        if (loginCustomer == null) {
            ra.addFlashAttribute("errorMessage", "로그인 세션이 만료되었거나 유효하지 않습니다. 다시 로그인해주세요.");
            return "redirect:/login";
        }

        // 2. 현재 비밀번호 확인 (Service 계층에 위임)
        if (!customerService.isPasswordCorrect(currentPassword, loginCustomer.getCustomerPassword())) {
            ra.addFlashAttribute("errorMessage", "현재 비밀번호가 일치하지 않습니다. 다시 확인해주세요.");
            return "redirect:/myPage#settings";
        }

        // 세션의 기존 정보를 기준으로 변경 사항을 Service에서 처리할 것이므로,
        // 여기서는 폼에서 넘어온 updatedCustomerVo를 Service로 바로 넘깁니다.
        try {
            // 4. 서비스 계층에 업데이트 위임
            // Service에서 DB 업데이트 및 세션 정보 갱신을 위한 최신 CustomerVO 반환
            customerService.updateCustomerInfo(loginCustomer, updatedCustomerVo);

            // 세션 정보 갱신
            CustomerVO newlyUpdatedCustomer = customerService.findByLoginId(loginCustomer.getCustomerLoginId());
            session.setAttribute("loginCustomer", newlyUpdatedCustomer);

            ra.addFlashAttribute("successMessage", "회원 정보가 성공적으로 수정되었습니다.");

        } catch (Exception e) {
            ra.addFlashAttribute("errorMessage", "정보 수정 중 오류가 발생했습니다");
            logger.error(e.getMessage());
        }

        // 5. 결과 페이지로 리다이렉트
        return "redirect:/myPage";
    }
}

