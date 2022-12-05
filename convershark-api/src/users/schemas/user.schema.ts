import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Transform, Type } from 'class-transformer';
import mongoose, { Document, ObjectId } from 'mongoose';

import {} from '@nestjs/common';
import { ApiProperty } from '@nestjs/swagger';
import {
  IsEmail,
  IsNotEmpty,
  IsString,
  MaxLength,
  MinLength,
} from 'class-validator';
import { Server } from 'src/servers/schemas';

export type UserDocument = User & Document;

export class ShortUserInfo {
  _id: string;
  _uid: string;
  name: string;
  avatar: string;
  wallpaper: string;
  status: string;
  bio: string;
}

@Schema({ timestamps: true })
export class User {
  @Transform(({ value }) => value.toString())
  _id: ObjectId;

  @Prop({ unique: true })
  _uid: string; // nguyenvantu#1234

  @Prop({ default: 'noname' })
  @IsString()
  @MinLength(4)
  @MaxLength(20)
  name: string;

  @Prop({ unique: true, required: true })
  @IsEmail()
  @IsString()
  @IsNotEmpty()
  email: string;

  @Prop({ required: false })
  hashedPassword?: string;

  @Prop({ default: 'Online' })
  status: 'Online' | 'Offline';

  @Prop({ default: 'link image' })
  wallpaper: string;

  @Prop({ default: 'link image' })
  avatar: string;

  @Prop({ default: '' })
  bio: string;

  @Prop({
    type: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Server' }],
  })
  @Type(() => Server)
  servers?: string[] = [];

  @Prop({
    type: [{ type: mongoose.Schema.Types.ObjectId, ref: 'User' }],
  })
  @Type(() => User)
  friends?: string[] = [];
}
export const UserSchema = SchemaFactory.createForClass(User);
