import 'package:practical_test/models/currency.dart';

class Country {
  final String name;
  final int population;
  final String region;
  final String capital;
  final List<Currency> currencies;
  final String flag;
  final List<String> callingCodes;
  final List<String> borders;

  Country({
    required this.name,
    required this.population,
    required this.region,
    required this.capital,
    required this.currencies,
    required this.flag,
    required this.callingCodes,
    required this.borders,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'],
      population: json['population'],
      region: json['region'],
      capital: json['capital'] ?? '',
      currencies: json['currencies']
          .map<Currency>((currency) => Currency.fromJson(currency))
          .toList(),
      flag: json['flag'],
      callingCodes: json['callingCodes'].cast<String>(),
      borders: json['borders'].cast<String>(),
    );
  }
}
