import { Module } from '@nestjs/common';
import { ChatChannelsService } from './chat_channels.service';
import { ChatChannelsController } from './chat_channels.controller';
import { MongooseModule } from '@nestjs/mongoose';
import { ChatChannel, ChatChannelSchema } from 'src/schemas/chat_channels.schema';

@Module({
  imports: [MongooseModule.forFeature([{ name: ChatChannel.name, schema: ChatChannelSchema}])],
  controllers: [ChatChannelsController],
  providers: [ChatChannelsService]
})
export class ChatChannelsModule {}
