interface INotificationSender {
  _id: string;
  name: string;
  avatar: string;
  _uid: string;
}

export interface INotification {
  _id: string;
  sender: INotificationSender;
  receiver: string;
  type: 'FRIEND' | 'SERVER' | 'CHAT' | 'CALL' | 'MESSAGE';
  serverId: {
    _id: string;
    name: string;
  };
  chatId: {
    _id: string;
    name: string;
  };
  callId: {
    _id: string;
    name: string;
  };
  isResponse: boolean;
  isAccept: boolean;
  createdAt: string;
  updatedAt: string;
}
