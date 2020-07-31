import 'package:olx/core/services/test/model/test_model.dart';

import '../base_service.dart';

class TestService extends BaseService<TestModel> {
  TestService._constructor() : super("test", NewInstance);

  static final TestService _instance = TestService._constructor();

  factory TestService() {
    return _instance;
  }

  static TestModel NewInstance(Map<String, dynamic> json) =>
      TestModel.fromJson(json);
}
