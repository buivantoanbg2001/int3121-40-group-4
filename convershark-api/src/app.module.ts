import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { AuthModule } from './authentication/auth.module';
import { CallChannelsModule } from './call_channels/call_channels.module';
import { ChatChannelsModule } from './chat_channels/chat_channels.module';
import { MessagesModule } from './messages/messages.module';
import { NotificationsModule } from './notifications/notifications.module';
import { ServersModule } from './servers/servers.module';
import { UsersModule } from './users/users.module';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { ScheduleModule } from '@nestjs/schedule';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    MongooseModule.forRoot(
      // process.env.DATABASE_URL
      'mongodb://localhost/convershark-database',
    ),
    ScheduleModule.forRoot(),
    AuthModule,
    UsersModule,
    CallChannelsModule,
    MessagesModule,
    ChatChannelsModule,
    ServersModule,
    NotificationsModule,
    ConfigModule,
  ],
  providers: [ConfigService],
})
export class AppModule {}
