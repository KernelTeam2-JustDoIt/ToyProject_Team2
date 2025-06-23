package com.team2.service;

import com.team2.dto.notice.NoticeDTO;
import com.team2.mapper.NoticeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.format.DateTimeFormatter;
import java.util.List;

@Service
public class NoticeServiceImpl implements NoticeService {

    @Autowired
    private NoticeMapper noticeMapper;

    @Override
    public NoticeDTO getLatestNotice() {
        return noticeMapper.getLatestNotice();
    }

    @Override
    public List<NoticeDTO> getNoticeList() {
        List<NoticeDTO> noticeList = noticeMapper.getNoticeList(); //  먼저 DB에서 가져옴

        for (NoticeDTO dto : noticeList) {
            if (dto.getPostedAt() != null) {
                dto.setFormattedDate(dto.getPostedAt().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
            }
        }

        return noticeList; // 포맷된 값이 포함된 리스트 반환
    }


    @Override
    public NoticeDTO getNoticeDetail(int noticeId) {
        return noticeMapper.getNoticeDetail(noticeId);
    }

    @Override
    public void insertNotice(NoticeDTO noticeDTO) {
        noticeMapper.insertNotice(noticeDTO);
    }

    @Override
    public void updateNotice(NoticeDTO noticeDTO) {
        noticeMapper.updateNotice(noticeDTO);
    }

    @Override
    public void deleteNotice(int noticeId) {
        noticeMapper.deleteNotice(noticeId);
    }
}
