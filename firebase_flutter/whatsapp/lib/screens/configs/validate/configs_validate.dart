import 'package:whatsapp/screens/register/viewmodel/user_view_model.dart';

class ConfigsValidate {
  String Text(String value) {
    return (value.length < 3)
        ? "O campo nome deve ter no mínimo 3 digitos"
        : null;
  }
}
