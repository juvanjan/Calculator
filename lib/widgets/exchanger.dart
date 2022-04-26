import 'package:calculator/data_access/data_access.dart';
import 'package:calculator/internal/constants.dart';
import 'package:calculator/internal/currency.dart';
import 'package:flutter/material.dart';



class Exchanger extends StatefulWidget {
  final Function(double modifier) convert;

  const Exchanger({required this.convert, Key? key}) : super(key: key);

  @override
  _ExchangerState createState() => _ExchangerState();
}

class _ExchangerState extends State<Exchanger> {
  bool _initialized = false;
  String? _exchangeFrom;
  String? _exchangeTo;
  List<DropdownMenuItem<String>> _items = [];
  List<Currency> _currencies = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Currency>>(
        future: DataAccess().currencies(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              setDefaultCurrencies(snapshot.data!);

              return Container(
                margin: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(Constants.formRadius),
                      topRight: Radius.circular(Constants.formRadius),
                      bottomLeft: Radius.circular(Constants.formRadius),
                      bottomRight: Radius.circular(Constants.formRadius)
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 4), // changes position of shadow
                    ),
                  ],
                ),

                child: Column(
                  children: [

                    Container(
                      padding: const EdgeInsets.only(left: 14, right: 14, top: 7),
                      child: Row(

                        children: [

                          const Text(Constants.exchangeFrom + ": " ,
                            style: TextStyle(
                                fontSize: 18
                            ),
                          ),

                          Expanded(child: Container()),

                          DropdownButtonHideUnderline(
                            child: DropdownButton(
                              onChanged: (String? value) {
                                setState(() {
                                  _exchangeFrom = value!;
                                });
                              },
                              value: _exchangeFrom,
                              items: _items,
                            ),
                          ),

                        ],
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      child: Row(
                        children: [

                          const Text(Constants.exchangeTo + ": " ,
                            style: TextStyle(
                                fontSize: 18
                            ),
                          ),

                          Expanded(child: Container()),

                          DropdownButtonHideUnderline(
                            child: DropdownButton(
                              onChanged: (String? value) {
                                setState(() {
                                  _exchangeTo = value!;
                                });
                              },
                              value: _exchangeTo,
                              items: _items,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 7),
                      child: ElevatedButton(
                        onPressed: () {
                          convert();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          primary: Theme.of(context).colorScheme.secondary,
                          shadowColor: Colors.black,
                          elevation: 5,
                        ),
                        child: Text(Constants.convert,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 22
                          ),
                        ),
                      ),
                    ),


                  ],
                ),
              );
            } else {
              return const Center(
                child: Text(Constants.exchangeRatesError),
              );
            }
          } else {
            return const CircularProgressIndicator();
          }
        }
    );
  }

  void setDefaultCurrencies(List<Currency> currencies) {
    if (!_initialized) {
      _currencies = currencies;
      _exchangeFrom = currencies.any((element) => element.name == Constants.defaultExchangeFrom) ? Constants.defaultExchangeFrom : currencies.first.name;
      _exchangeTo = currencies.any((element) => element.name == Constants.defaultExchangeTo) ? Constants.defaultExchangeTo : currencies.first.name;
      mapItems(currencies);
      _initialized = true;
    }
  }

  void mapItems(List<Currency> currencies) {
    _items = currencies.map((currency) => DropdownMenuItem<String>(
      value: currency.name,
      child: Text(currency.name),
    )).toList(growable: false);
  }

  void convert() {
    if (_initialized && _currencies.isNotEmpty) {
      Currency currencyFrom = _currencies.where((element) => element.name == _exchangeFrom).first;
      Currency currencyTo = _currencies.where((element) => element.name == _exchangeTo).first;

      widget.convert(currencyTo.rate / currencyFrom.rate);
    }
  }
}
