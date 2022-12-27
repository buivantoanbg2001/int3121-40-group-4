import React, { useState, useEffect } from 'react';
import { Col, Divider, Input, Modal, Row, Typography, message } from 'antd';
import { ICallChannel, IChatChannel } from 'models/channel.model';
import { BiHash, BiVolumeFull, BiSend } from 'react-icons/bi';
import { BsFillPersonPlusFill } from 'react-icons/bs';
import MessageItem from 'components/server/MessageItem';
import * as _ from 'lodash';
import { format, parse } from 'date-fns';
import ChatChannelApi from 'helpers/api/ChannelApi';
import { useSelector } from 'react-redux';
import { userValue } from 'slices/userSlice';
import MessageApi from 'helpers/api/MessageApi';
import MemberItem from 'components/server/MemberItem';
import NotificationApi from 'helpers/api/NotificationApi';

const { Text } = Typography;

type Props = {
  id: string;
  serverId: string;
};

const ChannelDetail = ({ id, serverId }: Props) => {
  const userData = useSelector(userValue);
  const [channel, setChannel] = useState<IChatChannel | ICallChannel>();
  const [messageInput, setMessageInput] = useState<string>();
  const currentServer = userData.user?.servers.find(i => i._id === serverId);
  const typeChannel = currentServer?.callChannels.find(i => i._id === id)
    ? currentServer?.callChannels.find(i => i._id === id)?.type
    : currentServer?.chatChannels.find(i => i._id === id)?.type;
  const [isModalOpen, setIsModalOpen] = useState<boolean>(false);

  useEffect(() => {
    let interval: NodeJS.Timeout;

    if (typeChannel === 'chat') {
      // interval = setInterval(() => {
      //   ChatChannelApi.getChatChannel(id).then(res => {
      //     setChannel({
      //       ...res.data,
      //       type: typeChannel,
      //       messages: res.data.messages.sort(
      //         (a: any, b: any) => new Date(a.createdAt).getTime() - new Date(b.createdAt).getTime(),
      //       ),
      //     });
      //   });
      // }, 1000);

      ChatChannelApi.getChatChannel(id).then(res => {
        setChannel({
          ...res.data,
          messages: res.data.messages.sort(
            (a: any, b: any) => new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime(),
          ),
          type: typeChannel,
        });
      });
    }

    return () => clearInterval(interval);
  }, [id, serverId]);

  const showModal = () => {
    setIsModalOpen(true);
  };

  const onInvite = (friendId: string) => {
    NotificationApi.create({ chatId: id, receiver: friendId, type: 'CHAT' })
      .then(res => message.success(res.data.payload.message, 3))
      .catch(err => message.error('Gửi lời mời thất bại', 3));
  };

  const handleCancel = () => {
    setIsModalOpen(false);
  };

  const handleSendMessage = () => {
    if (messageInput) {
      MessageApi.send(id, messageInput).then(res => setMessageInput(''));
    }
  };

  if (!channel) return <></>;

  return (
    <Col span={24} className="channel-detail-container">
      <Row className="channel-header" align={'middle'}>
        <Col className="channel-icon">
          {channel.type === 'chat' ? (
            <BiHash size={20} />
          ) : channel.type === 'call' ? (
            <BiVolumeFull size={20} />
          ) : (
            <></>
          )}
        </Col>

        <Col className="channel-name">
          <Text className="channel-name-content" strong>
            {channel.name}
          </Text>
        </Col>

        {userData.user?._id === channel.hostId && (
          <BsFillPersonPlusFill size={24} className="add-member" onClick={showModal} />
        )}
      </Row>

      {channel.type === 'chat' && (
        <>
          <Row className="message-container">
            <Col span={24} className="message-wrapper">
              {channel.messages != undefined &&
                Object.entries(
                  _.groupBy(
                    channel.messages.map(item => ({ ...item, createdAtDate: item.createdAt.slice(0, 10) })),
                    'createdAtDate',
                  ),
                ).map(([keyDate, groupMessages]) => {
                  return (
                    <div key={keyDate}>
                      <Divider className="date-divider">
                        {format(parse(keyDate, 'yyyy-MM-dd', new Date()), 'LLLL dd, yyyy')}
                      </Divider>

                      {groupMessages.map(({ createdAtDate, ...item }) => (
                        <Row key={item._id}>
                          <MessageItem data={item} />
                        </Row>
                      ))}
                    </div>
                  );
                })}
            </Col>
          </Row>

          <Row className="chat-box-container">
            <Input
              className="chat-input"
              placeholder={`Trò chuyện cùng #${channel.name}`}
              suffix={<BiSend size={24} className="send-icon" onClick={handleSendMessage} />}
              bordered={false}
              value={messageInput}
              onChange={e => setMessageInput(e.target.value)}
              onPressEnter={handleSendMessage}
            />
          </Row>
        </>
      )}

      <Modal title="Mời bạn bè" open={isModalOpen} onCancel={handleCancel} footer={null}>
        <Row gutter={[0, 12]}>
          {userData.user?.friends.map(item => (
            <Col span={24}>
              <MemberItem key={item._id} data={item} onInvite={onInvite} />
            </Col>
          ))}
        </Row>
      </Modal>
    </Col>
  );
};

export default ChannelDetail;
