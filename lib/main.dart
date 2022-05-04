// ignore_for_file: prefer_const_constructors, unused_local_variable, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'convert_page.dart';
const request = "https://api.hgbrasil.com/finance";
void main() async{

  runApp(MaterialApp(
    home: ConvertPage(),
    debugShowCheckedModeBanner: false,
  ));
}

Future<Map> getData() async{
  http.Response response = await http.get(Uri.parse(request));
  return json.decode(response.body);
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ConvertPage(),
//     );
//   }
// }
