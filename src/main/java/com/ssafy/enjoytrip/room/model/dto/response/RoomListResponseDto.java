package com.ssafy.enjoytrip.room.model.dto.response;

import com.ssafy.enjoytrip.room.model.entity.Room;
import java.math.BigDecimal;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Builder
@AllArgsConstructor
@Getter
public class RoomListResponseDto {

    private Long id;
    private String roomName;
    private String address;
    private Long pricePerNight;
    private String picture;
    private BigDecimal rating;
    public static RoomListResponseDto from(Room entity) {
        return RoomListResponseDto.builder()
                                  .id(entity.getId())
                                  .roomName(entity.getRoomName())
                                  .address(entity.getAddress())
                                  .pricePerNight(entity.getPricePerNight())
                                  .build();
    }

    public void mapPictureToRoom() {
        this.picture = "https://ssafyfinal.s3.ap-northeast-2.amazonaws.com/" + picture;
    }

}
