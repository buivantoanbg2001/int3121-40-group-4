import React, { useState, useEffect } from 'react';
import { Col, Typography, Input, Row, Tabs, Button, Tooltip, message, Divider } from 'antd';
import { BsFillPeopleFill, BsBellFill } from 'react-icons/bs';
import { useSelector } from 'react-redux';
import { userValue } from 'slices/userSlice';
import FriendItem from 'components/layout/FriendItem';
import NotificationApi from 'helpers/api/NotificationApi';
import { INotification } from 'models/notification.model';
import NotificationItem from 'components/layout/NotificationItem';

const { Text, Title } = Typography;

const FeatureTab: React.FC = () => {
  return (
    <Tabs
      items={[
        { id: 'friends', icon: BsFillPeopleFill, title: 'Bạn bè' },
        { id: 'notifications', icon: BsBellFill, title: 'Thông báo' },
      ].map(item => ({
        label: (
          <Row align={'middle'}>
            <item.icon style={{ marginRight: 8, marginBottom: 4 }} size={16} />
            {item.title}
          </Row>
        ),
        key: item.id,
        children: item.id === 'friends' ? <FriendTab /> : <NotificationTab></NotificationTab>,
      }))}
    />
  );
};

export default FeatureTab;

const FriendTab = () => {
  const userData = useSelector(userValue);
  const [uidInput, setUidInput] = useState<string>();

  const handleInviteFriend = () => {
    if (uidInput) {
      NotificationApi.create({ type: 'FRIEND', friendUID: uidInput })
        .then(res => message.success(res.data.payload.message, 3))
        .catch(err => message.error('Gửi yêu cầu kết bạn thất bại', 3));
    }
  };

  return (
    <Row gutter={[0, 4]} style={{ overflowY: 'auto' }}>
      <Title level={2} style={{ fontSize: 20, fontWeight: 700 }}>
        Thêm bạn bè
      </Title>
      <Col span={24}>
        <Tooltip title="Bạn cần phải có cả tên người dùng và số nhận diện của họ. Hãy nhớ rằng tên người dùng có phân biệt chữ in hoa và chữ thường.">
          <Input
            placeholder="Username#0000"
            value={uidInput}
            onChange={e => setUidInput(e.target.value)}
            onPressEnter={handleInviteFriend}
          />
        </Tooltip>
      </Col>

      <Col span={24}>
        <Button type="primary" className="full-width" onClick={handleInviteFriend}>
          Gửi Yêu Cầu Kết Bạn
        </Button>
      </Col>

      <Title level={2} style={{ fontSize: 20, fontWeight: 700, marginTop: 20 }}>
        Danh sách bạn bè
      </Title>

      <Col span={24}>
        <Row gutter={[0, 12]}>
          {userData.user?.friends.map(item => (
            <Col key={item._id} span={24}>
              <FriendItem data={item}></FriendItem>
            </Col>
          ))}
        </Row>
      </Col>
    </Row>
  );
};

const NotificationTab = () => {
  const [notifications, setNotifications] = useState<INotification[]>();

  useEffect(() => {
    NotificationApi.getAll().then(res => setNotifications(res.data));
  }, []);

  return (
    <Row gutter={[0, 4]} style={{ overflowY: 'auto' }}>
      <Title level={2} style={{ fontSize: 20, fontWeight: 700 }}>
        Thông báo
      </Title>

      <Col span={24}>
        <Row gutter={[0, 12]}>
          {notifications?.map(item => (
            <Col key={item._id} span={24}>
              <NotificationItem data={item} />
              <div style={{ marginTop: 12, borderTop: '1px solid #0000001a' }} />
            </Col>
          ))}
        </Row>
      </Col>
    </Row>
  );
};
