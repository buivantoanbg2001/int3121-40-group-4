import { PartialType } from '@nestjs/mapped-types';
import { CreateCallChannelDto } from './create-call_channel.dto';

export class UpdateCallChannelDto extends PartialType(CreateCallChannelDto) {}
