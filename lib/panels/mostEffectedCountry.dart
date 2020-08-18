import 'package:flutter/material.dart';

class MosteffectedCountry extends StatelessWidget {
  final List countryDate;

  const MosteffectedCountry({Key key, this.countryDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            child: Row(
              children: <Widget>[
                Image.network(
                  countryDate[index]["countryInfo"]["flag"],
                  height: 30,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  countryDate[index]["country"],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Deaths:' + countryDate[index]["totolDeaths"],
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
