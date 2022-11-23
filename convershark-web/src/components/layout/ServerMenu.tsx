import { useEffect, useState } from 'react';
import { Avatar, Menu } from 'antd';
import { useNavigate, useLocation } from 'react-router-dom';
import { MenuInfo } from 'rc-menu/lib/interface';

const menuList = [
  {
    key: '/channel/54bh64hjb6j56565j34tr3',
    icon: <Avatar size={42}>A</Avatar>,
  },
  {
    key: '/channel/782734vgv4h3545hgvgv5g',
    icon: <Avatar size={42}>B</Avatar>,
  },
  {
    key: '/channel/87546vghv65hg6vg7jg3g4',
    icon: <Avatar size={42}>C</Avatar>,
  },
];

const ServerMenu: React.FC = props => {
  const navigate = useNavigate();
  let location = useLocation();
  const [current, setCurrent] = useState(location.pathname.replace(/\/+$/, ''));

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
