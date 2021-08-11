import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:practical_test/models/country.dart';

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
