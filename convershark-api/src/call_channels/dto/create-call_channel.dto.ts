import { ApiProperty } from "@nestjs/swagger";
import { ObjectId } from "mongoose";

export class CreateCallChannelDto {
    // _id: string;

    @ApiProperty({required: true})
    name: string;

    @ApiProperty({required: true})
    creatorId: string;

    @ApiProperty({required: false})
    members: string[] = [];
}