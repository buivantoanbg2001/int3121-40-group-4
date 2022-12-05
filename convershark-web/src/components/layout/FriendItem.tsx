import React from 'react';
import { Avatar, Badge, Col, Row, Typography } from 'antd';
import { IFriend } from 'models/friend.model';

const { Text } = Typography;

type Props = {
  data: IFriend;
};

const FriendItem = ({ data }: Props) => {
  return (
    <Row align={'middle'} justify="space-between">
      <Col>
        <Badge status={data.status == 'Online' ? 'success' : 'default'} dot offset={[-8, 32]}>
          <Avatar src={data.avatar} size={36} style={{ marginRight: 12 }} />
        </Badge>
        <Text strong>{data._uid}</Text>
      </Col>
    </Row>
  );
};

export default FriendItem;
