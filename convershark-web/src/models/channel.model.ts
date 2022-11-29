import { IMessage } from 'models/message.model';
import { IUser } from 'models/user.model';

interface IChannel {
  id: string;
  name: string;
  members: IUser[];
}

export interface IShortChannel {
  id: string;
  name: string;
  type: 'chat' | 'call';
}

export interface IChatChannel extends IChannel {
  type: 'chat';
  messages: IMessage[];
}

export interface ICallChannel extends IChannel {
  type: 'call';
}
