import { HttpException, Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { ServersService } from 'src/servers/servers.service';
import { UsersService } from 'src/users/users.service';
import { CreateCallChannelDto, UpdateCallChannelDto } from './dto';
import { CallChannel, CallChannelDocument } from './schemas';

@Injectable()
export class CallChannelsService {
  constructor(
    @InjectModel(CallChannel.name)
    private callChannelModel: Model<CallChannelDocument>,
    private serversService: ServersService,
    private usersService: UsersService,
  ) {}

  async create(createCallChannelDto: CreateCallChannelDto) {
    const { hostId, serverId } = createCallChannelDto;
    const server = await this.serversService.findWithHostId(serverId, hostId);

    if (!server) {
      return null;
    }

    const callChannel = new this.callChannelModel(createCallChannelDto);
    callChannel.members.push(hostId);
    await callChannel.save();

    const newCallChannelList = [callChannel._id].concat(server.callChannels);
    return this.serversService.updateChannelList(serverId, {
      callChannels: newCallChannelList,
    });
  }

  // GET ONE, WITH AUTHENTIC MEMBERS | HOST
  async getWithMemberId(_id: string, requestorId: string) {
    const callChannel = await this.callChannelModel.findById(_id).lean().exec();

    if (!callChannel) {
      throw new HttpException(`CallChannel with id: ${_id} not found`, 404);
    }

    const isMember = callChannel.members.some(
      (member) => member.toString() === requestorId,
    );

    if (isMember) {
      const callChannel = await this.callChannelModel
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

      if (!callChannel) {
        return null;
      }
      return callChannel;
    }
    return null;
  }

  // ADD A NEW USER TO MEMBER LIST
  // - need to check the members are not duplicated
  //      + check when adding member to member list
  async updateMemberList(_id: string, userId: string) {
    const chatChannel = await this.callChannelModel.findById(_id).lean().exec();
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
    return this.callChannelModel.updateOne({ _id }, { members: newMembers });
  }

  async remove(_id: string, hostId: string) {
    const channel = await this.callChannelModel
      .deleteOne({ _id, hostId })
      .exec();
    if (channel.deletedCount === 0) {
      throw new HttpException('Không tồn tại call channel', 404);
    }
    return channel;
  }
}
