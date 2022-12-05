import {
  Controller,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  UseGuards,
  Req,
} from '@nestjs/common';

import {
  ApiBadRequestResponse,
  ApiBearerAuth,
  ApiForbiddenResponse,
  ApiOkResponse,
  ApiOperation,
  ApiTags,
} from '@nestjs/swagger';

import { AuthGuard } from '@nestjs/passport';

import { MessagesService } from './messages.service';
import { CreateMessageDto, UpdateMessageDto } from './dto';

import ResponseData from 'src/utils/response-data';

@ApiTags('Messages')
@ApiBearerAuth()
@ApiForbiddenResponse({ description: 'Permission denied' })
@UseGuards(AuthGuard('jwt'))
@Controller()
export class MessagesController {
  constructor(private readonly messagesService: MessagesService) {}

  // CREATE A NEW MESSAGE
  @ApiOperation({
    summary: 'Create a new message',
    description: 'Create a new message',
  })
  @ApiOkResponse({ description: 'Create a new message successfully' })
  @ApiBadRequestResponse({ description: 'Create a new message failed' })
  @Post('messages')
  async createNewMessage(
    @Req() req,
    @Body() createMessageDto: CreateMessageDto,
  ) {
    //  Assign owner of message
    const { _id } = req.user;
    createMessageDto.ownerId = _id;

    const message = this.messagesService.create(createMessageDto);
    return message;
  }

  // OWNER UPDATE MESSAGE'S CONTENT
  @ApiOperation({
    summary: 'Owner updates the message content by ID',
    description: 'Owner updates the message content by ID',
  })
  @ApiOkResponse({
    description: 'Owner update message content successfully',
  })
  @ApiBadRequestResponse({
    description: 'Owner update message content failed',
  })
  @Patch('messages/:id')
  async updateContentMessage(
    @Param('id') mesId: string,
    @Req() req,
    @Body() updateMesageDto: UpdateMessageDto,
  ) {
    // get the Id of user who request edit content
    const { _id } = req.user;
    await this.messagesService.update(mesId, _id, updateMesageDto);
    return new ResponseData(
      true,
      { message: 'Update message content successfully' },
      null,
    );
  }

  // OWNER DELETE MESSAGE'ID
  @ApiOperation({
    summary: 'Owner deletes a message by ID',
    description: 'Owner deletes a message by ID',
  })
  @ApiOkResponse({
    description: 'Owner deletes a message by ID succefully',
  })
  @ApiBadRequestResponse({
    description: 'Owner deletes a message by ID failed',
  })
  @Delete('messages/:id')
  async remove(@Param('id') mesId: string, @Req() req) {
    const { _id } = req.user;
    await this.messagesService.remove(mesId, _id);
    return new ResponseData(
      true,
      { message: 'Delete message content successfully' },
      null,
    );
  }
}
