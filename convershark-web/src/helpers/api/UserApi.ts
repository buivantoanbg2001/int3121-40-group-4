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
};

export default UserApi;
