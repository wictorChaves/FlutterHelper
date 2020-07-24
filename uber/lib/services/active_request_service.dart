import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber/services/request_service.dart';
import 'package:uber/store/store.dart';

import '../core/services/base_service.dart';
import 'enum/status_enum.dart';
import 'model/active_request_model.dart';
import 'model/request_model.dart';

class ActiveRequestService extends BaseService<ActiveRequestModel> {
  RequestService _requestService = RequestService();

  ActiveRequestService._constructor() : super("requisicao_ativa", NewInstance);

  static final ActiveRequestService _instance =
      ActiveRequestService._constructor();

  factory ActiveRequestService() {
    return _instance;
  }

  static ActiveRequestModel NewInstance(Map<String, dynamic> json) =>
      ActiveRequestModel.fromJson(json);

  Future<dynamic> SetStatus(String uid, StatusEnum status) async {
    ActiveRequestModel activeRequestModel = await GetById(uid);
    var updateObj = {'status': enumToDescribe(status)};
    await UpdatePropertyDocument(activeRequestModel.uid, updateObj);
    _requestService.UpdatePropertyDocument(
        activeRequestModel.uid_request, updateObj);
  }

  Stream<QuerySnapshot> ListenByStatus(StatusEnum statusEnum) {
    return collection
        .where("status", isEqualTo: enumToDescribe(statusEnum))
        .snapshots();
  }

  Future<dynamic> AcceptRunning(RequestModel requestModel) async {
    SetStatus(requestModel.passanger.uid, StatusEnum.ON_MY_WAY);

    CreateOrUpdate(ActiveRequestModel.fromJson({
      "uid": Store.userModel.uid,
      "uid_request": requestModel.uid,
      "status": enumToDescribe(StatusEnum.ON_MY_WAY)
    }));

    requestModel.status = StatusEnum.ON_MY_WAY;
    requestModel.driver = Store.userModel;
    _requestService.CreateOrUpdate(requestModel);
  }

  Future<dynamic> CancelRunning(RequestModel requestModel) async {
    SetStatus(requestModel.passanger.uid, StatusEnum.WAIT);

    CreateOrUpdate(ActiveRequestModel.fromJson({
      "uid": Store.userModel.uid,
      "uid_request": requestModel.uid,
      "status": enumToDescribe(StatusEnum.WAIT)
    }));

    requestModel.status = StatusEnum.WAIT;
    requestModel.driver = null;
    _requestService.CreateOrUpdate(requestModel);
  }

  Future<ActiveRequestModel> ActiveRequestByRequestUid(
      String requestUid) async {
    QuerySnapshot document = await collection
        .where("uid_request", isEqualTo: requestUid)
        .getDocuments();
    return ActiveRequestModel.fromJson(document.documents.toList().first.data);
  }
}
