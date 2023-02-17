// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localjson_lab/insertuser.dart';

class Api extends StatefulWidget {
  const Api({Key? key}) : super(key: key);

  @override
  State<Api> createState() => _ApiState();
}

class _ApiState extends State<Api> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text("Api Demo"),
          actions:  [
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return  Api1(null);
              })).then((value) {
                if(value == true)
                {
                  setState(() {

                  });
                }
              });
            }, icon: const Icon(
              Icons.add,
              color: Colors.white,
            )),
          ],
        ),
        backgroundColor: Colors.white,
        body: FutureBuilder<http.Response>(
          future: getWebFromServer(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: jsonDecode(snapshot.data!.body).length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.network((jsonDecode(
                                      snapshot.data!.body.toString())[index]
                                  ['avatar'])),
                              Text(
                                  (jsonDecode(snapshot.data!.body.toString())[
                                          index]['name']
                                      .toString()),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              IconButton(onPressed: (){
                                   return delete( (jsonDecode(snapshot.data!.body.toString())[
                                   index]['id']));
                              }, icon: const Icon(Icons.delete,color: Colors.red,)),
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                      return Api1((jsonDecode(
                                          snapshot.data!.body.toString())
                                      [index]));
                                    })).then((value) {
                                      if(value==true){
                                        setState(() {
                                        });
                                      }
                                    });
                                  },
                                  icon: const Icon(Icons.arrow_forward)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }

  Future<http.Response> getWebFromServer() async {
    var response = await http.get(
        Uri.parse("https://6346afcb9eb7f8c0f882ab8e.mockapi.io/flutter_demo"));
    return response;
  }

  Future<http.Response> DeleteUser(id) async {
    var response = await http.delete(
        Uri.parse("https://6346afcb9eb7f8c0f882ab8e.mockapi.io/flutter_demo/$id"));
    return response;
  }
  void delete(id){
    showDialog(context: context, builder: (context) {
      return AlertDialog(title: const Center(child: Text("Alert!")),icon: const Icon(Icons.warning),content: const Text("Are You Want Sure Delete?"),
        actions: [
          TextButton(onPressed: () async {
           await DeleteUser(id).then((value){
             setState(() {
                });
              Navigator.of(context).pop(true);
            });
          }, child: const Text("Yes")),
          TextButton(onPressed: (){
            Navigator.of(context).pop(true);
          }, child: const Text("No")),
        ],);
    },);
  }

}
