package com.team2.mapper;

import com.team2.dto.notice.NoticeDTO;
import java.util.List;

public interface NoticeMapper {

    // 최신 공지 1건
    NoticeDTO getLatestNotice();

    // 전체 공지 목록
    List<NoticeDTO> getNoticeList();

    // 공지 상세 조회
    NoticeDTO getNoticeDetail(int noticeId);

    void deleteNotice(int noticeId);

    void updateNotice(NoticeDTO noticeDTO);

    void insertNotice(NoticeDTO noticeDTO);
}
