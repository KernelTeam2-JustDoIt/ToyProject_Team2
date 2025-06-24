package com.team2.service;

import com.team2.dto.notice.NoticeDTO;
import com.team2.mapper.NoticeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class NoticeServiceImpl implements NoticeService {

    @Autowired
    private NoticeMapper noticeMapper;

    @Override
    public NoticeDTO getMainNotice() {
        return noticeMapper.getMainNotice();
    }

    @Override
    public int countNotices(Map<String, Object> param) {
        return noticeMapper.countNotices(param);
    }




    @Override
    public NoticeDTO getNoticeDetail(int noticeId) {
        return noticeMapper.getNoticeDetail(noticeId);
    }

    @Override
    public int insertNotice(NoticeDTO notice) {
        noticeMapper.insertNotice(notice);
        return notice.getNoticeId(); // noticeId는 mapper에서 selectKey로 채워짐
    }

    @Override
    public void updateNotice(NoticeDTO noticeDTO) {
        noticeMapper.updateNotice(noticeDTO);
    }

    @Override
    public void deleteNotice(int noticeId) {
        noticeMapper.deleteNotice(noticeId);
    }

    @Override
    public void unsetMainNotice() {
        noticeMapper.unsetMainNotice();
    }
    @Override
    public List<NoticeDTO> getPinnedNotices() {
        List<NoticeDTO> pinned = noticeMapper.getPinnedNotices();
        NoticeDTO main = noticeMapper.getMainNotice();

        if (main != null) {
            boolean alreadyIncluded = pinned.stream()
                    .anyMatch(n -> n.getNoticeId() == main.getNoticeId());

            if (!alreadyIncluded) {
                pinned.add(0, main); // 포함 안 돼 있으면 맨 위에 추가
            } else {
                // 이미 포함되어 있으면 위치 조정
                pinned.removeIf(n -> n.getNoticeId() == main.getNoticeId());
                pinned.add(0, main);
            }
        }

        return pinned;
    }

    @Override
    public List<NoticeDTO> getNoticeList(Map<String, Object> param) {
        return noticeMapper.getNoticeList(param);
    }
}
