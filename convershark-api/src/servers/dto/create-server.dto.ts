import { ApiProperty } from "@nestjs/swagger";

export class CreateServerDto {
    @ApiProperty({required: true})
    name: string;

    @ApiProperty({required: false})
    members: string[] = [];

    @ApiProperty({required: false})
    chat_channels: string[] = [];

    @ApiProperty({required: false})
    call_channels: string[] = [];
}
