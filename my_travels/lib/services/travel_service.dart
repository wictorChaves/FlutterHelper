import 'base_service.dart';
import 'model/travel_model.dart';

class TravelService  extends BaseService<TravelModel>{

  TravelService._constructor() : super("viagens", NewInstance);

  static final TravelService _instance = TravelService._constructor();

  factory TravelService() {
    return _instance;
  }

  static TravelModel NewInstance(Map<String, dynamic> json) => TravelModel.fromJson(json);

}