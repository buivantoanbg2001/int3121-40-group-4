import React, { Suspense } from 'react';
import AppRouting from './components/routes/AppRouting';
import { history, HistoryRouter } from './components/routes/HistoryRouter';
import { store } from 'store';
import 'styles/main.scss';
import { Provider } from 'react-redux';

const App: React.FC = () => {
  return (
    <Provider store={store}>
      <HistoryRouter history={history}>
        <Suspense fallback={null}>
          <AppRouting />
        </Suspense>
      </HistoryRouter>
    </Provider>
  );
};

export default App;
