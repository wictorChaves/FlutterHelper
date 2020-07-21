import '../core/services/base_service.dart';
import 'model/active_request_model.dart';

class ActiveRequestService extends BaseService<ActiveRequestModel> {

  ActiveRequestService._constructor() : super("requisicao_ativa", NewInstance);

  static final ActiveRequestService _instance = ActiveRequestService._constructor();

  factory ActiveRequestService() {
    return _instance;
  }

  static ActiveRequestModel NewInstance(Map<String, dynamic> json) =>
      ActiveRequestModel.fromJson(json);

}
