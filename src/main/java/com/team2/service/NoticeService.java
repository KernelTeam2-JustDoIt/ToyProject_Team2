package com.team2.service;

import com.team2.dto.notice.NoticeDTO;
import java.util.List;

public interface NoticeService {
    NoticeDTO getNoticeDetail(int noticeId);
    List<NoticeDTO> getNoticeList(int offset, int pageSize);
    int countNotices();
    NoticeDTO getLatestNotice();
    void insertNotice(NoticeDTO noticeDTO);
    void updateNotice(NoticeDTO noticeDTO);
    void deleteNotice(int noticeId);
}
