import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practical_test/country_details.dart';
import 'package:practical_test/models/country.dart';
import 'package:practical_test/service.dart';

class CountryList extends StatefulWidget {
  @override
  _CountryListState createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  late Future<List<Country>> _futureCountry;
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('Country List',
      style: TextStyle(color: Colors.white, fontSize: 20));

  @override
  void initState() {
    super.initState();
    _futureCountry = fetchCountry();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: _buildBar(context),
        ),
        body: Center(
          child: FutureBuilder<List<Country>>(
            future: _futureCountry,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Country> _filteredCountries;
                if (_searchText.trim() != '') {
                  _filteredCountries = snapshot.data
                          ?.where((element) => element.name
                              .toLowerCase()
                              .contains(_searchText.trim().toLowerCase()))
                          .toList() ??
                      [];
                } else {
                  _filteredCountries = snapshot.data ?? [];
                }
                return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: _filteredCountries.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CountryDetails(),
                                settings: RouteSettings(
                                  arguments: _filteredCountries[index],
                                ),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              SvgPicture.network(
                                _filteredCountries[index].flag,
                                key: ValueKey(_filteredCountries[index].flag),
                                width: 50,
                                fit: BoxFit.contain,
                                placeholderBuilder: (BuildContext context) =>
                                    Container(
                                  width: 50,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 12),
                                  Text(
                                    _filteredCountries[index].name,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 17),
                                  ),
                                  Text(
                                    (_filteredCountries[index].capital == ''
                                        ? '-'
                                        : _filteredCountries[index].capital),
                                    style: TextStyle(
                                        color: Colors.blueGrey, fontSize: 12),
                                  ),
                                  Text(
                                    _filteredCountries[index]
                                            .currencies[0]
                                            .name
                                            .toString() +
                                        '(' +
                                        _filteredCountries[index]
                                            .currencies[0]
                                            .symbol
                                            .toString() +
                                        ')',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.blueGrey, fontSize: 12),
                                  ),
                                ],
                              )),
                              Text(
                                _filteredCountries[index].population.toString(),
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ],
                          ));
                    });
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      title: _appBarTitle,
      actions: [
        new IconButton(
          icon: _searchIcon,
          onPressed: _searchPressed,
        )
      ],
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          cursorColor: Colors.white,
          controller: _filter,
          style: TextStyle(color: Colors.white, fontSize: 20),
          decoration: new InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.white),
          ),
          onChanged: (value) {
            if (_filter.text.isEmpty) {
              setState(() {
                _searchText = "";
              });
            } else {
              setState(() {
                _searchText = _filter.text;
              });
            }
          },
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Country List',
            style: TextStyle(color: Colors.white, fontSize: 20));
        _filter.clear();
        setState(() {
          _searchText = '';
        });
      }
    });
  }
}
