import { API } from 'helpers/contains/api.constants';
import AxiosClient from './AxiosClient';

export interface LoginType {
  email: string;
  password: string;
}

const UserApi = {
  getMyInfo: () => {
    const url = API.USERS_ME;
    return AxiosClient.get(url);
  },
  updateFriendBoth: (friendId: string) => {
    const url = `${API.USERS_UPDATE_FRIEND_BOTH}/${friendId}`;
    return AxiosClient.patch(url);
  },
};

export default UserApi;
