import { ApiProperty } from '@nestjs/swagger';

export class CreateMessageDto {
  _id: string;

  @ApiProperty({ required: true })
  userId: string;

  @ApiProperty({ required: true })
  content: string;

  @ApiProperty({ required: false })
  replyMessageId: string; // message_id
}
