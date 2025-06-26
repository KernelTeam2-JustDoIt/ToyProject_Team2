package com.team2.vo.previewaccomm;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AccommVO {

    private Integer accommodationId;
    private Integer adminId;
    private Integer categoryL1Id;
    private Integer categoryL2Id;
    private Integer categoryL3Id;
    private String name;
    private Integer status;
    private Integer clickViews;
    private String rating;
    private String provinceName;
    private String districtName;
    private String roadName;
    private Integer buildingNumber;
    private Integer buildingSubNumber;
    private String createdAt;
    private String updatedAt;
    private Integer createdBy;
    private Integer updatedBy;
}