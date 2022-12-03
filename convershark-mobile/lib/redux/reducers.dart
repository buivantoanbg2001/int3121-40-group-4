import 'package:convershark/redux/actions.dart';
import 'package:convershark/redux/app_state.dart';
import 'package:redux/redux.dart';

AppState reducer(AppState state, dynamic action) => AppState(
      selectedServer: _selectedServerReducer(state.selectedServer, action),
    );

Reducer<int> _selectedServerReducer = combineReducers(
    [TypedReducer<int, SetSelectedServerAction>(_setSelectedServerReducer)]);

int _setSelectedServerReducer(int index, SetSelectedServerAction action) =>
    action.index;
