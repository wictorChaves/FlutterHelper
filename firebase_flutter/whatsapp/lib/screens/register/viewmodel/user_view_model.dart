class UserViewModel {
  String _name;
  String _email;
  String _password;

  UserViewModel(this._name, this._email, this._password);

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}
