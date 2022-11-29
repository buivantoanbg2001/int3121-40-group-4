import { FC, ReactElement } from 'react';
import { RouteProps } from 'react-router';
import PrivateRoute from './PrivateRoute';

export type WrapperRouteProps = {
  titleId: string;
  auth?: boolean;
} & RouteProps;

const WrapperRouteComponent: FC<WrapperRouteProps> = ({ titleId, auth, ...props }) => {
  if (titleId) {
    document.title = titleId;
  }

  return auth ? <PrivateRoute {...props} /> : (props.element as ReactElement);
};

export default WrapperRouteComponent;
