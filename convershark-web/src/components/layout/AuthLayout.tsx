import { Suspense, useState } from 'react';
import { Avatar, Button, Col, Input, Layout, message, Modal, Row, Typography } from 'antd';
import ServerMenu from 'components/layout/ServerMenu';
import { LOGO_URL } from 'helpers/contains/constants';
import { Outlet } from 'react-router';
import FeatureTab from 'components/layout/FeatureTab';
import ServerApi from 'helpers/api/ServerApi';

type TypeModal = 'FEATURE_TAB' | 'CREATE_SERVER';

const { Title } = Typography;
const { Sider, Content } = Layout;

const AuthLayout: React.FC = () => {
  const [isModalOpen, setIsModalOpen] = useState<boolean>(false);
  const [modalType, setModelType] = useState<TypeModal>('FEATURE_TAB');
  const [serverInput, setServerInput] = useState<string>();

  const handleCreateServer = () => {
    if (serverInput) {
      ServerApi.create({ name: serverInput })
        .then(res => {
          message.success(res.data.payload.message, 3);
          handleCancel();
          setServerInput('');
        })
        .catch(err => message.error('Tạo kênh chat thất bại', 3));
    }
  };

  const showModal = (modalType: TypeModal) => {
    setModelType(modalType);
    setIsModalOpen(true);
  };

  const handleCancel = () => {
    setIsModalOpen(false);
  };

  return (
    <Layout className="layout-container">
      <Layout className="layout-content-container">
        <Sider id="layout-sever-sider" theme="light">
          <div className="app-logo" onClick={() => showModal('FEATURE_TAB')}>
            <img src={LOGO_URL} alt="App Logo" />
          </div>
          <div className="add-server">
            <Avatar
              src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRj4-8IxLD1QeF9hId8E849aw6hygR9E1hJ6A&usqp=CAU"
              size={48}
              onClick={() => showModal('CREATE_SERVER')}
            />
          </div>
          <ServerMenu />
          <Modal open={isModalOpen} onCancel={handleCancel} footer={null} closable={false}>
            {modalType == 'FEATURE_TAB' ? (
              <FeatureTab />
            ) : (
              <Row gutter={[0, 4]}>
                <Title level={2} style={{ fontSize: 20, fontWeight: 700 }}>
                  Tạo Server
                </Title>
                <Col span={24}>
                  <Input
                    placeholder="Nhập tên server"
                    value={serverInput}
                    onChange={e => setServerInput(e.target.value)}
                    onPressEnter={handleCreateServer}
                  />
                </Col>
                <Col span={24}>
                  <Button type="primary" className="full-width" onClick={handleCreateServer}>
                    Tạo
                  </Button>
                </Col>
              </Row>
            )}
          </Modal>
        </Sider>
        <Content id="layout-content">
          <Suspense fallback={null}>
            <Outlet />
          </Suspense>
        </Content>
      </Layout>
    </Layout>
  );
};

export default AuthLayout;
