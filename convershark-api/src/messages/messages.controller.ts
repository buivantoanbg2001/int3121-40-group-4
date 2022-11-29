import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { MessagesService } from './messages.service';
import { CreateMessageDto } from './dto/create-message.dto';
import { UpdateMessageDto } from './dto/update-message.dto';
import { ApiNotFoundResponse, ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { Message } from 'src/schemas/messages.schema';

@ApiTags('messages')
@Controller('messages')
export class MessagesController {
  constructor(private readonly messagesService: MessagesService) {}

  @ApiOkResponse({description: "Successfully created message"})
  @Post()
  async create(@Body() createMessageDto: CreateMessageDto) {
    return this.messagesService.create(createMessageDto);
  }

  @ApiOkResponse({isArray: true, description: "Successfully returned all messages"})
  @Get()
  findAll() {
    return this.messagesService.findAll();
  }

  @ApiOkResponse({description: "Successfully finded message by Id"})
  @ApiNotFoundResponse({description: "Can't find. The message's id doesn't exits"})
  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.messagesService.findOneByObjID(id);
  }

  @ApiOkResponse({description: "Successfully updated message's content"})
  @Patch(':id')
  update(@Param('id') id: string, @Body() updateMessageDto: UpdateMessageDto) {
    return this.messagesService.update(id, updateMessageDto);
  }

  @ApiOkResponse({description: "Successfully deleted message"})
  @ApiNotFoundResponse({description: "Can't find message to delete"})
  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.messagesService.remove(id);
  }
}
