import React, { useState, useEffect } from 'react';
import { Col, Row, Typography } from 'antd';
import { useParams } from 'react-router-dom';
import { IServer } from 'models/server.model';
import ChannelListItem from 'components/server/ChannelListItem';
import ChannelDetail from 'components/server/ChannelDetail';

const { Text } = Typography;

type Props = {};

const fakeData: IServer = {
  id: 'dgdfg545vghvhg6',
  name: 'Our Community',
  bannerProfile:
    'https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg',
  members: [],
  channels: [
    {
      id: '123h453j45kl2',
      name: 'chào-mừng',
      type: 'chat',
    },
    {
      id: '545hjh54gf544',
      name: 'nội-quy',
      type: 'chat',
    },

    {
      id: '65gjy344d6hj5',
      name: 'họp-team',
      type: 'call',
    },
    {
      id: 'dhus643gfh434',
      name: 'chém-gió',
      type: 'call',
    },
  ],
};

const Server: React.FC = (props: Props) => {
  const { serverId, channelId } = useParams();
  const [server, setServer] = useState<IServer>();

  useEffect(() => {
    /**
     * @TODO call api get server info by serverId, then setServer()
     */
    setServer(fakeData);
  }, [serverId]);

  if (!serverId || !server) return <></>;

  return (
    <Row className="server-container">
      <Col className="channel-list-container">
        <Row className="channel-header">
          <Text className="server-name" strong>
            {server.name}
          </Text>
          <img className="banner-profile" src={server.bannerProfile} />
        </Row>

        {server.channels.map(item => (
          <Row key={item.id}>
            <ChannelListItem type={item.type} serverId={serverId} id={item.id} name={item.name} />
          </Row>
        ))}
      </Col>

      <Col className="channel-content-container">
        {channelId && <ChannelDetail id={channelId} serverId={serverId} />}
      </Col>
    </Row>
  );
};

export default Server;
