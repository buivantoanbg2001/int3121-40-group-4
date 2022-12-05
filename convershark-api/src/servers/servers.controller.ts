import {
  Controller,
  Post,
  Body,
  Param,
  Delete,
  UseGuards,
  Req,
  Patch,
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
import ResponseData from 'src/utils/response-data';
import { ServersService } from './servers.service';
import { CreateServerDto, UpdateServerDto } from './dto';

@ApiTags('Servers')
@ApiBearerAuth()
@ApiForbiddenResponse({ description: 'Permission denied' })
@UseGuards(AuthGuard('jwt'))
@Controller('servers')
export class ServersController {
  constructor(private readonly serversService: ServersService) {}

  // CREATE A NEW SERVER
  @ApiOperation({
    summary: 'Create a new server',
    description: 'Create a new server',
  })
  @ApiOkResponse({ description: 'Create a new server successfully' })
  @ApiBadRequestResponse({ description: 'Create a new server failed' })
  @Post()
  async create(@Req() req, @Body() createServerDto: CreateServerDto) {
    const { _id } = req.user;
    createServerDto.hostId = _id;
    return this.serversService.create(createServerDto);
  }

  // GET SERVER, MEMBER GET SERVER
  @ApiOperation({
    summary: 'Member get server information by ID',
    description: 'Member get server information by ID',
  })
  @ApiOkResponse({ description: 'Get server information successfully' })
  @ApiBadRequestResponse({ description: 'Get server informationi failed' })
  @Get(':id')
  async get(@Req() req, @Param('id') serverId: string) {
    const { _id } = req.user;
    return this.serversService.getWithMemberId(serverId, _id.toString());
  }

  // FROM RECEIVER, AUTO UPDATE MEMBER LIST WHEN RECEIVER ACCEPTED
  @ApiOperation({
    summary: 'From receiver, auto updates member list of server by ID',
    description: 'From receiver, auto updates member list of server by ID',
  })
  @ApiOkResponse({
    description:
      'From receiver, auto updates member list of server by ID successfully',
  })
  @ApiBadRequestResponse({
    description:
      'From receiver, auto updates member list of server by ID failed',
  })
  @Patch(':id/members')
  async addNewMember(@Req() request, @Param('id') id: string) {
    const { _id: userId } = request.user;
    await this.serversService.updateMemberList(id, userId);
    return new ResponseData(
      true,
      { message: 'Update member list successfully' },
      null,
    );
  }

  @ApiOperation({
    summary: 'Owner deletes a server by ID',
    description: 'Owner deletes a server by ID',
  })
  @ApiOkResponse({ description: 'Successfully deleted server' })
  @ApiNotFoundResponse({ description: "Can't find server to delete" })
  @Delete(':id')
  async remove(@Req() req, @Param('id') serverId: string) {
    const { _id: hostId } = req.user;
    await this.serversService.remove(serverId, hostId);
    return new ResponseData(
      true,
      { message: 'Delete a server by ID successfully' },
      null,
    );
  }
}
