import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import { ApiProperty } from "@nestjs/swagger";
import { Transform, Type } from "class-transformer";
import mongoose, { Document } from "mongoose";
import { User } from "./user.schema";

export type MessageDocument = Message & Document;

@Schema()
export class Message {
    // auto gen
    @Transform(({ value }) => value.toString())
    _id: string;

    @ApiProperty({required: true})
    @Prop({ type: mongoose.Types.ObjectId, ref: 'User' })
    @Type(() => User)
    user_id: string;

    @ApiProperty({required: true})
    @Prop()
    content: string;


    @ApiProperty({required: true})
    @Prop()
    create_at: string;

    @ApiProperty({required: false})
    @Prop()
    update_at: string;

    @ApiProperty({required: false})
    @Prop({ type: mongoose.Types.ObjectId, ref: 'Message' })
    @Type(() => Message)
    reply_mes_id: string
}
export const MessageSchema = SchemaFactory.createForClass(Message);