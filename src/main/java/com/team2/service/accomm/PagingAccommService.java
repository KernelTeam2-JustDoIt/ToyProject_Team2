package com.team2.service.accomm;

import com.team2.dto.paging.PagingAccommDTO;
import com.team2.dto.previewaccomm.ConditionDTO;
import com.team2.mapper.YanupzaPaging;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Calendar;
import java.util.List;

@Service
public class PagingAccommService {

    @Autowired
    private YanupzaPaging yanupzaPaging;

    /* 페이지네이션 알고리즘 처리 */
    public List<PagingAccommDTO> getSearchAccommPaging(ConditionDTO conditionDTO) {
        return yanupzaPaging.searchAccommPaging(conditionDTO);
    }

    /* 숙소 개수 구하기 */
    public int getTotalAccomm(ConditionDTO conditionDTO) {
        return yanupzaPaging.getAccommPagingCnt(conditionDTO);
    }

    /* 페이징관련 Limit, OFFSET 등 계산 */
    private void setCondition(ConditionDTO conditionDTO) {
        conditionDTO.setTotalPeopleCnt(conditionDTO.getAdultCnt() + conditionDTO.getBabyCnt());
        conditionDTO.setLimit(conditionDTO.getSize());
        conditionDTO.setOffset((conditionDTO.getPage() - 1) * conditionDTO.getSize());
        conditionDTO.setOnOff(1);
    }

    /* 페이지 개수 구하기 */
    public int getTotalPages(ConditionDTO conditionDTO, int size) {
        setCondition(conditionDTO);
        return (int) Math.ceil((double) getTotalAccomm(conditionDTO) / size);
    }

    /* 디폴트 페이지 */
    public ConditionDTO getDefaultCondition(String keyword) {
        ConditionDTO conditionDTO = new ConditionDTO();
        conditionDTO.setDistrict(keyword);
        conditionDTO.setAdultCnt(2);
        conditionDTO.setBabyCnt(0);
        conditionDTO.setTotalPeopleCnt(conditionDTO.getAdultCnt() + conditionDTO.getBabyCnt());
        setCondition(conditionDTO);

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Calendar now = Calendar.getInstance();

        String checkInStr = sdf.format(now.getTime());

        now.add(Calendar.DATE, 1);
        String checkOutStr = sdf.format(now.getTime());

        conditionDTO.setCheckIn(checkInStr);
        conditionDTO.setCheckOut(checkOutStr);

        return conditionDTO;
    }

    public List<PagingAccommDTO> setCalendar(List<PagingAccommDTO> pagingAccommDTOList, ConditionDTO conditionDTO) {

        for (PagingAccommDTO pagingAccommDTO : pagingAccommDTOList) {

            pagingAccommDTO.setCheckIn(conditionDTO.getCheckIn());
            pagingAccommDTO.setCheckOut(conditionDTO.getCheckOut());
        }

        return pagingAccommDTOList;
    }
}
