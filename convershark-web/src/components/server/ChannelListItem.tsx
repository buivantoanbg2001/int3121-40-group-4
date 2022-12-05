import { Col, Row, Typography } from 'antd';
import { BiHash, BiVolumeFull } from 'react-icons/bi';
import { useNavigate, useLocation } from 'react-router-dom';

const { Text } = Typography;

type Props = {
  _id: string;
  name: string;
  type: 'call' | 'chat';
  serverId: string;
};

const ChannelListItem = ({ serverId, _id, name, type }: Props) => {
  const navigate = useNavigate();
  const location = useLocation();

  return (
    <Row
      className={`channel-list-item-container  ${
        location.pathname.includes(`/${_id}`) ? 'channel-list-item-container-selected' : ''
      }`}
      align={'middle'}
      onClick={() => navigate(`/channels/${serverId}/${_id}`)}
    >
      <Col className="channel-icon">
        {type === 'chat' ? <BiHash size={20} /> : type === 'call' ? <BiVolumeFull size={20} /> : <></>}
      </Col>

      <Col className="channel-name">
        <Text className="channel-name-content" strong>
          {name}
        </Text>
      </Col>
    </Row>
  );
};

export default ChannelListItem;
