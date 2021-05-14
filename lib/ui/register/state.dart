import 'dart:convert';
import 'package:coronahelpsystem/base/appApi.dart';
import 'package:coronahelpsystem/model/stateModel.dart';
import 'package:coronahelpsystem/ui/register/disctrict.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';


class SelectState extends StatefulWidget {
  const SelectState({Key key}) : super(key: key);

  @override
  _SelectStateState createState() => _SelectStateState();
}

class _SelectStateState extends State<SelectState> {
  String selectedValue;
  List<Stateindia> state = [];
  var districtid;
  bool isloading = true;


  @override
  void initState() {
    getState();
    super.initState();
  }


  Future<Null> getState() async {
    var response = await http.get(
        Uri.parse(AppApi.StateApi),
    );

    if (response.statusCode == 200) {
      String responeBody = response.body;
      var jsonBody = json.decode(responeBody);


      setState(() {
        state = List<Stateindia>.from(jsonBody["states"].map((x) => Stateindia.fromJson(x)));
      });

      if (state.length != null) {
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
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (_)=>SelectDisctrict(id: districtid,)));
        },
        tooltip: 'Increment',
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
              onChanged: (Stateindia value) {
                setState(() {
                  selectedValue = '';

                  selectedValue = value.stateName.toString();
                  districtid = value.stateId.toString();
                  print(selectedValue);

                });
              },
              items: state.map((branchname) {
                return DropdownMenuItem(
                  child: Text(
                    branchname.stateName.toString(),
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