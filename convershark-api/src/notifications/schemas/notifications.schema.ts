import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Transform, Type } from 'class-transformer';
import mongoose, { ObjectId, Document } from 'mongoose';
import { CallChannel } from 'src/call_channels/schemas';
import { ChatChannel } from 'src/chat_channels/schemas';
import { Server } from 'src/servers/schemas';
import { User } from 'src/users/schemas';

export type NotificationDocument = Notification & Document;

@Schema({ timestamps: true })
export class Notification {
  @Transform(({ value }) => value.toString())
  _id: ObjectId;

  @Prop({ type: mongoose.Types.ObjectId, ref: 'User' })
  @Type(() => User)
  sender: string;

  @Prop({ type: mongoose.Types.ObjectId, ref: 'User' })
  @Type(() => User)
  receiver: string;

  @Prop({ required: true })
  type: 'FRIEND' | 'MESSAGE' | 'SERVER' | 'CALL' | 'CHAT';

  @Prop({ required: false, default: false })
  isResponse: boolean;

  @Prop({ required: false, default: false })
  isAccept: boolean;

  @Prop({ type: mongoose.Types.ObjectId, ref: 'Server' })
  @Type(() => Server)
  serverId: string;

  @Prop({ type: mongoose.Types.ObjectId, ref: 'ChatChannel' })
  @Type(() => ChatChannel)
  chatId: string;

  @Prop({ type: mongoose.Types.ObjectId, ref: 'CallChannel' })
  @Type(() => CallChannel)
  callId: string;
}
export const NotificationSchema = SchemaFactory.createForClass(Notification);
