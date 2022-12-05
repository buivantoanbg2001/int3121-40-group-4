import { useNavigate } from 'react-router-dom';
import { Result, Button } from 'antd';
import { RouteProps, useLocation } from 'react-router';

const PrivateRoute: React.FC<RouteProps> = props => {
  const logged = localStorage.getItem('token') ? true : false;
  const navigate = useNavigate();
  const location = useLocation();

  return logged ? (
    (props.element as React.ReactElement)
  ) : (
    <Result
      status="403"
      title="403"
      subTitle="Phiên đăng nhập của bạn đã hết hạn, vui lòng đăng nhập lại"
      extra={
        <Button
          type="primary"
          onClick={() => navigate(`/${'?from=' + encodeURIComponent(location.pathname)}`, { replace: true })}
        >
          Đi đến Đăng nhập
        </Button>
      }
    />
  );
};

export default PrivateRoute;
