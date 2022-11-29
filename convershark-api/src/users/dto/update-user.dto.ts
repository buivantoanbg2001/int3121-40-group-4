import { PartialType } from '@nestjs/mapped-types';
import { CreateUserDto } from './create-user.dto';

export class UpdateUserDto extends PartialType(CreateUserDto) {
    // @ApiProperty({required: false, nullable: true})
    // name?: string | null;

    // @ApiProperty({required: false})
    // email?: string;

    // @ApiProperty({required: false})
    // pwd?: string;

    // @ApiProperty({required: false})
    // phone?: string;
    
    // @ApiProperty({required: false})
    // status?: string;

    // @ApiProperty({required: false})
    // wallpaper?: string;

    // @ApiProperty({required: false})
    // avatar?: string;

    // @ApiProperty({required: false})
    // bio?: string;

    // @ApiProperty({required: false})
    // servers?: [];

    // @ApiProperty({required: false})
    // friends?: [];
}
