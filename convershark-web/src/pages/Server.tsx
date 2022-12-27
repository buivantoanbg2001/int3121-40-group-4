import React, { useState } from 'react';
import { Button, Col, Input, message, Modal, Row, Typography } from 'antd';
import { useParams } from 'react-router-dom';
import ChannelListItem from 'components/server/ChannelListItem';
import ChannelDetail from 'components/server/ChannelDetail';
import { useSelector } from 'react-redux';
import { userValue } from 'slices/userSlice';
import MemberItem from 'components/server/MemberItem';
import NotificationApi from 'helpers/api/NotificationApi';
import ChatChannelApi from 'helpers/api/ChannelApi';

const { Text, Title } = Typography;

type Props = {};
type TypeModal = 'INVITE_MEMBERS' | 'CREATE_CHANNEL';

const Server: React.FC = (props: Props) => {
  const { serverId, channelId } = useParams();
  const userData = useSelector(userValue);
  const server = userData.user?.servers.find(i => i._id == serverId);
  const [isModalOpen, setIsModalOpen] = useState<boolean>(false);
  const [modalType, setModelType] = useState<TypeModal>('INVITE_MEMBERS');
  const [chatChannelInput, setChatChannelInput] = useState<string>();

  const showModal = (modalType: TypeModal) => {
    setModelType(modalType);
    setIsModalOpen(true);
  };

  const handleCancel = () => {
    setIsModalOpen(false);
  };

  const onInvite = (friendId: string) => {
    NotificationApi.create({ serverId: serverId, receiver: friendId, type: 'SERVER' })
      .then(res => message.success(res.data.payload.message, 3))
      .catch(err => message.error('Gửi lời mời thất bại', 3));
  };

  const handleCreateChatChannel = () => {
    if (chatChannelInput && serverId) {
      ChatChannelApi.create({ name: chatChannelInput, serverId })
        .then(res => {
          message.success(res.data.payload.message, 3);
          handleCancel();
          setChatChannelInput('');
        })
        .catch(err => message.error('Tạo kênh chat thất bại', 3));
    }
  };

  if (!serverId || !server) return <></>;

  console.log('OK', server);

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
          <>
            <Row>
              <Button
                className="full-width invite-server-member-button"
                type="primary"
                onClick={() => showModal('INVITE_MEMBERS')}
              >
                Thêm Thành Viên
              </Button>
            </Row>
            <Row>
              <Button
                className="full-width invite-server-member-button"
                type="primary"
                onClick={() => showModal('CREATE_CHANNEL')}
              >
                Thêm Kênh Chat
              </Button>
            </Row>
          </>
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

      <Modal open={isModalOpen} onCancel={handleCancel} footer={null} closable={false}>
        {modalType == 'INVITE_MEMBERS' ? (
          <Row gutter={[0, 12]}>
            <Title level={2} style={{ fontSize: 20, fontWeight: 700 }}>
              Mời Bạn Bè
            </Title>
            {userData.user?.friends.map(item => (
              <Col span={24}>
                <MemberItem key={item._id} data={item} onInvite={onInvite} />
              </Col>
            ))}
          </Row>
        ) : (
          <Row gutter={[0, 4]}>
            <Title level={2} style={{ fontSize: 20, fontWeight: 700 }}>
              Tạo Kênh Chat
            </Title>
            <Col span={24}>
              <Input
                placeholder="Nhập tên kênh chat"
                value={chatChannelInput}
                onChange={e => setChatChannelInput(e.target.value)}
                onPressEnter={handleCreateChatChannel}
              />
            </Col>
            <Col span={24}>
              <Button type="primary" className="full-width" onClick={handleCreateChatChannel}>
                Tạo
              </Button>
            </Col>
          </Row>
        )}
      </Modal>
    </Row>
  );
};

export default Server;
