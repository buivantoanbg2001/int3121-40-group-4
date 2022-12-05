import { Suspense, useState } from 'react';
import { Layout, Modal } from 'antd';
import ServerMenu from 'components/layout/ServerMenu';
import { LOGO_URL } from 'helpers/contains/constants';
import { Outlet } from 'react-router';
import FeatureTab from 'components/layout/FeatureTab';

const { Sider, Content } = Layout;

const AuthLayout: React.FC = () => {
  const [isModalOpen, setIsModalOpen] = useState<boolean>(false);

  const showModal = () => {
    setIsModalOpen(true);
  };
  const handleCancel = () => {
    setIsModalOpen(false);
  };

  return (
    <Layout className="layout-container">
      <Layout className="layout-content-container">
        <Sider id="layout-sever-sider" theme="light">
          <div className="app-logo" onClick={showModal}>
            <img src={LOGO_URL} alt="App Logo" />
          </div>
          <ServerMenu />
          <Modal open={isModalOpen} onCancel={handleCancel} footer={null} closable={false}>
            <FeatureTab />
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
