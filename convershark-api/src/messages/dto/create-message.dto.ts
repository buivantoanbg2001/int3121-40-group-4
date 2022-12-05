import { ApiProperty } from '@nestjs/swagger';

export class CreateMessageDto {
  ownerId?: string;

  @ApiProperty({ required: true })
  chatChannelId: string;

  @ApiProperty({ required: true })
  content: string;

  @ApiProperty({ required: false })
  replyMessageId?: string; // message_id
}
