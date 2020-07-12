import '../core/services/base_service.dart';
import 'model/request_model.dart';
import 'model/user_model.dart';

class RequestService extends BaseService<RequestModel> {

  RequestService._constructor() : super("requisicoes", NewInstance);

  static final RequestService _instance = RequestService._constructor();

  factory RequestService() {
    return _instance;
  }

  static RequestModel NewInstance(Map<String, dynamic> json) =>
      RequestModel.fromJson(json);

}
