import { Prop } from "@nestjs/mongoose";
import { ApiProperty } from "@nestjs/swagger";
import { IsEmail, IsNotEmpty, IsString, MinLength } from "class-validator";


export class AuthUserDto {

    @ApiProperty({required: true})
    @Prop({required: true})
    @IsEmail()
    @IsNotEmpty()
    email: string;

    @ApiProperty({required: true})
    @Prop({required: true})
    @IsNotEmpty()
    @IsString()
    @MinLength(8)
    password: string;
}