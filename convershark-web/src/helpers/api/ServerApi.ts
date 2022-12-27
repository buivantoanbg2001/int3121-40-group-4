import { API } from 'helpers/contains/api.constants';
import AxiosClient from './AxiosClient';

const ServerApi = {
  create: (data: { name: string }) => {
    const url = API.SERVERS;
    return AxiosClient.post(url, data);
  },
  updateMember: (serverId: string) => {
    const url = `${API.SERVERS}/${serverId}/members`;
    return AxiosClient.patch(url);
  },
};

export default ServerApi;
