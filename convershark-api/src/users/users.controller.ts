import {
  Controller,
  Get,
  Body,
  Patch,
  Param,
  NotFoundException,
  UseGuards,
  Req,
} from '@nestjs/common';

import {
  ApiBadRequestResponse,
  ApiBearerAuth,
  ApiForbiddenResponse,
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
  ApiTags,
} from '@nestjs/swagger';

import { AuthGuard } from '@nestjs/passport';

import { UsersService } from './users.service';
import { UpdateUserDto } from './dto/update-user.dto';
import { ShortUserInfo } from './schemas';

import ResponseData from 'src/utils/response-data';

@ApiTags('User')
@ApiBearerAuth()
@ApiForbiddenResponse({ description: 'Permission denied' })
@UseGuards(AuthGuard('jwt'))
@Controller('users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @ApiOperation({
    summary: 'Retrieve all the information of the logged in user',
    description: 'Retrieve all the information of the logged in user',
  })
  @ApiOkResponse({
    description: 'Retrieve all your information successfully',
  })
  @ApiBadRequestResponse({
    description: 'Retrieval of all your information failed',
  })
  @Get('me')
  async me(@Req() request) {
    const { _id } = request.user;
    const user = await this.usersService.getMe(_id);
    const { hashedPassword, ...userInfo } = user;
    return userInfo;
  }

  @ApiOperation({
    summary:
      'Retrieve all the 2-levels information of the logged in user to manage them servers',
    description:
      'Retrieve all the 2-levels information of the logged in user to manage them servers',
  })
  @ApiOkResponse({
    description: 'Retrieve all your 2-levels information successfully',
  })
  @ApiBadRequestResponse({
    description: 'Retrieval of all your 2-levels information failed',
  })
  @Get('me/management')
  async meAsHost(@Req() request) {
    const { _id } = request.user;
    const user = await this.usersService.getMeDeeper(_id);
    const { hashedPassword, ...userInfo } = user;
    return userInfo;
  }

  @ApiOperation({
    summary: 'Retrieve all public information of users by ID',
    description: 'Retrieve all public information of users by ID',
  })
  @ApiOkResponse({
    description: 'Retrieve all public information of users by ID successfully',
  })
  @ApiBadRequestResponse({
    description: 'Retrieve all public information of users by ID failed',
  })
  @Get('u/:id')
  async getByObjId(@Param('id') id: string): Promise<ShortUserInfo> {
    const user = await this.usersService.findByObjID(id);
    if (!user) {
      throw new NotFoundException("The user's id doesn't exist");
    }
    return user;
  }

  @ApiOperation({
    summary: 'Update logged in user information',
    description: 'Update logged in user information',
  })
  @ApiOkResponse({
    description: 'Update logged in user information successfully',
  })
  @ApiBadRequestResponse({
    description: 'Update logged in user information failed',
  })
  @Patch('me')
  async update(@Req() request, @Body() updateUserDto: UpdateUserDto) {
    const { _id } = request.user;
    await this.usersService.update(_id, updateUserDto);
    return new ResponseData(
      true,
      { message: 'Successfully updated information' },
      null,
    );
  }

  @ApiOperation({
    summary: 'Add friends for both parties',
    description:
      "The recipient presses accept the invitation, using the link as the sender's id",
  })
  @ApiOkResponse({
    description: 'Updating the friends list of both failed',
  })
  @ApiBadRequestResponse({
    description: 'Updating the friends list of both failed',
  })
  @Patch('friends/update-both/:id')
  async updateFriendList(@Param('id') sender: string, @Req() request) {
    const { _id } = request.user;
    const senderId = await (
      await this.usersService.findByObjID(sender)
    )._id.toString();
    if (!senderId) {
      throw new NotFoundException("The user doesn't exist");
    }
    await this.usersService.updateFriendList(_id, senderId);
    await this.usersService.updateFriendList(senderId, _id);

    return new ResponseData(true, { message: 'You guys were friends' }, null);
  }
}
