import { Suspense } from 'react';
import { Layout } from 'antd';
import ServerMenu from 'components/layout/ServerMenu';
import { LOGO_URL } from 'helpers/contains/constants';
import { Outlet } from 'react-router';

const { Sider, Content } = Layout;

const AuthLayout: React.FC = () => {
  return (
    <Layout className="layout-container">
      <Layout className="layout-content-container">
        <Sider id="layout-sever-sider" theme="light">
          <div className="app-logo">
            <img src={LOGO_URL} alt="App Logo" />
          </div>
          <ServerMenu />
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
