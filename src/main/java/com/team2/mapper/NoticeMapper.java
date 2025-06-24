package com.team2.mapper;

import com.team2.dto.notice.NoticeDTO;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface NoticeMapper {

    // 최신 공지 1건 -> 메인 공지 설정 건으로 교체
    NoticeDTO getMainNotice();

    // 공지 상세 조회
    NoticeDTO getNoticeDetail(int noticeId);


    int countNotices(Map<String, Object> param);

    void deleteNotice(int noticeId);

    void updateNotice(NoticeDTO noticeDTO);

    void insertNotice(NoticeDTO noticeDTO);

    void unsetMainNotice();



    List<NoticeDTO> getPinnedNotices();

    List<NoticeDTO> getNoticeList(Map<String, Object> param);
}
