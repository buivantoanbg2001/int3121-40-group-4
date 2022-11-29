import { ApiProperty } from '@nestjs/swagger';

export class CreateNotificationDto {
  @ApiProperty({ required: false })
  sender: string;

  @ApiProperty({ required: true })
  receiver: string;

  @ApiProperty({ required: true })
  content: string;

  @ApiProperty({ required: false })
  chatChannel: string;

  @ApiProperty({ required: false })
  isReply: boolean;
}
