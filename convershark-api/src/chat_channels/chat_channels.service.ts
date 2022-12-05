import { HttpException, Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { ServersService } from 'src/servers/servers.service';
import { UsersService } from 'src/users/users.service';
import { CreateChatChannelDto, UpdateChatChannelDto } from './dto';
import { ChatChannel, ChatChannelDocument } from './schemas';

@Injectable()
export class ChatChannelsService {
  constructor(
    @InjectModel(ChatChannel.name)
    private chatChannelModel: Model<ChatChannelDocument>,
    private serversService: ServersService,
    private usersService: UsersService,
  ) {}

  // HOST ADD NEW CHANNEL
  async create(createChatChannelDto: CreateChatChannelDto) {
    // only host can find server
    const { hostId, serverId } = createChatChannelDto;
    const server = await this.serversService.findWithHostId(serverId, hostId);
    if (!server) {
      return null;
    }

    // create a new channel
    const chatChannel = new this.chatChannelModel(createChatChannelDto);
    chatChannel.members.push(hostId);
    await chatChannel.save();

    // finded server will add this's new channel to list
    const newChatChannelList = [chatChannel._id].concat(server.chatChannels);
    return this.serversService.updateChannelList(serverId, {
      chatChannels: newChatChannelList,
    });
  }

  // GET ONE, WITH AUTHENTIC MEMBERS | HOST
  async getWithMemberId(_id: string, requestorId: string) {
    const chatChannel = await this.chatChannelModel.findById(_id).lean().exec();

    if (!chatChannel) {
      throw new HttpException(`ChatChannel with id: ${_id} not found`, 404);
    }

    const isMember = chatChannel.members.some(
      (member) => member.toString() === requestorId,
    );

    if (isMember) {
      const chatChannel = await this.chatChannelModel
        .findById({ _id })
        .lean()
        .populate('members', [
          '_id',
          '_uid',
          'avatar',
          'wallpaper',
          'bio',
          'createAt',
          'status',
        ])
        .populate({ path: 'messages', populate: 'ownerId' })
        .exec();

      if (!chatChannel) {
        return null;
      }
      return chatChannel;
    }
    return null;
  }

  async findOne(_id: string) {
    return this.chatChannelModel.findById(_id).lean().exec();
  }

  // ADD A NEW USER TO MEMBER LIST
  // - need to check the members are not duplicated
  //      + check when adding member to member list
  async updateMemberList(_id: string, userId: string) {
    const chatChannel = await this.chatChannelModel.findById(_id).lean().exec();
    const user = await this.usersService.findByObjID(userId);

    if (!chatChannel || !user) {
      return null;
    }

    // add this user to server's member list
    let newMembers = [userId].concat(chatChannel.members);
    const tmp = [];
    newMembers = newMembers.reduce((memberListNotDuplicate, element) => {
      if (!tmp.includes(element.toString())) {
        memberListNotDuplicate.push(element);
        tmp.push(element.toString());
      }
      return memberListNotDuplicate;
    }, []);
    return this.chatChannelModel.updateOne({ _id }, { members: newMembers });
  }

  // ADD A NEW USER TO MEMBER LIST
  // no need to check the members are not duplicated,
  // because this function called when creating a new message
  async updateMessageList(
    _id: string,
    updateChatChannelDto: UpdateChatChannelDto,
  ) {
    return this.chatChannelModel.updateOne({ _id }, updateChatChannelDto);
  }

  async remove(_id: string, hostId: string) {
    const channel = await this.chatChannelModel
      .deleteOne({ _id, hostId })
      .exec();
    if (channel.deletedCount === 0) {
      throw new HttpException('Không tồn tại chat channel', 404);
    }
    return channel;
  }
}
