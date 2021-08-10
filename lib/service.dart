import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Country>> fetchCountry() async {
  final response =
      await http.get(Uri.parse('https://restcountries.eu/rest/v2/all'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List newList = jsonDecode(response.body);
    return newList.map((country) => Country.fromJson(country)).toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load countries.');
  }
}

class Country {
  final String name;
  final int population;
  final String region;
  final String capital;
  final List<Currency> currencies;

  Country({
    required this.name,
    required this.population,
    required this.region,
    required this.capital,
    required this.currencies,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
        name: json['name'],
        population: json['population'],
        region: json['region'],
        capital: json['capital'] ?? '',
        currencies: json['currencies']
            .map<Currency>((currency) => Currency.fromJson(currency))
            .toList());
  }
}

class Currency {
  final String name;
  final String code;
  final String symbol;

  Currency({
    required this.name,
    required this.code,
    required this.symbol,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      name: json['name'] ?? '-',
      code: json['code'] ?? '-',
      symbol: json['symbol'] ?? '-',
    );
  }
}
