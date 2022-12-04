import 'package:convershark/models/user.model.dart';
import 'package:convershark/redux/actions.dart';
import 'package:convershark/redux/app_state.dart';
import 'package:redux/redux.dart';

AppState reducer(AppState state, dynamic action) => AppState(
      me: _meReducer(state.me, action),
      selectedServer: _selectedServerReducer(state.selectedServer, action),
    );

Reducer<UserModel> _meReducer =
    combineReducers([TypedReducer<UserModel, SetMeAction>(_setMeReducer)]);

UserModel _setMeReducer(UserModel me, SetMeAction action) => action.me;

Reducer<int> _selectedServerReducer = combineReducers(
    [TypedReducer<int, SetSelectedServerAction>(_setSelectedServerReducer)]);

int _setSelectedServerReducer(int index, SetSelectedServerAction action) =>
    action.index;
