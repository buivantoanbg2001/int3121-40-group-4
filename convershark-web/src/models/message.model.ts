interface IMessageOwner {
  _id: string;
  name: string;
  avatar: string;
}

export interface IMessage {
  _id: string;
  ownerId: IMessageOwner;
  content: string;
  createdAt: string;
  updatedAt: string;
}
