import 'package:image_picker/image_picker.dart';
import 'package:validadores/Validador.dart';

class NewAdvertValidate {
  String Image(List<PickedFile> images) {
    return (images.length == 0) ? "Necessário selecionar uma imagem!" : null;
  }

  String Dropdown(String value) {
    return Validador()
        .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
        .valido(value);
  }

  String Text(String value) {
    return Validador()
        .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
        .valido(value);
  }

  String TextMuitiLine(String value) {
    return Validador()
        .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
        .maxLength(200, msg: "Máximo de 200 caracteres")
        .valido(value);
  }

  String Email(String value) {
    var regexEmail =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    return (!RegExp(regexEmail).hasMatch(value)) ? "E-mail inválido" : null;
  }

  String Password(String value) {
    return (value.length < 6)
        ? "O campo senha deve ter no mínimo 6 digitos"
        : null;
  }
}
