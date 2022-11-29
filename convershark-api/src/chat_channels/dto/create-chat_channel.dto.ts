import { ApiProperty } from "@nestjs/swagger";

export class CreateChatChannelDto {
    @ApiProperty({required: true})
    name: string;

    @ApiProperty({required: false})
    members: string[] = [];     // list user_id

    @ApiProperty({required: false})
    messages: string[] = [];    // list message_id
}
