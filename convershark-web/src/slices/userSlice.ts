import { createSlice } from '@reduxjs/toolkit';
import type { PayloadAction } from '@reduxjs/toolkit';
import { RootState } from '../store';
import { IUser } from 'models/user.model';

export interface UserState {
  user: IUser | undefined;
}

const initialState: UserState = {
  user: undefined,
};

export const userSlice = createSlice({
  name: 'user',
  initialState,
  reducers: {
    setMyInfo: (state, action: PayloadAction<IUser>) => {
      state.user = action.payload;
    },
  },
});

export const { setMyInfo } = userSlice.actions;

export const userValue = (state: RootState) => state.user;

export default userSlice.reducer;
