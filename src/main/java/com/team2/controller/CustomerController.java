package com.team2.controller;

import com.team2.model.CustomerVO;
import com.team2.service.CustomerService;
import com.team2.service.EmailService; //  이메일 서비스 import

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.Map;
import java.util.Random; //  인증코드 생성을 위한 import

@RequestMapping("/customer")
@Controller
public class CustomerController {

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
            //  이메일 인증 여부 확인
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

            // DB 저장
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

        //  로그인 입력값 검증: null 또는 빈 값일 경우
        if (customerLoginId == null || customerLoginId.trim().isEmpty() ||
                customerPassword == null || customerPassword.trim().isEmpty()) {
            model.addAttribute("error", "아이디와 비밀번호를 모두 입력하세요.");
            return "customer/login";
        }

        // 로그인 처리 로직 실행 (아이디/비밀번호 확인)
        try {
            CustomerVO customer = customerService.login(customerLoginId, customerPassword);
            session.setAttribute("loginCustomer", customer);
            return "redirect:/"; // 홈페이지로 이동
        }catch (IllegalStateException e) {
            String message = e.getMessage();
            switch (message) {
                case "LOCKED":
                    model.addAttribute("error", "잠긴 계정입니다");
                    return "customer/login";
                case "UNKNOWN_ID" :
                    model.addAttribute("error", "존재하지 않는 아이디입니다.");
                    return "customer/login";
                case "WRONG_PASSWORD" :
                    model.addAttribute("error", "비밀번호가 일치하지 않습니다.");
                    return "customer/login";
                default:
                    model.addAttribute("error", "다시 시도하십셔.");
                    return "customer/login";
            }
        }
    }

    // [GET] /customer/check-id → 아이디 중복 체크 (AJAX 요청 처리용)
    @GetMapping(value = "/check-id", produces = "text/plain")
    @ResponseBody
    public String checkLoginIdDuplicate(@RequestParam String customerLoginId) {
        boolean isDuplicate = customerService.isLoginIdDuplicate(customerLoginId);
        return String.valueOf(isDuplicate); // "true" or "false"
    }

    // [GET] /customer/check-email → 이메일 중복 체크 (AJAX 요청 처리용)
    @GetMapping(value = "/check-email", produces = "text/plain")
    @ResponseBody
    public String checkEmailDuplicate(@RequestParam String customerEmail) {

        // 💡 이메일이 null이거나 빈 값인 경우, 유효하지 않은 요청으로 처리
        if (customerEmail == null || customerEmail.trim().isEmpty()) {
            return "invalid"; // 또는 return "true"; // 무조건 중복된 것으로 처리해도 됨
        }

        boolean isDuplicate = customerService.isEmailDuplicate(customerEmail);
        return String.valueOf(isDuplicate); // "true" or "false"
    }

    //  [POST] /customer/sendEmailVerification → 이메일 인증코드 전송
    @PostMapping("/sendEmailVerification")
    @ResponseBody
    public String sendEmailVerification(@RequestParam("customerEmail") String customerEmail,
                                        HttpSession session) {

        //  6자리 랜덤 숫자 생성
        String verificationCode = String.valueOf(new Random().nextInt(900000) + 100000);

        //  이메일 전송
        emailService.sendVerificationEmail(customerEmail, verificationCode);

        //  인증코드를 세션에 저장
        session.setAttribute("emailVerificationCode", verificationCode);

        // ➕ 인증 상태 초기화 (이전 인증 성공 여부 무효화)
        session.setAttribute("emailVerified", false);

        return "success"; // front에서 이 값 확인해서 alert 띄우면 됨
    }

    //  [POST] /customer/verifyEmailCode → 사용자가 입력한 인증코드를 서버에서 확인
    @PostMapping("/verifyEmailCode")
    @ResponseBody
    public String verifyEmailCode(@RequestParam("inputCode") String inputCode,
                                  HttpSession session) {

        //  세션에 저장된 인증코드 꺼내기
        String savedCode = (String) session.getAttribute("emailVerificationCode");

        //  인증코드 비교
        if (savedCode != null && savedCode.equals(inputCode)) {
            session.removeAttribute("emailVerificationCode");          // 인증코드 삭제
            session.setAttribute("emailVerified", true);// 인증 완료 표시
            return "success"; // 인증 성공
        } else {
            return "fail"; // 인증 실패
        }
    }
    //[GET] /customer/findPassword → 비밀번호 변경 페이지 반환
    @GetMapping("/findPassword")
    public String showFindPasswordPage() {
        return "customer/findPassword";
    }
    @PostMapping("/findPassword")
    public String findPassword() {
        return "customer/findPassword";
    }
    @PostMapping("/sendCode")
    @ResponseBody
    public ResponseEntity<?> sendPasswordResetCode(@RequestBody Map<String, String> data,
                                                   HttpSession session) {
        String loginId = data.get("customerLoginId");
        String email = data.get("customerEmail");

        // 아이디 + 이메일 조합이 유효한지 확인
        CustomerVO customer = customerService.findCustomerByLoginIdAndEmail(loginId, email);
        if (customer == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("일치하는 회원 없음");
        }

        // 인증코드 생성 및 이메일 전송
        String code = emailService.generateCode();
        emailService.sendVerificationEmail(email, code);

        // 세션에 저장
        session.setAttribute("verifyCode", code);
        session.setAttribute("verifyId", loginId);
        return ResponseEntity.ok("이메일 전송 완료");
    }
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

        // 세션의 인증된 아이디 확인
        String verifiedId = (String) session.getAttribute("verifyId");
        System.out.println("verifiedId = " + !verifiedId.equals(customerLoginId));
        System.out.println("customerLoginId = " + customerLoginId);
        System.out.println("verifiedId = " + verifiedId);
        if (verifiedId == null || !verifiedId.equals(customerLoginId)) {
            model.addAttribute("error", "인증되지 않은 사용자입니다.");
            return "customer/findPassword";
        }

        // 비밀번호 변경
        customerService.updatePassword(customerLoginId, newPassword); // 암호화 포함
        session.invalidate(); // 인증 세션 초기화

        return "redirect:/customer/login";
    }

}
