import { IFriend } from 'models/friend.model';
import { IServer } from 'models/server.model';

export type StatusType = 'Online' | 'Offline';

export interface IUser {
  _id: string;
  _uid: string;
  name: string;
  email: string;
  status: StatusType;
  wallpaper: string;
  avatar: string;
  bio: string;
  friends: IFriend[];
  servers: IServer[];
  createdAt: string;
}
