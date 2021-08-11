import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practical_test/models/country.dart';

class CountryDetails extends StatefulWidget {
  @override
  _CountryDetailsState createState() => _CountryDetailsState();
}

class _CountryDetailsState extends State<CountryDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Country country = ModalRoute.of(context)!.settings.arguments as Country;
    return Scaffold(
      appBar: AppBar(
        title: Text(country.name),
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          );
        }),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20),
              Row(children: [
                SvgPicture.network(
                  country.flag,
                  key: ValueKey(country.flag),
                  width: 300,
                  fit: BoxFit.contain,
                  placeholderBuilder: (BuildContext context) => Container(
                    width: 300,
                  ),
                ),
              ]),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Capital:',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      country.capital,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Population:',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      country.population.toString(),
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Currency:',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      country.currencies[0].name.toString() +
                          '(' +
                          country.currencies[0].symbol.toString() +
                          ')',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Region:',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      country.region,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(children: [
                Text(
                  'Calling Code:',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    country.callingCodes.join(', '),
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ]),
              SizedBox(height: 20),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  'Bordering Countries:',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    country.borders.join(', '),
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
