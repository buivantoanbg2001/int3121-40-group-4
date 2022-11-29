import React, { useState, useEffect } from 'react';
import { Col, Divider, Input, Row, Typography } from 'antd';
import { ICallChannel, IChatChannel } from 'models/channel.model';
import { BiHash, BiVolumeFull, BiSend } from 'react-icons/bi';
import { useNavigate } from 'react-router-dom';
import MessageItem from 'components/server/MessageItem';
import * as _ from 'lodash';
import { format, parse } from 'date-fns';

const { Text } = Typography;

const fakeChatData: IChatChannel = {
  id: '123h453j45kl2',
  name: 'chào-mừng',
  type: 'chat',
  members: [],
  messages: [
    {
      id: '43g54gf23hjj5',
      userId: '65fdgfdyg3y47',
      content: 'Hello!',
      createdAt: '2022-11-18T15:30:23Z',
      updatedAt: '2022-11-20T12:30:23Z',
    },
    {
      id: '43g54gf54hjj5',
      userId: '65fdgfdyg3y47',
      content: 'Hi',
      createdAt: '2022-11-19T13:30:23Z',
      updatedAt: '2022-11-20T13:30:23Z',
    },
    {
      id: '43g54gf54hjj5sd',
      userId: '65fdgfdyg3y47',
      content: 'Hi hi',
      createdAt: '2022-11-19T15:30:23Z',
      updatedAt: '2022-11-20T13:30:23Z',
    },
    {
      id: '43g54gf23hgj5',
      userId: '65fdgfdyg3y47',
      content: 'Laborum laborum sint consectetur ex adipisicing. Anim nostrud amet exercitation cillum.',
      createdAt: '2022-11-20T14:30:23Z',
      updatedAt: '2022-11-20T14:30:23Z',
    },
  ],
};

const fakeCallData: ICallChannel = {
  id: '123h45345kl2',
  name: 'họp-team',
  type: 'call',
  members: [],
};

type Props = {
  id: string;
  serverId: string;
};

const ChannelDetail = ({ id, serverId }: Props) => {
  const navigate = useNavigate();

  const [channel, setChannel] = useState<IChatChannel | ICallChannel>();
  const [message, setMessage] = useState<string>();

  useEffect(() => {
    /**
     * @TODO call api get channel info by serverId & channelId, then check type of channel, if type === "chat",  setChatChannel()
     */
    if (Math.random() >= 0.5) {
      setChannel(fakeChatData);
    } else {
      setChannel(fakeCallData);
    }
  }, [id, serverId]);

  const handleSendMessage = () => {
    /**
     * @TODO handle send message if it is not empty
     */
    if (message) {
      console.log('message', message);
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
      </Row>

      {channel.type === 'chat' && (
        <>
          <Row className="message-container">
            <Col span={24} className="message-wrapper">
              {Object.entries(
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
                      <Row key={item.id}>
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
              value={message}
              onChange={e => setMessage(e.target.value)}
              onPressEnter={handleSendMessage}
            />
          </Row>
        </>
      )}
    </Col>
  );
};

export default ChannelDetail;
