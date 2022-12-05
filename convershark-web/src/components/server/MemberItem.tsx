import React from 'react';
import { Avatar, Button, Col, Row, Typography } from 'antd';
import { IFriend } from 'models/friend.model';

const { Text } = Typography;

type Props = {
  data: IFriend;
  onInvite: (friendId: string) => void;
};

const MemberItem = ({ data, onInvite }: Props) => {
  return (
    <Row className="member-item-container" align={'middle'} justify="space-between">
      <Col>
        <Avatar src={data.avatar} size={36} style={{ marginRight: 12 }} />
        <Text strong>{data._uid}</Text>
      </Col>
      <Col>
        <Button type="primary" className="invite-button" onClick={() => onInvite(data._id)}>
          Mời
        </Button>
      </Col>
    </Row>
  );
};

export default MemberItem;
