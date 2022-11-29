import { HttpException, Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { ChatChannel } from 'src/schemas/chat_channels.schema';
import { CreateChatChannelDto } from './dto/create-chat_channel.dto';
import { UpdateChatChannelDto } from './dto/update-chat_channel.dto';

@Injectable()
export class ChatChannelsService {

  constructor(@InjectModel(ChatChannel.name) private chatChannelModel: Model<ChatChannel>) {}

  async create(createChatChannelDto: CreateChatChannelDto): Promise<any> {
    const chat_channel = new this.chatChannelModel(createChatChannelDto);
    return chat_channel.save();
  }

  async findAll(): Promise<any> {
    const chat_channels = await this.chatChannelModel.find()
    .populate('members',['_uid', 'name', 'avatar'])
    .populate('messages')
    .exec();

    return chat_channels;
  }

  async findOne(id: string) {
    const chat_channel = await this.chatChannelModel.findOne({id})
    .populate('members',['_uid', 'name', 'avatar'])
    .populate('messages')
    .exec();

    return chat_channel;
  }

  async update(id: string, updateChatChannelDto: UpdateChatChannelDto) {
    const cc = this.chatChannelModel.findOne({_id: id}).exec();
    
    // add new member to group chat
    if (updateChatChannelDto.members) {
      updateChatChannelDto.members = updateChatChannelDto.members.concat((await cc).members);
    }

    // add new message
    if (updateChatChannelDto.messages) {
      updateChatChannelDto.messages = updateChatChannelDto.messages.concat((await cc).messages);
    }

    return this.chatChannelModel.findOneAndUpdate({_id: id}, updateChatChannelDto);
  }

  async remove(id: string) {
    const chat_channel = await this.chatChannelModel.deleteOne({id}).exec();
    if (chat_channel.deletedCount === 0) {
      throw new HttpException("Not Found", 404);
    }
    return chat_channel;
  }
}
