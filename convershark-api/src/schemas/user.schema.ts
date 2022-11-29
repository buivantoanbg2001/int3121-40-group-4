import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import { Exclude, Transform, Type } from "class-transformer";
import mongoose, { Document, ObjectId } from "mongoose";
import { Server } from "./servers.schema";

import {} from '@nestjs/common'
import { ApiProperty } from "@nestjs/swagger";
import { IsEmail, IsNotEmpty, IsString, MaxLength, MinLength } from "class-validator";


export type UserDocument = User & Document;


@Schema()
export class User {
    toObject() {
        throw new Error("Method not implemented.");
    }
    @Transform(({ value }) => value.toString())
    _id: ObjectId;

    @Prop({unique: true, required: false})
    _uid?: string // nguyenvantu#1234

    @ApiProperty({required: true})
    @Prop({required: false})
    @IsString()
    @MinLength(4)
    @MaxLength(20)
    name?: string;

    @ApiProperty({required: true})
    @Prop({unique: true, required: true})
    @IsEmail()
    @IsString()
    @IsNotEmpty()
    email: string;

    @ApiProperty()
    @Prop({unique: true, required: false})
    phone?: string;

    @ApiProperty({required: false})
    @Prop({required: false})
    hashedPassword?: string;

    @ApiProperty({required: false})
    @Prop()
    status?: string;

    @ApiProperty({required: false})
    @Prop()
    wallpaper?: string;

    @ApiProperty({required: false})
    @Prop()
    avatar?: string;

    @ApiProperty({required: false})
    @Prop()
    bio?: string;


    @ApiProperty({required: false})
    @Prop({
        type: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Server' }],
    })
    @Type(() => Server)
    servers?: string[] = [];


    @ApiProperty({required: false})
    @Prop({
        type: [{ type: mongoose.Schema.Types.ObjectId, ref: 'User' }],
    })
    @Type(() => User)
    friends?: string[] = [];
}
export const UserSchema = SchemaFactory.createForClass(User);