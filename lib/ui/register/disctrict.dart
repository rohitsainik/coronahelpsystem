import 'dart:convert';

import 'package:coronahelpsystem/base/appApi.dart';
import 'package:coronahelpsystem/model/districtState.dart';
import 'package:coronahelpsystem/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:searchable_dropdown/searchable_dropdown.dart';


class SelectDisctrict extends StatefulWidget {
  var id;

  SelectDisctrict({Key key,this.id}) : super(key: key);

  @override
  _SelectDisctrictState createState() => _SelectDisctrictState();
}

class _SelectDisctrictState extends State<SelectDisctrict> {
  District selectedValue;
  List<District> districts = [];
  bool isloading = true;


  @override
  void initState() {
    super.initState();
    getDistrict();
  }

  Future<Null> getDistrict() async {
    var response = await http.get(
      Uri.parse(AppApi.DistrictApi + widget.id),
    );

    if (response.statusCode == 200) {
      String responeBody = response.body;
      var jsonBody = json.decode(responeBody);
      districts = List<District>.from(jsonBody["districts"].map((x) => District.fromJson(x)));


      setState(() {

      });

      if (districts.length != null) {
        setState(() {
          isloading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => MyHomePage(distId: selectedValue.districtId.toString(),)));
        },
        child: Icon(Icons.add),
      ),
      body: Center(child: BranchDropdown(),
      ),
    );
  }

  BranchDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Branch',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          padding: const EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width - 28,


          child: Align(
            alignment: Alignment.centerLeft,
            child: SearchableDropdown.single(
              isExpanded: true,
              displayClearIcon: false,
              hint: "Select one",
              searchHint: "Select one",
              // Not necessary for Option 1
              // value: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = District();

                  selectedValue = value;

                  print(selectedValue);

                });
              },
              items: districts.map((branchname) {
                return DropdownMenuItem(
                  child: Text(
                    branchname.districtName.toString(),
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  value: branchname,
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
