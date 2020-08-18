import 'package:covid19/data_source.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

void main() => runApp(MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Circular', primaryColor: primaryBlack),
    ));
