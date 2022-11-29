import React, { useState, useEffect } from 'react';
import { Col, Row, Typography } from 'antd';
import { IShortChannel } from 'models/channel.model';
import { BiHash, BiVolumeFull } from 'react-icons/bi';
import { useNavigate, useLocation } from 'react-router-dom';

const { Text } = Typography;

type Props = {
  serverId: string;
} & IShortChannel;

const ChannelListItem = ({ serverId, id, name, type }: Props) => {
  const navigate = useNavigate();
  const location = useLocation();

  return (
    <Row
      className={`channel-list-item-container  ${
        location.pathname.includes(`/${id}`) ? 'channel-list-item-container-selected' : ''
      }`}
      align={'middle'}
      onClick={() => navigate(`/channel/${serverId}/${id}`)}
    >
      <Col className="channel-icon">
        {type === 'chat' ? <BiHash size={20} /> : type === 'call' ? <BiVolumeFull size={20} /> : <></>}
      </Col>

      <Col className="channel-name">
        <Text className="channel-name-content" strong>
          {name}
        </Text>
      </Col>
    </Row>
  );
};

export default ChannelListItem;
