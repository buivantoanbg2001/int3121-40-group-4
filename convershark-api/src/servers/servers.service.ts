import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Server, ServerDocument } from 'src/schemas/servers.schema';
import { CreateServerDto } from './dto/create-server.dto';

@Injectable()
export class ServersService {
  constructor(
    @InjectModel(Server.name) private serverModel: Model<ServerDocument>,
  ) {}

  async create(createServerDto: CreateServerDto) {
    const server = new this.serverModel(createServerDto);
    return server.save();
  }

  async remove(_id: string, hostId: string) {
    const server = await this.serverModel.deleteOne({ _id, hostId }).exec();
    return server;
  }
}
