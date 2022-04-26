import 'dart:async';
import 'dart:convert';
import 'package:calculator/internal/constants.dart';
import 'package:calculator/internal/currency.dart';
import 'package:http/http.dart' as http;

class DataAccess{
  static final DataAccess _instance = DataAccess.internal();
  factory DataAccess() => _instance;

  DataAccess.internal();

  List<Currency> _currencies = [];
  Future<List<Currency>> currencies() async {
    if (_currencies.isNotEmpty) {
      return _currencies;
    }

    _currencies = await _loadCurrencies();
    return _currencies;
  }

  Future<List<Currency>> _loadCurrencies() async {
    String uri = Constants.exchangeRatesApiUri;
    var response = await http.get(Uri.parse(uri), headers: {"Accept": "application/json"});
    var responseBody = json.decode(response.body);
    Map rates = responseBody['rates'];

    List<Currency> set = [];
    for (var entry in rates.entries) {
      set.add(Currency(name: entry.key as String, rate: (entry.value as num).toDouble()));
    }

    return set;
  }

  void preloadCurrencies() async {
    currencies();
  }
}