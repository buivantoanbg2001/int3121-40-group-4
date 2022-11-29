import { HttpException, Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import path from 'path';
import { Message, MessageDocument } from 'src/schemas/messages.schema';
import { User } from 'src/schemas/user.schema';
import { CreateMessageDto } from './dto/create-message.dto';
import { UpdateMessageDto } from './dto/update-message.dto';

@Injectable()
export class MessagesService {

  constructor(@InjectModel(Message.name) private messageModel: Model<MessageDocument>) {}

  private time = new Date();

  async create(createMessageDto: CreateMessageDto) {
    // get current miliseconds time and set to create_at
    createMessageDto.create_at = Date.now().toString();
    const message = new this.messageModel(createMessageDto);

    return message.save();
  }

  async findAll() {
    const messages = await this.messageModel.find()
    .populate('user_id', ['_uid', 'name', 'avatar'])
    .populate('reply_mes_id', ['_id', 'content'])
    .exec();

    return messages
  }

  async findOneByObjID(id: string) {
    const message = await (await (await this.messageModel.findOne({_id: id}))
    .populate('user_id', ['_uid', 'name', 'avatar']))
    .populate('reply_mes_id', ['_id', 'content']);
    
    // If content is null, return null
    if (!message.content) {
      return;
    }
    return message;
  }

  async update(id: string, updateMessageDto: UpdateMessageDto) {

    // update time, content
    if (updateMessageDto.content) {
      // get current miliseconds time and set to create_at
      updateMessageDto.update_at = Date.now().toString();
    }

    return this.messageModel.updateOne({_id: id}, updateMessageDto);
  }

  async remove(id: string) {
    const message = await this.messageModel.deleteOne({id}).exec();
    return message;
  }
}
