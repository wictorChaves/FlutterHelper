import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quotation/services/askingprice.service.dart';
import 'package:quotation/services/quotation.service.dart';
import 'package:quotation/view/home/home.dart';
import 'package:quotation/view/settings/internal-configs.dart';
import 'models/quotation.model.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  QuotationService _quotationService = new QuotationService();
  AskingPriceService _askingPriceService = new AskingPriceService();
  bool shouldProceed = false;

  _fetchPrefs() async {
    populateQuotation().then((value) {
      setState(() {
        shouldProceed = true;
      });
    });
  }

  Future<void> populateQuotation() async {
    var values = await _quotationService.GetAll();
    var askingPriceQuotations = await _askingPriceService.getAll();
    if (values.length == 0) {
      await createCommercialQuotation(askingPriceQuotations);
      await createBlueQuotation(askingPriceQuotations);
    } else {
      await updateCommercialQuotation(askingPriceQuotations);
    }
  }

  Future<void> createCommercialQuotation(askingPriceQuotations) async {
    var group = 'Commercial';
    await _quotationService.Add(new Quotation.New(
        'BRL', 'USD', askingPriceQuotations['BRL-USD'], group));
    await _quotationService.Add(new Quotation.New(
        'BRL', 'ARS', askingPriceQuotations['BRL-ARS'], group));
    await _quotationService.Add(new Quotation.New(
        'ARS', 'USD', askingPriceQuotations['ARS-USD'], group));
    await _quotationService.Add(new Quotation.New(
        'ARS', 'BRL', askingPriceQuotations['ARS-BRL'], group));
    await _quotationService.Add(new Quotation.New(
        'USD', 'BRL', askingPriceQuotations['USD-BRL'], group));
    await _quotationService.Add(new Quotation.New(
        'USD', 'ARS', askingPriceQuotations['USD-ARS'], group));
  }

  Future<void> updateCommercialQuotation(askingPriceQuotations) async {
    var group = 'Commercial';
    await _quotationService.UpdateWithoutId(new Quotation.New(
        'BRL', 'USD', askingPriceQuotations['BRL-USD'], group));
    await _quotationService.UpdateWithoutId(new Quotation.New(
        'BRL', 'ARS', askingPriceQuotations['BRL-ARS'], group));
    await _quotationService.UpdateWithoutId(new Quotation.New(
        'ARS', 'USD', askingPriceQuotations['ARS-USD'], group));
    await _quotationService.UpdateWithoutId(new Quotation.New(
        'ARS', 'BRL', askingPriceQuotations['ARS-BRL'], group));
    await _quotationService.UpdateWithoutId(new Quotation.New(
        'USD', 'BRL', askingPriceQuotations['USD-BRL'], group));
    await _quotationService.UpdateWithoutId(new Quotation.New(
        'USD', 'ARS', askingPriceQuotations['USD-ARS'], group));
  }

  Future<void> createBlueQuotation(askingPriceQuotations) async {
    var group = 'Blue';
    var multiplierBlueBRLARS = 1.652173913043478;
    var multiplierBlueUSDARS = 1.769911504424779;
    await _quotationService.Add(new Quotation.New(
        'BRL', 'USD', askingPriceQuotations['BRL-USD'], group));
    await _quotationService.Add(new Quotation.New('BRL', 'ARS',
        askingPriceQuotations['BRL-ARS'] * multiplierBlueBRLARS, group));
    await _quotationService.Add(new Quotation.New('ARS', 'USD',
        askingPriceQuotations['ARS-USD'] / multiplierBlueUSDARS, group));
    await _quotationService.Add(new Quotation.New('ARS', 'BRL',
        askingPriceQuotations['ARS-BRL'] / multiplierBlueBRLARS, group));
    await _quotationService.Add(new Quotation.New(
        'USD', 'BRL', askingPriceQuotations['USD-BRL'], group));
    await _quotationService.Add(new Quotation.New('USD', 'ARS',
        askingPriceQuotations['USD-ARS'] * multiplierBlueUSDARS, group));
  }

  @override
  void initState() {
    super.initState();
    _fetchPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shouldProceed
          ? Home()
          : Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      InternalConfigs.PRIMARYCOLOR))),
    );
  }
}
