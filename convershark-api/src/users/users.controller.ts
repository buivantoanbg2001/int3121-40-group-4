import { Controller, Get, Post, Body, Patch, Param, Delete, Query, Put, NotFoundException, UseGuards, Req } from '@nestjs/common';
import { UsersService } from './users.service';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { ApiBadRequestResponse, ApiCreatedResponse, ApiNotFoundResponse, ApiOkResponse, ApiQuery, ApiTags } from '@nestjs/swagger';
import { User } from 'src/schemas/user.schema';
import { AuthUserDto } from './dto/auth-user.dto';
import { AuthGuard } from '@nestjs/passport';
import { Request } from 'express';

@ApiTags('users')
@Controller()
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @ApiOkResponse({type: User, description: "Successfully created user account"})
  @Post('register')
  async register(@Body() authUserDto: AuthUserDto) {
    return this.usersService.register(authUserDto);
  }

  @Post('login')
  async login(@Body() authUserDto: AuthUserDto) {
    return this.usersService.login(authUserDto);
  }

  @UseGuards(AuthGuard('jwt'))                                        // need to protect
  @Get('users/me')
    me(@Req() request: Request) {
      // console.log(JSON.stringify(Object.keys(request)));           // print all properties of request
      // console.log(request.user);                                   // where is it come from?
      // return "My Detail Informations";
      return request.user;
    }

  @ApiOkResponse({type: User, description: "Successfully retrieved user information" })
  @ApiNotFoundResponse({description: "The user's id doesn't exist"})
  @Get('users/:id')
  async getUserbyObjId(@Param('id') id: string): Promise<User> {
    const user = this.usersService.findUserByObjID(id);
    if (!user) {
      throw new NotFoundException("The user's id doesn't exist")
    }
    return user
  }

  @ApiOkResponse({description: "Successfully updated user's infomation"})
  @Patch('users/:id')
  update(@Param('id') id: string, @Body() updateUserDto: UpdateUserDto) {
    return this.usersService.update(id, updateUserDto);
  }

  @ApiOkResponse({description: 'Successfully delete user account'})
  @Delete('users/:id')
  async deleteUser(@Param('id') id: string) {
    return await this.usersService.remove(id);
  }
}
function UserGuards() {
  throw new Error('Function not implemented.');
}

