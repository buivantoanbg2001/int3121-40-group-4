import {
  ForbiddenException,
  HttpException,
  HttpStatus,
  Injectable,
} from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { ChatChannelsService } from 'src/chat_channels/chat_channels.service';
import { CreateMessageDto, UpdateMessageDto } from './dto';
import { Message, MessageDocument } from './schemas';

@Injectable()
export class MessagesService {
  constructor(
    @InjectModel(Message.name) private messageModel: Model<MessageDocument>,
    private chatChannelsService: ChatChannelsService,
  ) {}

  async create(createMessageDto: CreateMessageDto) {
    // confirm found chat channel
    const { chatChannelId } = createMessageDto;

    const chatChannel = await this.chatChannelsService.findOne(chatChannelId);

    if (!chatChannel) {
      return null;
    }

    // create new message
    const message = await this.messageModel.create(createMessageDto);
    // add and update list message of chat channel
    const newChatList = [message._id].concat(chatChannel.messages);
    this.chatChannelsService.updateMessageList(chatChannelId, {
      messages: newChatList,
    });

    return message.save();
  }

  async findOneByObjID(id: string) {
    try {
      const message = await this.messageModel
        .findOne({ _id: id })
        .populate('ownerId', ['_uid', 'name', 'avatar'])
        .populate('replyMessageId', ['_id', 'content']);
      return message;
    } catch (err) {
      if (err.code == 404) {
        throw new ForbiddenException('Message not found');
      }
      throw new HttpException('Something went wrong', err);
    }
  }

  // OWNER UPDATE MESSAGE
  async update(
    mesId: string,
    ownerId: string,
    updateMessageDto: UpdateMessageDto,
  ) {
    try {
      const message = await this.messageModel.findOneAndUpdate(
        { _id: mesId, ownerId: ownerId },
        updateMessageDto,
      );

      return message;
    } catch (err) {
      throw new HttpException('Something went wrong', err);
    }
  }

  // OWNER DELETE A MESSAGE BY ID
  async remove(mesId: string, _ownerId: string) {
    try {
      const message = await this.messageModel
        .deleteOne({ _id: mesId, ownerId: _ownerId })
        .exec();

      return message;
    } catch (err) {
      throw new HttpException('Something went wrong', err);
    }
  }
}
