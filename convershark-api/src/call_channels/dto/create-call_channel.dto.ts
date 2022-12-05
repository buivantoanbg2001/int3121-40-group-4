import { ApiProperty } from '@nestjs/swagger';

export class CreateCallChannelDto {
  @ApiProperty({ required: true })
  name: string;

  hostId?: string;

  @ApiProperty({ required: false })
  serverId?: string;
}
