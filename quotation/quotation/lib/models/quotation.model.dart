class Quotation {
  int _id;
  String _currencyfrom;
  String _currencyto;
  double _value;
  String _currencygroup;

  Quotation(this._id, this._currencyfrom, this._currencyto, this._value,
      this._currencygroup);

  Quotation.New(String currencyfrom, String currencyto, double value,
      String currencygroup) {
    this._currencyfrom = currencyfrom;
    this._currencyto = currencyto;
    this._value = value;
    this._currencygroup = currencygroup;
  }

  String get currencyto => _currencyto;

  set currencyto(String value) {
    _currencyto = value;
  }

  String get currencyfrom => _currencyfrom;

  set currencyfrom(String value) {
    _currencyfrom = value;
  }

  int get id => _id;

  double get value => _value;

  set value(double value) {
    _value = value;
  }

  String get currencygroup => _currencygroup;

  set currencygroup(String value) {
    _currencygroup = value;
  }

  Quotation.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _currencyfrom = json['currencyfrom'],
        _currencyto = json['currencyto'],
        _value = json['value'],
        _currencygroup = json['currencygroup'];

  Map<String, dynamic> toJson() => {
        'id': _id,
        'currencyfrom': _currencyfrom,
        'currencyto': _currencyto,
        'value': _value,
        'currencygroup': _currencygroup
      };

  Map<String, dynamic> toJsonWithoutId() => {
        'currencyfrom': _currencyfrom,
        'currencyto': _currencyto,
        'value': _value,
        'currencygroup': _currencygroup
      };
}
