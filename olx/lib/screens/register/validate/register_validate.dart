class RegisterValidate {

  String Text(String value) {
    return (value.length < 3)
        ? "O campo deve ter no mínimo 3 digitos"
        : null;
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
