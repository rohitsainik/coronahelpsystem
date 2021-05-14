import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Availabilitypage extends StatefulWidget {
var citycode;
Availabilitypage({Key key,this.citycode}) : super(key: key);

  @override
  _AvailabilitypageState createState() => _AvailabilitypageState();
}

class _AvailabilitypageState extends State<Availabilitypage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('available').where('citycode',isEqualTo: widget.citycode).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              var data = snapshot.data;

              if(snapshot.hasError){
                print(snapshot.error);
                return Center(child: CircularProgressIndicator(),);
              }
              switch(snapshot.connectionState){
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator(),);
                default:
                  return ListView.builder(itemCount: data.docs.length,itemBuilder: (_,index){
                    return Card(child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(data.docs[index]['name'],style: GoogleFonts.robotoMono(fontWeight: FontWeight.w500,color: Colors.grey,fontSize: 15),),
                              // Text(data.docs[index]['timestamp'].toString(),style: GoogleFonts.robotoMono(fontWeight: FontWeight.w500,color: Colors.grey,fontSize: 15),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                          child: Align(alignment: Alignment.centerLeft,child: Text(data.docs[index]['adress'],style: GoogleFonts.robotoMono(color: Colors.black),textAlign: TextAlign.justify,)),
                        ),
                        Wrap(children: data.docs[index]['available'].toString().split(',').map((e) {
                          return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Chip(label: Text(e.toString())),
                          );
                        }).toList(),),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(data.docs[index]['contact'],style: GoogleFonts.robotoMono(fontWeight: FontWeight.w500,color: Colors.grey,fontSize: 15),),
                              Text(data.docs[index]['city'].toString().toUpperCase(),style: GoogleFonts.robotoMono(fontWeight: FontWeight.w500,color: Colors.grey,fontSize: 15),),
                            ],
                          ),
                        ),
                      ],
                    ),);
                  });
              }


            },),



          bottomNavigationBar: Container(color: Colors.green,child: Row(
            children: [
              Expanded(flex:1,child: Container(color: Colors.green,child: TextButton(onPressed: (){}, child: Text('Request',style: TextStyle(color: Colors.white),)))),
              Expanded(flex:1,child: Container(color: Colors.orange,child: TextButton(onPressed: (){}, child: Text('Filter',style: TextStyle(color: Colors.white),)))),

            ],
          ),)
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }
}
