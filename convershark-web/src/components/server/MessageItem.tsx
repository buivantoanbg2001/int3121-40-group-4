import React, { useState, useEffect } from 'react';
import { Avatar, Col, Divider, Row, Typography } from 'antd';
import { IMessage } from 'models/message.model';
import { format, parseJSON } from 'date-fns';

const { Text } = Typography;

type Props = { data: IMessage };

const MessageItem = ({ data }: Props) => {
  const { userId, content, createdAt, reply } = data;

  return (
    <Row className="message-item-container" align={'top'}>
      <Col className="avatar">
        <Avatar size={40}>A</Avatar>
      </Col>

      <Col className="content-container">
        <Row align={'bottom'}>
          <Col>
            <Text strong>Toán Bùi Văn</Text>
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
