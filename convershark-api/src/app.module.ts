import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { UsersModule } from './users/users.module';
import { CallChannelsModule } from './call_channels/call_channels.module';
import { MessagesModule } from './messages/messages.module';
import { ChatChannelsModule } from './chat_channels/chat_channels.module';
import { ServersModule } from './servers/servers.module';
import { NotificationsModule } from './notifications/notifications.module';
import { ConfigModule} from '@nestjs/config'

@Module({
  imports: [
    ConfigModule.forRoot(
      {
        isGlobal: true,
      }
    ),
    MongooseModule.forRoot(
      'mongodb://localhost/convershark_api'
    ),
    UsersModule,
    CallChannelsModule,
    MessagesModule,
    ChatChannelsModule,
    ServersModule,
    NotificationsModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
