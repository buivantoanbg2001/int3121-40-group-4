import { StatusType } from 'models/user.model';

export interface IMember {
  _id: string;
  _uid: string;
  status: StatusType;
  wallpaper: string;
  avatar: string;
  bio: string;
}
