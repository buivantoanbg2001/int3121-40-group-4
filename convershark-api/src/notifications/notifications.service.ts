import {
  ForbiddenException,
  HttpException,
  HttpStatus,
  Injectable,
} from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { UsersService } from 'src/users/users.service';
import { CreateNotificationDto } from './dto/create-notification.dto';
import { Notification, NotificationDocument } from './schemas';

@Injectable()
export class NotificationsService {
  constructor(
    @InjectModel(Notification.name)
    private notificationModel: Model<NotificationDocument>,
    private userServices: UsersService,
  ) {}

  // CREATE A NEW NOTIFICATION
  async create(createNotificationDto: CreateNotificationDto) {
    try {
      let receiver;

      if (createNotificationDto.friendUID) {
        receiver = await this.userServices.findByNameID(
          createNotificationDto.friendUID,
        );
        createNotificationDto.receiver = receiver._id.toString();
      } else if (createNotificationDto.receiver) {
        receiver = await this.userServices.findByObjID(
          createNotificationDto.receiver,
        );
      }

      if (!receiver) {
        return "Can't find receiver";
      }

      const notification = await new this.notificationModel(
        createNotificationDto,
      );
      await notification.save();
      return notification;
    } catch (err) {
      throw new HttpException('Something went wrong', err);
    }
  }

  // FIND ALL NOTI OF ONE USER
  async findAllForReceiver(userId: string) {
    // console.log(userId);
    const notifications = await this.notificationModel
      .find({
        receiver: userId,
      })
      .lean()
      .populate('sender', ['_uid', 'name', 'avatar'])
      .populate('serverId', ['name', 'hostId'])
      .populate('chatId', ['name'])
      .populate('callId', ['name'])
      .exec();
    if (!notifications || !notifications[0]) {
      return [];
    }
    return notifications;
  }

  // FIND ONE NOTIFICATION
  async findOne(_notiId: string, requestorId: string) {
    // console.log(_notiId, requestId);
    const notification = await this.notificationModel
      .findOne({ _id: _notiId, receiver: requestorId })
      .lean()
      .populate('sender', ['_uid', 'name', 'avatar'])
      .exec();
    if (!notification) {
      throw new HttpException('Notification not found', 404);
    }
    return notification;
  }

  // REMOVE A NOTIFICATION
  async remove(_notiId: string, requestId: string) {
    // console.log(requestId);
    const notification = await this.notificationModel
      .deleteOne({ _id: _notiId, receiver: requestId })
      .exec();
    if (notification.deletedCount === 0) {
      throw new HttpException('Notification not found', 404);
    }
    return notification;
  }
}
