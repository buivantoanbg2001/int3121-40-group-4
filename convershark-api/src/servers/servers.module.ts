import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';

import { ServersService } from './servers.service';
import { ServersController } from './servers.controller';
import { Server, ServerSchema } from './schemas';
import { UsersService } from 'src/users/users.service';
import { JwtService } from '@nestjs/jwt';
import { UsersModule } from 'src/users/users.module';

@Module({
  imports: [
    MongooseModule.forFeature([{ name: Server.name, schema: ServerSchema }]),
    UsersModule,
  ],
  controllers: [ServersController],
  providers: [ServersService, JwtService],
  exports: [ServersService],
})
export class ServersModule {}
