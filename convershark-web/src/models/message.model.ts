export interface IMessage {
  id: string;
  userId: string;
  content: string;
  createdAt: string;
  updatedAt: string;
  reply?: string;
}
