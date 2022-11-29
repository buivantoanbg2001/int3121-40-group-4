import { HttpException, Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Notification, NotificationDocument } from 'src/schemas/notifications.schema';
import { CreateNotificationDto } from './dto/create-notification.dto';
import { UpdateNotificationDto } from './dto/update-notification.dto';

@Injectable()
export class NotificationsService {

  constructor(@InjectModel(Notification.name) private notificationModel: Model<NotificationDocument>) {}

  async create(createNotificationDto: CreateNotificationDto) {
    // return 'This action adds a new notification';
    const notification = new this.notificationModel(createNotificationDto);
    return notification.save();
  }

  async findAll() {
    const notifications = await this.notificationModel.find().exec();
    if (!notifications || !notifications[0]) {
      throw new HttpException("Not Found", 404);
    }
    return notifications;
  }

  async findOne(id: string) {
    const notification = await this.notificationModel.findOne({id}).exec();
    if (!notification) {
      throw new HttpException("Not Found", 404);
    }
    return notification;
  }

  async update(id: string, updateNotificationDto: UpdateNotificationDto) {
    return `This action updates a #${id} notification`;
  }

  async remove(id: string) {
    const notification = await this.notificationModel.deleteOne({id}).exec();
    if (notification.deletedCount === 0) {
      throw new HttpException("Not Found", 404);
    }
    return notification;
  }
}
