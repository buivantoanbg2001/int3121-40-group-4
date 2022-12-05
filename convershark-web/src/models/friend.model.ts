import { StatusType } from 'models/user.model';

export interface IFriend {
  _id: string;
  _uid: string;
  name: string;
  email: string;
  status: StatusType;
  wallpaper: string;
  avatar: string;
  bio: string;
  createdAt: string;
}
