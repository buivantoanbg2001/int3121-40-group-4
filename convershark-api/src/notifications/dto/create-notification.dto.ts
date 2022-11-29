import { ApiProperty } from "@nestjs/swagger";

export class CreateNotificationDto {
    
    @ApiProperty({required: false})
    sender: string;

    @ApiProperty({required: true})
    receiver: string;

    @ApiProperty({required: true})
    content: string;

    @ApiProperty({required: false})
    chat_channel: string;

    @ApiProperty({required: false})
    create_at: string;

    @ApiProperty({required: false})
    is_reply: boolean;
}
