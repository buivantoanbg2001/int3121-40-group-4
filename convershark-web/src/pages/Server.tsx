import React, { useState } from 'react';
import { Button, Col, message, Modal, Row, Typography } from 'antd';
import { useParams } from 'react-router-dom';
import ChannelListItem from 'components/server/ChannelListItem';
import ChannelDetail from 'components/server/ChannelDetail';
import { useSelector } from 'react-redux';
import { userValue } from 'slices/userSlice';
import MemberItem from 'components/server/MemberItem';
import NotificationApi from 'helpers/api/NotificationApi';

const { Text } = Typography;

type Props = {};

const Server: React.FC = (props: Props) => {
  const { serverId, channelId } = useParams();
  const userData = useSelector(userValue);
  const server = userData.user?.servers.find(i => i._id == serverId);
  const [isModalOpen, setIsModalOpen] = useState<boolean>(false);

  const showModal = () => {
    setIsModalOpen(true);
  };

  const onInvite = (friendId: string) => {
    NotificationApi.create({ serverId: serverId, receiver: friendId, type: 'SERVER' })
      .then(res => message.success(res.data.payload.message, 3))
      .catch(err => message.error('Gửi lời mời thất bại', 3));
  };

  const handleCancel = () => {
    setIsModalOpen(false);
  };

  if (!serverId || !server) return <></>;

  return (
    <Row className="server-container">
      <Col className="channel-list-container">
        <Row className="channel-header">
          <Text className="server-name" strong>
            {server.name}
          </Text>
          <img className="banner-profile" src={server.wallpaper} />
        </Row>

        {userData.user?._id === server.hostId && (
          <Row>
            <Button className="full-width invite-server-member-button" type="primary" onClick={showModal}>
              Thêm thành viên
            </Button>
          </Row>
        )}

        {server.chatChannels.map(item => (
          <Row key={item._id}>
            <ChannelListItem _id={item._id} serverId={serverId} type={item.type} name={item.name} />
          </Row>
        ))}

        {server.callChannels.map(item => (
          <Row key={item._id}>
            <ChannelListItem _id={item._id} serverId={serverId} type={item.type} name={item.name} />
          </Row>
        ))}
      </Col>

      <Col className="channel-content-container">
        {channelId && <ChannelDetail id={channelId} serverId={serverId} />}
      </Col>

      <Modal title="Mời bạn bè" open={isModalOpen} onCancel={handleCancel} footer={null}>
        <Row gutter={[0, 12]}>
          {userData.user?.friends.map(item => (
            <Col span={24}>
              <MemberItem key={item._id} data={item} onInvite={onInvite} />
            </Col>
          ))}
        </Row>
      </Modal>
    </Row>
  );
};

export default Server;
