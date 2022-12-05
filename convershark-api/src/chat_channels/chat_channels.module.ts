import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { ServersModule } from 'src/servers/servers.module';
import { UsersModule } from 'src/users/users.module';
import { ChatChannelsController } from './chat_channels.controller';
import { ChatChannelsService } from './chat_channels.service';
import { ChatChannel, ChatChannelSchema } from './schemas';

@Module({
  imports: [
    MongooseModule.forFeature([
      { name: ChatChannel.name, schema: ChatChannelSchema },
    ]),
    ServersModule,
    UsersModule,
  ],
  controllers: [ChatChannelsController],
  providers: [ChatChannelsService],
  exports: [ChatChannelsService],
})
export class ChatChannelsModule {}
