import 'package:annotations/services/main_service.dart';

class AnnotationService extends MainService {

  static final AnnotationService _singleton = AnnotationService._internal();
  AnnotationService._internal() : super("annotation");
  factory AnnotationService(){
    return _singleton;
  }

}
