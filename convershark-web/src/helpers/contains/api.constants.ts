const DOMAIN_API = `${process.env.REACT_APP_DOMAIN_API}`;

export const AxiosClientConfig = {
  DOMAIN_API: DOMAIN_API,
  AUTH_TYPES: 'Bearer',
  CONTENT_TYPE: 'application/json',
};

export const API = {
  LOGIN: '/login',
  USERS: '/users',
  USERS_ME: '/users/me/management',
  USERS_UPDATE_FRIEND_BOTH: '/users/friends/update-both',
  CHAT_CHANNELS: '/chat-channels',
  MESSAGES: '/messages',
  NOTIFICATIONS: '/notifications',
  SERVERS: '/servers',
};
