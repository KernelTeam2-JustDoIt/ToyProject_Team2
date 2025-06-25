package com.team2.dto.previewaccomm;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PreviewAccommImageDTO {

    private int accommodationId;
    private String accommodationImageFilePath;
    private String accommodationImageType;
    private int accommodationImageFileSize;
    private int accommodationImageHeight;
    private int accommodationImageWidth;
}
