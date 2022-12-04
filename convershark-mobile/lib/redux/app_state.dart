import 'package:convershark/models/user.model.dart';

class AppState {
  final UserModel me;
  final int selectedServer;

  AppState({required this.me, required this.selectedServer});
}
