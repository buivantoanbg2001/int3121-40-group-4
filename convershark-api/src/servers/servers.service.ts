import { HttpException, Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Server, ServerDocument } from 'src/schemas/servers.schema';
import { CreateServerDto } from './dto/create-server.dto';
import { UpdateServerDto } from './dto/update-server.dto';

@Injectable()
export class ServersService {
  constructor(
    @InjectModel(Server.name) private serverModel: Model<ServerDocument>,
  ) {}

  async create(createServerDto: CreateServerDto) {
    const server = new this.serverModel(createServerDto);
    return server.save();
  }

  async findAll() {
    const servers = await this.serverModel
      .find()
      .lean()
      .populate('members', ['_uid', 'name', 'avatar'])
      .populate('chat_channels')
      .populate('call_channels')
      .exec();

    return servers;
  }

  async findOne(id: string) {
    const server = await this.serverModel
      .findOne({ id })
      .lean()
      .populate('members', ['_uid', 'name', 'avatar'])
      .populate('chat_channels')
      .populate('call_channels')
      .exec();

    return server;
  }

  async update(id: string, updateServerDto: UpdateServerDto) {
    const server = this.serverModel.findOne({ _id: id }).lean().exec();

    if (updateServerDto.members) {
      updateServerDto.members = updateServerDto.members.concat(
        (await server).members,
      );
    }

    if (updateServerDto.chatChannels) {
      updateServerDto.chatChannels = updateServerDto.chatChannels.concat(
        (await server).chatChannels,
      );
    }

    if (updateServerDto.callChannels) {
      updateServerDto.callChannels = updateServerDto.callChannels.concat(
        (await server).callChannels,
      );
    }

    return this.serverModel
      .findOneAndUpdate({ _id: id }, updateServerDto)
      .lean();
  }

  async remove(id: string) {
    const server = await this.serverModel.deleteOne({ id }).exec();

    return server;
  }
}
