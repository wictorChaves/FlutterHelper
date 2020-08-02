import '../core/services/base_service.dart';
import 'model/advert_model.dart';

class AdvertService extends BaseService<AdvertModel> {
  AdvertService._constructor() : super("anuncios", NewInstance);

  static final AdvertService _instance = AdvertService._constructor();

  factory AdvertService() {
    return _instance;
  }

  static AdvertModel NewInstance(Map<String, dynamic> json) =>
      AdvertModel.fromJson(json);
}
