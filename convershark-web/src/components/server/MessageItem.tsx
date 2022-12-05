import React, { useState, useEffect } from 'react';
import { Avatar, Col, Divider, Row, Typography } from 'antd';
import { IMessage } from 'models/message.model';
import { format, parseJSON } from 'date-fns';

const { Text } = Typography;

type Props = { data: IMessage };

const MessageItem = ({ data }: Props) => {
  const { content, ownerId: owner, createdAt } = data;

  return (
    <Row className="message-item-container" align={'top'}>
      <Col className="avatar">
        <Avatar src={owner.avatar} size={40} />
      </Col>

      <Col className="content-container">
        <Row align={'bottom'}>
          <Col>
            <Text strong>{owner.name}</Text>
          </Col>
          <Col>
            <Text className="created-at">{format(parseJSON(createdAt), 'dd/MM/yyyy p')}</Text>
          </Col>
        </Row>

        <Row>
          <Col>
            <Text>{content}</Text>
          </Col>
        </Row>
      </Col>
    </Row>
  );
};

export default MessageItem;
