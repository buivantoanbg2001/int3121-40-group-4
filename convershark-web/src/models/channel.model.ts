import { IMember } from 'models/member.model';
import { IMessage } from 'models/message.model';

interface IChannelMember {}

interface IChannel {
  _id: string;
  hostId: string;
  name: string;
  members: IMember[];
  createdAt: string;
}

export interface IShortChannel extends IChannel {
  type: 'chat' | 'call';
}

export interface IChatChannel extends IChannel {
  type: 'chat';
  messages: IMessage[];
}

export interface ICallChannel extends IChannel {
  type: 'call';
}
