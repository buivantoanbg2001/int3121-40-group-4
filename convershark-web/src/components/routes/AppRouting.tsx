import { lazy } from 'react';
import { Navigate, RouteObject, useRoutes } from 'react-router-dom';
import AuthLayout from 'components/layout/AuthLayout';
import WrapperRouteComponent from './WrapperRouteComponent';

const Login = lazy(() => import('pages/Login'));
const Home = lazy(() => import('pages/Home'));
const Server = lazy(() => import('pages/Server'));
const NotFound = lazy(() => import('pages/NotFound'));

const routeList: RouteObject[] = [
  {
    path: '/',
    element: <Navigate to="home" />,
  },
  {
    path: '/login',
    element: <WrapperRouteComponent element={<Login />} titleId="Đăng nhập" />,
  },
  {
    path: '/home',
    element: <WrapperRouteComponent element={<Home />} titleId="Trang chủ" />,
  },
  {
    path: '/channel',
    element: <WrapperRouteComponent element={<AuthLayout />} titleId="" auth={true} />,
    children: [
      {
        path: '',
        element: <WrapperRouteComponent element={<Server />} titleId="Server" />,
      },
      {
        path: ':serverId',
        element: <WrapperRouteComponent element={<Server />} titleId="Server" />,
      },
      {
        path: ':serverId/:channelId',
        element: <WrapperRouteComponent element={<Server />} titleId="Server" />,
      },
    ],
  },
  {
    path: '*',
    element: <WrapperRouteComponent element={<NotFound />} titleId="Not Found" />,
  },
];

const AppRouting: React.FC = () => {
  const element = useRoutes(routeList);

  return element;
};

export default AppRouting;
