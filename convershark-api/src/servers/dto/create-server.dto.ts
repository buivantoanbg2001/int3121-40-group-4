import { ApiProperty } from '@nestjs/swagger';

export class CreateServerDto {
  @ApiProperty({ required: true })
  name: string;

  @ApiProperty({ required: true })
  hostId: string;

  @ApiProperty({ required: false })
  members: string[] = [];

  @ApiProperty({ required: false })
  chatChannels: string[] = [];

  @ApiProperty({ required: false })
  callChannels: string[] = [];
}
