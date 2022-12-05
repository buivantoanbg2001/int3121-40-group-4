import { ICallChannel, IChatChannel } from 'models/channel.model';

export interface IServer {
  _id: string;
  hostId: string;
  name: string;
  wallpaper: string;
  chatChannels: IChatChannel[];
  callChannels: ICallChannel[];
  createdAt: string;
}
