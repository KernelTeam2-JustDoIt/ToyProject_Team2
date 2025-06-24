package com.team2.service;

import com.team2.dto.notice.NoticeDTO;
import java.util.List;
import java.util.Map;

public interface NoticeService {
    NoticeDTO getNoticeDetail(int noticeId);

    int countNotices(Map<String, Object> param) ;

    NoticeDTO getMainNotice();

    int insertNotice(NoticeDTO notice); // 반환형 void → int

    void updateNotice(NoticeDTO noticeDTO);
    void deleteNotice(int noticeId);
    void unsetMainNotice();

    List<NoticeDTO> getPinnedNotices();

    List<NoticeDTO> getNoticeList(Map<String, Object> param);
}
