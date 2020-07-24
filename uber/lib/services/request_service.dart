import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber/services/enum/status_enum.dart';

import '../core/services/base_service.dart';
import 'model/request_model.dart';

class RequestService extends BaseService<RequestModel> {
  RequestService._constructor() : super("requisicoes", NewInstance);

  static final RequestService _instance = RequestService._constructor();

  factory RequestService() {
    return _instance;
  }

  static RequestModel NewInstance(Map<String, dynamic> json) =>
      RequestModel.fromJson(json);

  Stream<QuerySnapshot> ListenByStatus(StatusEnum statusEnum) {
    return collection.where("status", isEqualTo: enumToDescribe(statusEnum)).snapshots();
  }
}
