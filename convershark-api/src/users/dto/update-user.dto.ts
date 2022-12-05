import { PartialType } from '@nestjs/mapped-types';
import { ApiProperty } from '@nestjs/swagger';
import { CreateUserDto } from './create-user.dto';

export class UpdateUserDto {
  _uid?: string;

  @ApiProperty({ required: false })
  name?: string;

  @ApiProperty({ default: null, required: false })
  status?: string;

  @ApiProperty({ default: 'wallpaper', required: false })
  wallpaper?: string;

  @ApiProperty({ default: 'avatar', required: false })
  avatar?: string;

  @ApiProperty({ default: 'bio', required: false })
  bio?: string;
}
