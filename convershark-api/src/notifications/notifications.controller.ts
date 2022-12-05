import {
  Controller,
  Get,
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

import { NotificationsService } from './notifications.service';
import { CreateNotificationDto } from './dto/create-notification.dto';

import ResponseData from 'src/utils/response-data';

@ApiTags('Notifications')
@ApiBearerAuth()
@ApiForbiddenResponse({ description: 'Permisstion denied' })
@UseGuards(AuthGuard('jwt'))
@Controller('notifications')
export class NotificationsController {
  constructor(private readonly notificationsService: NotificationsService) {}

  @ApiOperation({
    summary: 'Create a new notification',
    description: 'Create a new notification',
  })
  @ApiOkResponse({ description: 'Create a new notification successfully' })
  @ApiBadRequestResponse({ description: 'Create a new notification failed' })
  @Post()
  async create(
    @Req() req,
    @Body() createNotificationDto: CreateNotificationDto,
  ) {
    const { _id } = req.user;
    createNotificationDto.sender = _id.toString();
    const notification = await this.notificationsService.create(
      createNotificationDto,
    );
    return notification;
  }

  @ApiOperation({
    summary: 'Retrieve all your notifications',
    description: 'Retrieve all your notifications',
  })
  @ApiOkResponse({
    description: 'Retrieve all your notifications successfully',
  })
  @ApiBadRequestResponse({
    description: 'Retrieve all your notifications denied',
  })
  @Get()
  async getAllForReceiver(@Req() req) {
    const { _id } = req.user;
    return await this.notificationsService.findAllForReceiver(_id.toString());
  }

  @ApiOperation({
    summary:
      'Search and retrieve a message by ID, with recipient authentication',
    description:
      'Search and retrieve a message by ID, with recipient authentication',
  })
  @ApiOkResponse({
    description:
      'Successfully retrieved a message by ID, with recipient authentication',
  })
  @ApiBadRequestResponse({
    description:
      'Error retrieving a message by ID, with recipient authentication',
  })
  @Get(':id')
  async getOnebyId(@Req() req, @Param('id') _notiId: string) {
    const { _id } = req.user;
    return await this.notificationsService.findOne(_notiId, _id.toString());
  }

  @ApiOperation({
    summary: 'Owner deletes a notification by ID',
    description: 'Owner deletes a notification by ID',
  })
  @ApiOkResponse({
    description: 'Delete successfully',
  })
  @ApiBadRequestResponse({
    description: 'Delete failed',
  })
  @Delete(':id')
  async remove(@Req() req, @Param('id') _notiId: string) {
    const { _id } = req.user;
    await this.notificationsService.remove(_notiId, _id.toString());
    return new ResponseData(
      true,
      { message: 'Delete notification successfully' },
      null,
    );
  }
}
