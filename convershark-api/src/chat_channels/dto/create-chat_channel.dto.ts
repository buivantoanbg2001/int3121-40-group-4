import { ApiProperty } from '@nestjs/swagger';

export class CreateChatChannelDto {
  @ApiProperty({ required: true })
  name: string;

  hostId?: string;

  @ApiProperty({ required: false })
  serverId?: string;
}
