import 'package:covid19/data_source.dart';
import 'package:covid19/pages/countryPagesData.dart';
import 'package:covid19/panels/infoPanel.dart';
import 'package:covid19/panels/mostEffectedCountry.dart';
import 'package:covid19/panels/worldwidepanel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url = "https://corona.lmao.ninja/v3/covid-19/all";
  final String urls = "https://corona.lmao.ninja/v3/covid-19/countries";

  @override
  void initState() {
    super.initState();
    fetchWorldWideData();
    fetchCountryWideData();
  }

  List countrydata;
  fetchCountryWideData() async {
    http.Response response = await http.get(urls);
    setState(() {
      countrydata = json.decode(response.body);
    });
  }

  Map worlddata;
  fetchWorldWideData() async {
    http.Response response = await http.get(url);
    setState(() {
      worlddata = json.decode(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("COVID-19 TRACKER APP "),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10.0),
              height: 100,
              color: Colors.orange[100],
              child: Text(
                DataSource.quote,
                style: TextStyle(
                  color: Colors.orange[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('WorldWide',
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold)),
                  Container(
                      decoration: BoxDecoration(
                          color: primaryBlack,
                          borderRadius: BorderRadius.circular(15)),
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CountryPage()));
                        },
                        child: Text('Regional',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      )),
                ],
              ),
            ),
            worlddata == null
                ? CircularProgressIndicator()
                : WorldwidePanel(
                    worldData: worlddata,
                  ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Text('Recent Affected Country',
                  style:
                      TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 5,
            ),
            countrydata == null
                ? Container(
                    child: CircularProgressIndicator(),
                  )
                : MosteffectedCountry(
                    countryData: countrydata,
                  ),
            SizedBox(
              height: 30,
            ),
            InfoPanel(),
            SizedBox(
              height: 20,
            ),
            Center(
                child: Text(
              "WE ARE TOGETHER IN FIGHT",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
