// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class Api1 extends StatefulWidget {
  Api1(this.map, {super.key});

  Map? map;

  @override
  State<Api1> createState() => _Api1State();
}

class _Api1State extends State<Api1> {
  var namecontroller = TextEditingController();

  var idcontroller = TextEditingController();

  var image = TextEditingController();

  var formkey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    namecontroller.text = widget.map == null ? "" : widget.map!['name'];
    image.text = widget.map == null ? "" : widget.map!['avatar'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Form(
            key: formkey,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                    alignment: Alignment.topCenter,
                    child: const Text(
                      "Details",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "Please Enter Name";
                    }
                    return null;
                  },
                  controller: namecontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                    labelText: "Name",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "Please Enter Image";
                    }
                    return null;
                  },
                  controller: image,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                    labelText: "Image",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                    onPressed: () {
                       if (formkey.currentState!.validate()) {
                         if (widget.map == null) {
                           InsertUser()
                               .then((value) => Navigator.of(context).pop(true));
                         } else {
                           Updatedata(widget.map!['id'])
                               .then((value) => Navigator.of(context).pop(true));
                         }
                       }

                    },
                    child: const Icon(Icons.arrow_forward_outlined))
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<http.Response> InsertUser() async {
    Map m = {};
    m['name'] = namecontroller.text;
    m['avatar'] = image.text;
    var response = await http.post(
        Uri.parse("https://6346afcb9eb7f8c0f882ab8e.mockapi.io/flutter_demo"),
        body: m);
    return response;
  }

  Future<http.Response> Updatedata(id) async {
    Map m = {};
    m['name'] = namecontroller.text;
    m['avatar'] = image.text;

    var response = await http.put(
        Uri.parse(
            "https://6346afcb9eb7f8c0f882ab8e.mockapi.io/flutter_demo/$id"),
        body: m);
    return response;
  }
}
