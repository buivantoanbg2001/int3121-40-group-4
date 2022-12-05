import { configureStore } from '@reduxjs/toolkit';
import userReducer from './slices/userSlice';

export const store = configureStore({
  reducer: {
    user: userReducer,
  },
  middleware: getDefaultMiddleware =>
    getDefaultMiddleware().concat([
      store => next => action => {
        const returnValue = next(action);
        if (action.type.startsWith('cart/')) {
          localStorage.setItem('cart', JSON.stringify(store.getState().cart));
        }
        return returnValue;
      },
      store => next => action => {
        const returnValue = next(action);
        if (action.type.startsWith('user/')) {
          localStorage.setItem('user', JSON.stringify(store.getState().user));
        }
        return returnValue;
      },
    ]),
});

export type RootState = ReturnType<typeof store.getState>;
export type AppDispatch = typeof store.dispatch;
