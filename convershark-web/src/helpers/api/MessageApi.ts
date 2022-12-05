import { API } from 'helpers/contains/api.constants';
import AxiosClient from './AxiosClient';

const MessageApi = {
  send: (chatChannelId: string, content: string) => {
    const url = API.MESSAGES;
    return AxiosClient.post(url, { chatChannelId, content });
  },
};

export default MessageApi;
