import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { ApiNotFoundResponse, ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { ChatChannelsService } from './chat_channels.service';
import { CreateChatChannelDto } from './dto/create-chat_channel.dto';
import { UpdateChatChannelDto } from './dto/update-chat_channel.dto';

@ApiTags('chat-channels')
@Controller('chat-channels')
export class ChatChannelsController {
  constructor(private readonly chatChannelsService: ChatChannelsService) {}

  @ApiOkResponse({description: "Successfully create chat channel"})
  @Post()
  create(@Body() createChatChannelDto: CreateChatChannelDto) {
    return this.chatChannelsService.create(createChatChannelDto);
  }

  @ApiOkResponse({isArray: true, description: "Successfully returned all chat channels"})
  @Get()
  findAll() {
    return this.chatChannelsService.findAll();
  }


  @ApiOkResponse({description: "Successfully finded chat channels by Id"})
  @ApiNotFoundResponse({description: "Can't find. The chat channel's id doesn't exits"})
  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.chatChannelsService.findOne(id);
  }

  @ApiOkResponse({description: "Successfully updated chat channel's content"})
  @Patch(':id')
  update(@Param('id') id: string, @Body() updateChatChannelDto: UpdateChatChannelDto) {
    return this.chatChannelsService.update(id, updateChatChannelDto);
  }

  @ApiOkResponse({description: "Successfully deleted chat channel"})
  @ApiNotFoundResponse({description: "Can't find chat channel to delete"})
  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.chatChannelsService.remove(id);
  }
}
