import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CountryPage extends StatefulWidget {
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  List countrydata;
  final String urls = "https://corona.lmao.ninja/v3/covid-19/countries";
  @override
  void initState() {
    super.initState();
    fetchCountryWideData();
  }

  fetchCountryWideData() async {
    http.Response response = await http.get(urls);
    setState(() {
      countrydata = json.decode(response.body);
      print(countrydata);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Country Status"),
      ),
      body: countrydata == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  height: 130,
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            blurRadius: 10,
                            offset: Offset(0, 10))
                      ]),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              countrydata[index]["country"],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Image.network(
                              countrydata[index]['countryInfo']['flag'],
                              height: 60,
                              width: 50,
                            )
                          ],
                        ),
                      ),
                      Expanded(
                          child: Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'CONFORMED:${countrydata[index]["cases"]}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'ACTIVE:${countrydata[index]["active"]}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'RECOVERED:${countrydata[index]["recovered"]}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'DEATHS:${countrydata[index]["deaths"]}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[900]),
                              ),
                            ]),
                      ))
                    ],
                  ),
                );
              },
              itemCount: countrydata == null ? 0 : countrydata.length,
            ),
    );
  }
}
