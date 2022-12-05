import {
  Controller,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  UseGuards,
  Req,
  Get,
} from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';

import {
  ApiBadRequestResponse,
  ApiBearerAuth,
  ApiForbiddenResponse,
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
  ApiTags,
} from '@nestjs/swagger';

import ResponseData from 'src/utils/response-data';
import { CallChannelsService } from './call_channels.service';
import { CreateCallChannelDto, UpdateCallChannelDto } from './dto';

@ApiTags('Call channels')
@ApiBearerAuth()
@ApiForbiddenResponse({ description: 'Permission denied' })
@UseGuards(AuthGuard('jwt'))
@Controller('call-channels')
export class CallChannelsController {
  constructor(private readonly callChannelsService: CallChannelsService) {}

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
    return this.callChannelsService.getWithMemberId(id, _id.toString());
  }

  // CREATE A NEW CALL CHANNEL
  @ApiOperation({
    summary: 'Create a new call channel',
    description: 'Create a new call channel',
  })
  @ApiOkResponse({ description: 'Create a new call channel successfully' })
  @ApiBadRequestResponse({ description: 'Create a new call channel failed' })
  @Post()
  async create(
    @Req() request,
    @Body() createCallChannelDto: CreateCallChannelDto,
  ) {
    const { _id } = request.user;
    createCallChannelDto.hostId = _id;
    await this.callChannelsService.create(createCallChannelDto);
    return new ResponseData(
      true,
      { message: 'Create a new call channel successfully' },
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
    await this.callChannelsService.updateMemberList(id, userId.toString());
    return new ResponseData(
      true,
      { message: 'Update member list successfully' },
      null,
    );
  }

  @ApiOperation({
    summary: 'Owner deletes a call channel by ID',
    description: 'Owner deletes a call channel by ID',
  })
  @ApiOkResponse({ description: 'Delete a call channel by ID successfully' })
  @ApiBadRequestResponse({ description: 'Delete a call channel by ID failed' })
  @ApiNotFoundResponse({ description: "Can't find call channel to delete" })
  @Delete(':id')
  async remove(@Req() request, @Param('id') callChannelId: string) {
    const { _id: hostId } = request.user;
    await this.callChannelsService.remove(callChannelId, hostId);
    return new ResponseData(
      true,
      { message: 'Delete a call channel by ID successfully' },
      null,
    );
  }
}
