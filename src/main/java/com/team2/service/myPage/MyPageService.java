package com.team2.service.myPage;

import com.team2.model.CustomerVO;
import java.util.Optional;

public interface MyPageService {

    /**
     * 고객 ID로 마이페이지에 표시할 고객 정보를 조회합니다.
     * 다른 팀원이 구현할 CustomerService 또는 CustomerRepository와 연동될 예정입니다.
     *
     * @param customerId 조회할 고객의 고유 ID
     * @return 조회된 CustomerDTO 객체를 Optional로 감싸 반환. 없으면 Optional.empty()
     */
    // Optional을 사용하여 null 처리
    Optional<CustomerVO> getCustomerInfo(int customerId);

    /**
     * 고객 정보를 업데이트합니다.
     * 비밀번호 변경은 별도의 메서드로 분리하는 것이 일반적입니다.
     *
     * @param customerDTO 업데이트할 고객 정보 (ID 포함)
     * @return 업데이트 성공 여부
     */
    boolean updateCustomerInfo(CustomerVO customerDTO);

    /**
     * 고객의 비밀번호를 변경합니다.
     *
     * @param customerId 고객 ID
     * @param oldPassword 현재 비밀번호 (확인용)
     * @param newPassword 새로운 비밀번호
     * @return 비밀번호 변경 성공 여부
     */
    boolean changePassword(int customerId, String oldPassword, String newPassword);

    // TODO: 추후 예약 내역, 찜 목록, 리뷰 관리 등 기능 추가 시 여기에 메서드 정의
    // List<ReservationDTO> getCustomerReservations(int customerId);
    // List<WishlistItemDTO> getCustomerWishlist(int customerId);
    // List<ReviewDTO> getCustomerReviews(int customerId);
}