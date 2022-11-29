import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import { ApiProperty } from "@nestjs/swagger";
import { Transform, Type } from "class-transformer";
import mongoose, { ObjectId, Document } from "mongoose";
import { ChatChannel } from "./chat_channels.schema";
import { Message } from "./messages.schema";
import { User } from "./user.schema";

export type NotificationDocument = Notification & Document;

@Schema()
export class Notification {
    @Transform(({ value }) => value.toString())
    _id: ObjectId;

    @ApiProperty({required: false})
    @Prop({ type: mongoose.Types.ObjectId, ref: 'User' })
    @Type(() => User)
    sender: string;

    @ApiProperty({required: true})
    @Prop({ type: mongoose.Types.ObjectId, ref: 'User' })
    @Type(() => User)
    receiver: string;

    @ApiProperty({required: true})
    @Prop()
    content: string;

    @ApiProperty({required: false})
    @Prop({ type: mongoose.Types.ObjectId, ref: 'ChatChannel' })
    @Type(() => ChatChannel)
    chat_channel: string;

    @ApiProperty({required: false})
    @Prop()
    create_at: string;

    @ApiProperty({required: false})
    @Prop({default: false})
    is_reply: boolean;
}
export const NotificationSchema = SchemaFactory.createForClass(Notification);