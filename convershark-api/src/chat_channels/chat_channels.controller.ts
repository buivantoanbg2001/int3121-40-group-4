import {
  Controller,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Req,
  UseGuards,
  Get,
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
import { ChatChannelsService } from './chat_channels.service';
import { CreateChatChannelDto, UpdateChatChannelDto } from './dto';
import ResponseData from 'src/utils/response-data';

@Controller('chat-channels')
@ApiTags('Chat channels')
@ApiBearerAuth()
@ApiForbiddenResponse({ description: 'Permission denied' })
@UseGuards(AuthGuard('jwt'))
@Controller('chat-channels')
export class ChatChannelsController {
  constructor(private readonly chatChannelsService: ChatChannelsService) {}

  // MEMBERS CAN GET A CHANNEL
  @ApiOperation({
    summary: 'Member get a chat channel by ID',
    description: 'Member get a chat channel by ID',
  })
  @ApiOkResponse({
    description: 'Member get a chat channel by ID successfully',
  })
  @ApiBadRequestResponse({
    description: ' Member get a chat channel by ID failed',
  })
  @Get(':id')
  async get(@Req() req, @Param('id') id: string) {
    const { _id } = req.user;
    return this.chatChannelsService.getWithMemberId(id, _id.toString());
  }

  // SERVER HOST CAN CREATE A NEW CHANNEL
  @ApiOperation({
    summary: 'Create a new chat channel',
    description: 'Create a new chat channel',
  })
  @ApiOkResponse({ description: 'Create a new chat channel successfully' })
  @ApiBadRequestResponse({ description: 'Create a new chat channel failed' })
  @Post()
  async create(
    @Req() request,
    @Body() createChatChannelDto: CreateChatChannelDto,
  ) {
    const { _id } = request.user;
    createChatChannelDto.hostId = _id;
    await this.chatChannelsService.create(createChatChannelDto);
    return new ResponseData(
      true,
      { message: 'Create a new chat channel successfully' },
      null,
    );
  }

  // FROM RECEIVER, AUTO UPDATE MEMBER LIST WHEN RECEIVER ACCEPTED
  @ApiOperation({
    summary: "From receiver, auto updates channel's member list by ID",
    description: "From receiver, auto updates channel's member list by ID",
  })
  @ApiOkResponse({
    description:
      "From receiver, auto updates channel's member list by ID successfully",
  })
  @ApiBadRequestResponse({
    description:
      "From receiver, auto updates channel's member list by ID failed",
  })
  @Patch(':id/members')
  async addNewMember(@Req() request, @Param('id') id: string) {
    const { _id: userId } = request.user;
    await this.chatChannelsService.updateMemberList(id, userId.toString());
    return new ResponseData(
      true,
      { message: 'Update member list successfully' },
      null,
    );
  }

  // SERVER HOST CAN DELETE CHANNEL
  @ApiOperation({
    summary: 'Owner deletes a chat channel by ID',
    description: 'Owner deletes a chat channel by ID',
  })
  @ApiOkResponse({ description: 'Delete a chat channel by ID successfully' })
  @ApiBadRequestResponse({ description: 'Delete a chat channel by ID failed' })
  @ApiNotFoundResponse({ description: "Can't find chat channel to delete" })
  @Delete(':id')
  async remove(@Req() request, @Param('id') chatChannelId: string) {
    const { _id: hostId } = request.user;
    await this.chatChannelsService.remove(chatChannelId, hostId);
    return new ResponseData(
      true,
      { message: 'Delete a chat channel by ID successfully' },
      null,
    );
  }
}
