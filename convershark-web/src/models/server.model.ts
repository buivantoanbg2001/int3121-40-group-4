import { IShortChannel } from 'models/channel.model';
import { IUser } from 'models/user.model';

export interface IServer {
  id: string;
  name: string;
  bannerProfile: string;
  members: IUser[];
  channels: IShortChannel[];
}
