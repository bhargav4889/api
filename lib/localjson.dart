import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class LocalJson extends StatefulWidget {
  const LocalJson({Key? key}) : super(key: key);

  @override
  State<LocalJson> createState() => _LocalJsonState();
}

class _LocalJsonState extends State<LocalJson> {



  @override
   Widget build(BuildContext context)  {
    return  Scaffold(
      body: FutureBuilder<String>(
        builder: (context,snapshot){
          if (snapshot.hasData){
            var json = jsonDecode(snapshot.data.toString());
            return  Center(
              child: Text(json['message'].toString(),
                  style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
            );
          }
          else{
            return const Center(child: CircularProgressIndicator());
          }
          },
        future: rootBundle.loadString("lib/json/localjson.json"),
      ),
    );
  }
}
