import { API } from 'helpers/contains/api.constants';
import AxiosClient from './AxiosClient';

const ChatChannelApi = {
  getChatChannel: (chatChannelId: string) => {
    const url = `${API.CHAT_CHANNELS}/${chatChannelId}`;
    return AxiosClient.get(url);
  },
};

export default ChatChannelApi;
