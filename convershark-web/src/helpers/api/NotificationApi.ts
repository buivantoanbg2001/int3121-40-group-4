import { API } from 'helpers/contains/api.constants';
import AxiosClient from './AxiosClient';

const NotificationApi = {
  getAll: () => {
    const url = API.NOTIFICATIONS;
    return AxiosClient.get(url);
  },
  create: (data: {
    friendUID?: string;
    receiver?: string;
    type: 'CALL' | 'CHAT' | 'SERVER' | 'MESSAGE' | 'FRIEND';
    chatId?: string;
    serverId?: string;
  }) => {
    const url = API.NOTIFICATIONS;
    return AxiosClient.post(url, data);
  },
  update: (notificationId: string, data: { isResponse: boolean; isAccept: boolean }) => {
    const url = `${API.NOTIFICATIONS}/${notificationId}`;
    return AxiosClient.patch(url, data);
  },
};

export default NotificationApi;
