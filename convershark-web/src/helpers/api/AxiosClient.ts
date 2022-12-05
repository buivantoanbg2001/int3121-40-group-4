import axios, { AxiosRequestConfig, AxiosResponse } from 'axios';
import { AxiosClientConfig } from 'helpers/contains/api.constants';

const AxiosClient = axios.create({
  baseURL: AxiosClientConfig.DOMAIN_API,
  headers: {
    'Content-type': AxiosClientConfig.CONTENT_TYPE,
  },
});

AxiosClient.interceptors.request.use(
  (config: AxiosRequestConfig) => {
    if (localStorage.getItem('token')) {
      (config.headers as any)['Authorization'] =
        AxiosClientConfig.AUTH_TYPES + ' ' + localStorage.getItem('token') || '';
    }

    return config;
  },
  error => {
    return Promise.reject(error.response);
  },
);

AxiosClient.interceptors.response.use(
  (axiosResponse: AxiosResponse<any>) => axiosResponse,
  error => {
    if (error.response.status === 401) {
      localStorage.clear();
      window.location.href = '/home';
      return Promise.reject(error);
    }

    return Promise.reject(error.response.data);
  },
);

export default AxiosClient;
