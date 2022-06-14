class CalcQuotation {
  var _value = 0.0;
  var _currencies = {
    'BRL': {'USD': 0.20, 'ARS': 24.41},
    'ARS': {'USD': 0.0082, 'BRL': 0.041},
    'USD': {'BRL': 4.99, 'ARS': 121.78}
  };

  CalcQuotation(currencies) {
    _currencies = currencies;
  }

  setValue(value) {
    _value = value;
  }

  toBRL(currency) {
    return toCurrency(currency, 'BRL');
  }

  toARS(currency) {
    return toCurrency(currency, 'ARS');
  }

  toUSD(currency) {
    return toCurrency(currency, 'USD');
  }

  toCurrency(from, to) {
    if (from == to) return _value;
    return _value * _currencies[from][to];
  }
}
