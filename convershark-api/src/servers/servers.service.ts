import { ForbiddenException, Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { UsersService } from 'src/users/users.service';
import { CreateServerDto, UpdateServerDto } from './dto';
import { Server, ServerDocument } from './schemas';

@Injectable()
export class ServersService {
  constructor(
    @InjectModel(Server.name) private serverModel: Model<ServerDocument>,
    private usersService: UsersService,
  ) {}

  // CREATE A NEW SERVER
  //    - need add the new server created to server list of host
  async create(createServerDto: CreateServerDto) {
    const { hostId } = createServerDto;
    const host = this.usersService.findByObjID(hostId);
    if (!host) {
      throw new ForbiddenException("User id wrong, can't create a server");
    }

    // create a new server
    const server = await new this.serverModel(createServerDto);
    server.members.push(hostId);
    await server.save();

    // host add this new server created to the server list
    return this.usersService.updateServerList(
      createServerDto.hostId,
      server._id.toString(),
    );
  }

  // FIND ONE, WITH AUTHENTIC HOST
  async findWithHostId(_id: string, hostId: string) {
    return this.serverModel.findOne({ _id, hostId }).lean().exec();
  }

  // GET ONE, WITH AUTHENTIC HOST || MEMBERS
  async getWithMemberId(_id: string, requestorId: string) {
    const server = await this.serverModel.findById(_id).lean().exec();

    if (!server) {
      throw new ForbiddenException('Server not found');
    }

    const isMember = server.members.some(
      (member) => member.toString() === requestorId,
    );

    if (isMember) {
      const server = await this.serverModel
        .findById(_id)
        .lean()
        .populate('chatChannels')
        .populate('callChannels')
        .exec();
      if (server) {
        return server;
      }
      return null;
    }
    throw new ForbiddenException('Permission denied');
  }

  // ADD A NEW USER TO MEMBER LIST
  // - need to check the members are not duplicated
  //      + check when adding member to member list
  async updateMemberList(_id: string, userId: string) {
    const server = await this.serverModel.findById({ _id }).lean().exec();
    const user = await this.usersService.findByObjID(userId);

    if (!server || !user) {
      return null;
    }

    // add this server to the user's server list
    this.usersService.updateServerList(userId, server._id.toString());

    // add this user to server's member list
    let newMembers = [userId].concat(server.members);
    const tmp = [];
    newMembers = newMembers.reduce((memberListNotDuplicate, element) => {
      if (!tmp.includes(element.toString())) {
        memberListNotDuplicate.push(element);
        tmp.push(element.toString());
      }
      return memberListNotDuplicate;
    }, []);

    return this.serverModel.updateOne({ _id }, { members: newMembers });
  }

  // ADD A NEW CHANNEL TO CHANNEL LIST
  // Don't need check channel is unique,
  // because the function is only called when a new channel is created
  async updateChannelList(_id: string, updateServerDto: UpdateServerDto) {
    return this.serverModel.updateOne({ _id }, updateServerDto);
  }

  async remove(_id: string, hostId: string) {
    const server = await this.serverModel.deleteOne({ _id, hostId }).exec();
    return server;
  }
}
