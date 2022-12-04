import 'package:convershark/models/user.model.dart';

class SetMeAction {
  final UserModel me;

  SetMeAction({required this.me});
}

class SetSelectedServerAction {
  final int index;

  SetSelectedServerAction({required this.index});
}
