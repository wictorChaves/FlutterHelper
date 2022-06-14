import 'package:flutter/widgets.dart';
import 'package:quotation/helper/currency.helper.dart';
import 'package:quotation/models/quotation.model.dart';
import 'package:quotation/services/quotation.service.dart';

class HomeForm {
  QuotationService _quotationService = new QuotationService();
  String selectedGroup = 'Commercial';
  List<String> groupList = ['Commercial'];
  var controllers = {
    'group': new TextEditingController(),
    'BRL-USD': new TextEditingController(),
    'BRL-ARS': new TextEditingController(),
    'ARS-USD': new TextEditingController(),
    'ARS-BRL': new TextEditingController(),
    'USD-BRL': new TextEditingController(),
    'USD-ARS': new TextEditingController()
  };

  setValues(List<Quotation> quotations) {
    setGroups(quotations);
    loadCurrencies(quotations);
  }

  setGroups(List<Quotation> quotations) {
    groupList = quotations.map((e) => e.currencygroup).toSet().toList();
  }

  loadCurrencies(List<Quotation> quotations) {
    setCurrencies(quotations, 'BRL', 'USD');
    setCurrencies(quotations, 'BRL', 'ARS');

    setCurrencies(quotations, 'ARS', 'USD');
    setCurrencies(quotations, 'ARS', 'BRL');

    setCurrencies(quotations, 'USD', 'BRL');
    setCurrencies(quotations, 'USD', 'ARS');
  }

  setCurrencies(List<Quotation> quotations, String from, String to) {
    var quotation = getQuotation(quotations, from, to);
    controllers[from + '-' + to].text =
        quotation == null ? '0' : quotation.value.toString();
  }

  Future<void> saveCurrencies(List<Quotation> quotations) async {
    print(selectedGroup);
    await saveCurrency(quotations, 'BRL', 'USD');
    await saveCurrency(quotations, 'BRL', 'ARS');

    await saveCurrency(quotations, 'ARS', 'USD');
    await saveCurrency(quotations, 'ARS', 'BRL');

    await saveCurrency(quotations, 'USD', 'BRL');
    await saveCurrency(quotations, 'USD', 'ARS');
  }

  saveCurrency(List<Quotation> quotations, from, to) async {
    double value = CurrencyHelper.toDouble(controllers[from + '-' + to].text);

    var quotation = getQuotation(quotations, from, to);

    if (quotation == null) {
      await _quotationService.Add(
          new Quotation.New(from, to, value, selectedGroup));
    } else {
      quotation.value = value;
      await _quotationService.Update(quotation);
    }
  }

  getQuotation(List<Quotation> quotations, from, to) {
    return quotations.firstWhere(
        (quotation) =>
            quotation.currencyfrom == from &&
            quotation.currencyto == to &&
            quotation.currencygroup == selectedGroup,
        orElse: () => null);
  }

  Future<void> addNewQuotation() async {
    var group = controllers['group'].text;
    await _quotationService.Add(new Quotation.New('BRL', 'USD',
        CurrencyHelper.toDouble(controllers['BRL-USD'].text), group));
    await _quotationService.Add(new Quotation.New('BRL', 'ARS',
        CurrencyHelper.toDouble(controllers['BRL-ARS'].text), group));
    await _quotationService.Add(new Quotation.New('ARS', 'USD',
        CurrencyHelper.toDouble(controllers['ARS-USD'].text), group));
    await _quotationService.Add(new Quotation.New('ARS', 'BRL',
        CurrencyHelper.toDouble(controllers['ARS-BRL'].text), group));
    await _quotationService.Add(new Quotation.New('USD', 'BRL',
        CurrencyHelper.toDouble(controllers['USD-BRL'].text), group));
    await _quotationService.Add(new Quotation.New('USD', 'ARS',
        CurrencyHelper.toDouble(controllers['USD-ARS'].text), group));

    selectedGroup = group;
  }
}
