import React, { useEffect, useState } from 'react';
import { Avatar, Menu } from 'antd';
import { useNavigate, useLocation } from 'react-router-dom';
import { MenuInfo } from 'rc-menu/lib/interface';
import { useSelector, useDispatch } from 'react-redux';
import { setMyInfo, userValue } from 'slices/userSlice';
import UserApi from 'helpers/api/UserApi';
import { getAvatar } from 'helpers/fakeAvatar';
import { IUser } from 'models/user.model';
import { IServer } from 'models/server.model';

const ServerMenu: React.FC = props => {
  const navigate = useNavigate();
  const userData = useSelector(userValue);
  let location = useLocation();
  const dispatch = useDispatch();
  const [current, setCurrent] = useState(location.pathname.replace(/\/+$/, ''));
  const menuList = userData.user?.servers.map((item, index) => ({
    key: `/channels/${item._id}`,
    icon: <Avatar src={item.wallpaper} size={42} />,
  }));

  useEffect(() => {
    UserApi.getMyInfo().then(res => {
      const user: IUser = res.data;
      const serverData = user.servers.map((item, index) => ({
        ...item,
        wallpaper: getAvatar(index),
        chatChannels: item.chatChannels.map(i => ({ ...i, type: 'chat' })),
        callChannels: item.callChannels.map(i => ({ ...i, type: 'call' })),
      }));
      dispatch(setMyInfo({ ...user, servers: serverData as IServer[] }));
    });
  }, []);

  useEffect(() => {
    var tmpPath = location.pathname.replace(/\/+$/, '');
    tmpPath = tmpPath.split('/').slice(0, 3).join('/');

    if (location) {
      if (current !== tmpPath) {
        setCurrent(tmpPath);
      }
    }
  }, [location]);

  const onClick = (e: MenuInfo) => {
    setCurrent(e.key);
    navigate(e.key);
  };

  return <Menu mode="inline" selectedKeys={[current]} items={menuList} onClick={e => onClick(e)} />;
};

export default ServerMenu;
