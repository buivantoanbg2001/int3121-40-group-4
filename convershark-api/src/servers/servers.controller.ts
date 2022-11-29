import { Controller, Get, Post, Body, Patch, Param, Delete, NotFoundException } from '@nestjs/common';
import { ServersService } from './servers.service';
import { CreateServerDto } from './dto/create-server.dto';
import { UpdateServerDto } from './dto/update-server.dto';
import { ApiNotFoundResponse, ApiOkResponse, ApiTags } from '@nestjs/swagger';

@ApiTags('servers')
@Controller('servers')
export class ServersController {
  constructor(private readonly serversService: ServersService) {}

  @ApiOkResponse({description: "Successfully created server"})
  @Post()
  create(@Body() createServerDto: CreateServerDto) {
    return this.serversService.create(createServerDto);
  }

  @ApiOkResponse({isArray: true, description: "Successfully returned all servers"})
  @Get()
  findAll() {
    return this.serversService.findAll();
  }

  @ApiOkResponse({description: "Successfully finded server by Id"})
  @ApiNotFoundResponse({description: "Can't find. The server's id doesn't exits"})
  @Get(':id')
  findOne(@Param('id') id: string) {
    const server = this.serversService.findOne(id);
    if (!server) {
      throw new NotFoundException("The server's id doesn't exist")
    }
    return server;
  }

  @ApiOkResponse({description: "Successfully updated server's content"})
  @Patch(':id')
  update(@Param('id') id: string, @Body() updateServerDto: UpdateServerDto) {
    return this.serversService.update(id, updateServerDto);
  }

  @ApiOkResponse({description: "Successfully deleted server"})
  @ApiNotFoundResponse({description: "Can't find server to delete"})
  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.serversService.remove(id);
  }
}
