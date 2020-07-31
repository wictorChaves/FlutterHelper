import '../core/services/base_service.dart';
import 'model/user_model.dart';

class UserService extends BaseService<UserModel> {
  UserService._constructor() : super("usuarios", NewInstance);

  static final UserService _instance = UserService._constructor();

  factory UserService() {
    return _instance;
  }

  static UserModel NewInstance(Map<String, dynamic> json) =>
      UserModel.fromJson(json);
}
