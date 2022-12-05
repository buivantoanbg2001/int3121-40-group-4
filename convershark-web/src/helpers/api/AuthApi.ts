import { API } from 'helpers/contains/api.constants';
import AxiosClient from './AxiosClient';

export interface LoginType {
  email: string;
  password: string;
}

const AuthApi = {
  logIn: (data: LoginType) => {
    const url = API.LOGIN;
    return AxiosClient.post(url, data);
  },
};
export default AuthApi;
