import { useNavigate } from 'react-router-dom';
import { Button, Form, Input, Typography } from 'antd';
import React from 'react';

const { Title } = Typography;

const formItemLayout = {
  labelCol: { xs: { span: 24 }, sm: { span: 10 } },
  wrapperCol: { xs: { span: 24 }, sm: { span: 14 } },
};

const tailFormItemLayout = {
  wrapperCol: { xs: { span: 24, offset: 0 }, sm: { span: 14, offset: 10 } },
};

type Props = {};

const Login: React.FC = (props: Props) => {
  const navigate = useNavigate();
  const [form] = Form.useForm();

  const onLogin = async (values: any) => {
    const token = 'token';
    localStorage.setItem('token', token);
    navigate('/home');
  };

  return (
    <div className="login-container">
      <div className="login-content">
        <Title level={1} style={{ paddingBottom: 20 }}>
          Đăng nhập
        </Title>
        <Form {...formItemLayout} form={form} name="register" onFinish={onLogin} scrollToFirstError>
          <Form.Item
            name="username"
            label="Số điện thoại"
            rules={[
              { required: true, message: 'Vui lòng nhập số điện thoại!' },
              { max: 10, message: 'Độ dài của số điện thoại là 10 ký tự' },
            ]}
          >
            <Input />
          </Form.Item>
          <Form.Item
            name="password"
            label="Mật khẩu"
            rules={[{ required: true, message: 'Vui lòng nhập mật khẩu!' }]}
            hasFeedback
          >
            <Input.Password />
          </Form.Item>

          <Form.Item {...tailFormItemLayout}>
            <Button type="primary" htmlType="submit">
              Bắt đầu
            </Button>
          </Form.Item>
        </Form>
      </div>
    </div>
  );
};

export default Login;
