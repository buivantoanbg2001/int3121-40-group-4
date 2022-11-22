import React, { Suspense } from 'react';
import AppRouting from './components/routes/AppRouting';
import { history, HistoryRouter } from './components/routes/HistoryRouter';
import 'styles/main.scss';

const App: React.FC = () => {
  return (
    <HistoryRouter history={history}>
      <Suspense fallback={null}>
        <AppRouting />
      </Suspense>
    </HistoryRouter>
  );
};

export default App;
