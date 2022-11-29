import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { ApiNotFoundResponse, ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { CallChannelsService } from './call_channels.service';
import { CreateCallChannelDto } from './dto/create-call_channel.dto';
import { UpdateCallChannelDto } from './dto/update-call_channel.dto';

@ApiTags('call-channels')
@Controller('call-channels')
export class CallChannelsController {
  constructor(private readonly callChannelsService: CallChannelsService) {}

  @ApiOkResponse({description: "Successfully create call channel"})
  @Post()
  create(@Body() createCallChannelDto: CreateCallChannelDto) {
    return this.callChannelsService.createCallChannel(createCallChannelDto);
  }

  @ApiOkResponse({isArray: true, description: "Successfully returned all call channels"})
  @Get()
  findAll() {
    return this.callChannelsService.findAll();
  }

  @ApiOkResponse({description: "Successfully finded call channels by Id"})
  @ApiNotFoundResponse({description: "Can't find. The call channel's id doesn't exits"})
  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.callChannelsService.findOne(id);
  }

  @ApiOkResponse({description: "Successfully updated call channel's content"})
  @Patch(':id')
  update(@Param('id') id: string, @Body() updateCallChannelDto: UpdateCallChannelDto) {
    return this.callChannelsService.update(id, updateCallChannelDto);
  }

  @ApiOkResponse({description: "Successfully deleted call channel"})
  @ApiNotFoundResponse({description: "Can't find call channel to delete"})
  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.callChannelsService.remove(id);
  }
}
