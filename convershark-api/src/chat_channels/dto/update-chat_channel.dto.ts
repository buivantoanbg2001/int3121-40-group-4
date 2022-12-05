import { ApiProperty } from '@nestjs/swagger';

export class UpdateChatChannelDto {
  @ApiProperty({ required: false })
  hostId?: string;

  @ApiProperty({ required: false })
  members?: string[];

  @ApiProperty({ required: false })
  messages?: string[];
}
