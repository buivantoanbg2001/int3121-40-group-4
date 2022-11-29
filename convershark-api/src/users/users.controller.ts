import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Query,
  Put,
  NotFoundException,
  UseGuards,
  Req,
} from '@nestjs/common';
import { UsersService } from './users.service';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import {
  ApiBadRequestResponse,
  ApiCreatedResponse,
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
  ApiQuery,
  ApiTags,
} from '@nestjs/swagger';
import { ShortUserInfo, User } from 'src/schemas/user.schema';
import { AuthUserDto } from './dto/auth-user.dto';
import { AuthGuard } from '@nestjs/passport';
import { Request } from 'express';

@ApiTags('users')
@Controller()
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @ApiOkResponse({
    type: User,
    description: 'Successfully created user account',
  })
  @Post('register')
  async register(@Body() authUserDto: AuthUserDto) {
    return this.usersService.register(authUserDto);
  }

  @Post('login')
  async login(@Body() authUserDto: AuthUserDto) {
    return this.usersService.login(authUserDto);
  }

  @UseGuards(AuthGuard('jwt')) // need to protect
  @Get('users/me')
  async me(@Req() request) {
    // get returned email from field "user" of Express
    const { email } = request.user;
    const user = await this.usersService.findUserByEmail(email);
    const { hashedPassword, ...userWithoutPassWord } = user;
    return userWithoutPassWord;
  }

  @ApiOkResponse({
    type: User,
    description: 'Successfully retrieved user information',
  })
  @ApiNotFoundResponse({ description: "The user's id doesn't exist" })
  @UseGuards(AuthGuard('jwt'))
  @Get('users/u/:id')
  async getUserbyObjId(@Param('id') id: string): Promise<ShortUserInfo> {
    const user = await this.usersService.findUserByObjID(id);
    if (!user) {
      throw new NotFoundException("The user's id doesn't exist");
    }
    return user;
  }

  @ApiOkResponse({ description: "Successfully updated user's infomation" })
  @UseGuards(AuthGuard('jwt'))
  @Patch('users/me')
  async update(@Req() request: Request, @Body() updateUserDto: UpdateUserDto) {
    // return this.usersService.update(request., updateUserDto);
    const email = request.user.toString();
    return await this.usersService.update(email, updateUserDto);
  }

  // @ApiOkResponse({ description: "Successfully updated users's friends list" })
  // @ApiOperation({
  //   summary:
  //     'Thêm id vào danh sách friend của user và thêm user vào danh sách friend của id',
  //   description:
  //     'Thêm id vào danh sách friend của user và thêm user vào danh sách friend của id',
  // })
  // @UseGuards(AuthGuard('jwt-update-user'))
  // @Patch('users/friend/:id')
  // updateFriendList(@Req() request: Request, @Body() updateUserDto: UpdateUserDto) {

  // }

  // @ApiOkResponse({ description: 'Successfully delete user account' })
  // @Delete('users/:id')
  // async deleteUser(@Param('id') id: string) {
  //   return await this.usersService.remove(id);
  // }
}
