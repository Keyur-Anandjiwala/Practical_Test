import 'package:flutter/material.dart';
import 'package:practical_test/service.dart';

class CountryList extends StatefulWidget {
  @override
  _CountryListState createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  late Future<List<Country>> futureCountry;

  @override
  void initState() {
    super.initState();
    futureCountry = fetchCountry();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List of countries',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('List of Countries'),
        ),
        body: Center(
          child: FutureBuilder<List<Country>>(
            future: futureCountry,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: snapshot.data?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 12),
                              Text(
                                '${snapshot.data?[index].name}',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 17),
                              ),
                              Text(
                                (snapshot.data?[index].capital == ''
                                    ? '-'
                                    : (snapshot.data?[index].capital ?? '')),
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 12),
                              ),
                              Text(
                                '${snapshot.data?[index].currencies[0].name.toString()} (${snapshot.data?[index].currencies[0].symbol.toString()})',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 12),
                              ),
                            ],
                          )),

                          Text(
                            '${snapshot.data?[index].population.toString()}',
                            textAlign: TextAlign.right,
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          //SizedBox(width: 25),
                        ],
                      );
                    });
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
