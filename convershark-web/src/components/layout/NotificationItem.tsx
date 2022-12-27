import React, { useState } from 'react';
import { Avatar, Button, Col, message, Row, Typography } from 'antd';
import { INotification } from 'models/notification.model';
import NotificationApi from 'helpers/api/NotificationApi';
import UserApi from 'helpers/api/UserApi';
import ServerApi from 'helpers/api/ServerApi';

const { Text } = Typography;

type Props = {
  data: INotification;
};

const NotificationItem = ({ data }: Props) => {
  const [isResponse, setIsResponse] = useState<boolean>(data.isResponse);
  const [isAccept, setIsAccept] = useState<boolean>(data.isAccept);

  const handleResponse = (isAccept: boolean) => {
    setIsResponse(true);
    setIsAccept(isAccept);

    if (data.type === 'FRIEND' || data.type === 'SERVER' || data.type === 'CALL' || data.type === 'CHAT') {
      NotificationApi.update(data._id, { isResponse: true, isAccept });
    }

    if (isAccept) {
      switch (data.type) {
        case 'FRIEND': {
          UserApi.updateFriendBoth(data.sender._id)
            .then(res => message.success(res.data.payload.message, 3))
            .catch(err => message.error('Phản hồi yêu cầu kết bạn thất bại', 3));

          break;
        }
        case 'SERVER': {
          ServerApi.updateMember(data.serverId._id)
            .then(res => message.success(res.data.payload.message, 3))
            .catch(err => message.error('Phản hồi lời mời thất bại', 3));

          break;
        }
        case 'CHAT': {
          break;
        }
        case 'CALL': {
          break;
        }
      }
    }
  };

  return (
    <Row align={'middle'} justify="space-between">
      {(data.serverId || data.chatId || data.callId) && (
        <Col span={24}>
          <Text style={{ fontWeight: 800 }}>
            {`${
              data.chatId
                ? `#${data.chatId.name}`
                : data.callId
                ? `#${data.callId.name}`
                : data.serverId
                ? `${data.serverId.name}`
                : ''
            }`}{' '}
          </Text>
        </Col>
      )}

      <Col span={24}>
        <Row style={{ display: 'flex' }}>
          <Col>
            <Avatar src={data.sender.avatar} size={36} style={{ marginRight: 12 }} />
          </Col>
          <Col style={{ flex: 1 }}>
            <Row>
              <Text strong>{`${data.sender._uid} đã ${
                data.type == 'FRIEND'
                  ? 'gửi yêu cầu kết bạn.'
                  : data.type == 'SERVER'
                  ? `gửi lời mời tham gia ${data.serverId?.name}.`
                  : data.type == 'CHAT'
                  ? `gửi lời mời tham gia kênh chat #${data.chatId?.name}.`
                  : data.type == 'CALL'
                  ? `gửi lời mời tham gia kênh thoại #${data.callId?.name}.`
                  : data.type == 'MESSAGE'
                  ? `đề cập đến bạn trong kênh chat #${data.chatId?.name}.`
                  : 'Không có nội dung.'
              }`}</Text>
            </Row>

            {(data.type === 'CALL' || data.type === 'CHAT' || data.type === 'FRIEND' || data.type === 'SERVER') && (
              <Row style={{ marginTop: 4 }}>
                {isResponse && (
                  <Button type="primary" disabled style={{ flex: 1 }}>
                    {isAccept ? 'Đã chấp nhận' : 'Đã từ chối'}
                  </Button>
                )}
                {!isResponse && (
                  <>
                    <Button type="primary" style={{ flex: 1, marginRight: 4 }} onClick={() => handleResponse(true)}>
                      Chấp nhận
                    </Button>
                    <Button type="primary" style={{ flex: 1 }} onClick={() => handleResponse(false)}>
                      Từ chối
                    </Button>
                  </>
                )}
              </Row>
            )}
          </Col>
        </Row>
      </Col>
    </Row>
  );
};

export default NotificationItem;
