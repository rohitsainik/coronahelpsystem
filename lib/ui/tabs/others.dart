import 'dart:convert';

import 'package:coronahelpsystem/base/appApi.dart';
import 'package:coronahelpsystem/model/vaccine.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Others extends StatefulWidget {
  const Others({Key key}) : super(key: key);

  @override
  _OthersState createState() => _OthersState();
}

class _OthersState extends State<Others> {
  List<Session> vaccine = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
