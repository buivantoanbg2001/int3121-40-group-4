import { Button, Col, Form, Input, Row, Typography } from 'antd';
import AuthApi from 'helpers/api/AuthApi';
import { LOGO_URL } from 'helpers/contains/constants';
import React from 'react';
import { BsStars, BsFillPersonBadgeFill } from 'react-icons/bs';
import { useNavigate } from 'react-router-dom';

const { Text } = Typography;

type Props = {};

const Home: React.FC = (props: Props) => {
  const navigate = useNavigate();
  const [form] = Form.useForm();

  const onLogin = async (values: any) => {
    AuthApi.logIn(values);
    const token = await AuthApi.logIn(values);
    localStorage.setItem('token', token.data.accessToken);
    navigate('/channels');
  };

  return (
    <Row className="home-container">
      <Col xs={{ span: 24 }} md={{ span: 12 }} className="home-introduce">
        <Row align={'middle'} className="head">
          <div className="logo-container">
            <img className="app-logo" src={LOGO_URL} />
          </div>
          <Text className="app-name">Convershark</Text>
        </Row>
        <Row className="body">
          <Text className="introduce-1">
            Convershark
            <BsStars size={36} style={{ marginLeft: 8, marginBottom: 12 }} />
          </Text>
          <Text className="introduce-2">
            <Text className="strong">Trò chuyện</Text> với bạn bè và các cộng đồng khác nhau trên{' '}
            <Text className="strong">nền tảng</Text> với hơn <Text className="strong">100 triệu</Text> người dùng
          </Text>
        </Row>
        <Row className="footer" align={'middle'}>
          <BsFillPersonBadgeFill size={36} style={{ marginRight: 12 }} />
          <Col>
            <Row>
              <Text style={{ fontWeight: 800, fontSize: 14 }}>+20</Text>
            </Row>
            <Row>
              <Text style={{ opacity: 0.5, fontSize: 14 }}>Đội ngũ nhân sự với hơn 20 năm kinh nghiệm</Text>
            </Row>
          </Col>
        </Row>
      </Col>

      <Col xs={{ span: 24 }} md={{ span: 12 }} className="home-login">
        <Row justify={'center'} align={'middle'} className="login-container">
          <div className="login-content">
            <Row style={{ display: 'flex', justifyContent: 'center', marginBottom: 20 }}>
              <Text style={{ fontWeight: 800, fontSize: 32 }}>Đăng Nhập</Text>
            </Row>
            <Form form={form} name="register" onFinish={onLogin} scrollToFirstError>
              <Form.Item name="email" rules={[{ required: true, message: 'Vui lòng nhập email!' }]}>
                <Input className="input" placeholder="Email" />
              </Form.Item>
              <Form.Item name="password" rules={[{ required: true, message: 'Vui lòng nhập mật khẩu!' }]}>
                <Input.Password className="input" placeholder="Mật khẩu" />
              </Form.Item>

              <Form.Item>
                <Button type="primary" htmlType="submit" className="full-width login-button">
                  Bắt đầu
                </Button>
              </Form.Item>
            </Form>
          </div>
        </Row>
      </Col>
    </Row>
  );
};

export default Home;
