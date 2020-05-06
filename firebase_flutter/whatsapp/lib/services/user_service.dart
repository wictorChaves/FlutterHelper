import 'package:whatsapp/services/model/user_model.dart';

import 'model/base_service.dart';

class UserService extends BaseService<UserModel> {
  UserService._constructor() : super("usuarios");

  static final UserService _instance = UserService._constructor();

  factory UserService() {
    return _instance;
  }
}
