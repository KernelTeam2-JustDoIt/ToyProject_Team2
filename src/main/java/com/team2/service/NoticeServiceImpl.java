package com.team2.service;

import com.team2.dto.notice.NoticeDTO;
import com.team2.mapper.NoticeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.Date;
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
    public int countNotices() {
        return noticeMapper.countNotices();
    }
    @Override
    public List<NoticeDTO> getNoticeList(int offset, int pageSize) {
        List<NoticeDTO> noticeList = noticeMapper.getNoticeList(offset,pageSize); //  먼저 DB에서 가져옴

//        for (NoticeDTO dto : noticeList) {
//            if (dto.getPostedAt() != null) {
//                dto.setFormattedDate(dto.getPostedAt().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
//            }
//        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        for (NoticeDTO dto : noticeList) {
            Date postedAt = dto.getPostedAt();  // java.util.Date 타입
            if (postedAt != null) {
                dto.setFormattedDate(sdf.format(postedAt));
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
