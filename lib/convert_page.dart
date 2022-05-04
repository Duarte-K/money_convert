// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element, unused_local_variable, unused_local_variable

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:money_convert/main.dart';

class ConvertPage extends StatefulWidget {
  const ConvertPage({ Key? key }) : super(key: key);
  @override
  State<ConvertPage> createState() => _ConvertPageState();
}

class _ConvertPageState extends State<ConvertPage> {

  final realControlller = TextEditingController();
  final dolarControlller = TextEditingController();
  final euroControlller = TextEditingController();

  late double dolar; 
  late double euro;

  void realChanged(String text){
    if(text.isEmpty){
      dolarControlller.text = "";
      euroControlller.text = "";
      return;
    }
    double real = double.parse(text);
    dolarControlller.text = (real/dolar).toStringAsFixed(2);
    euroControlller.text = (real/euro).toStringAsFixed(2);
  }

  void dolarChanged(String text){
    if(text.isEmpty){
      realControlller.text = "";
      euroControlller.text = "";
      return;
    }
    double dolar = double.parse(text);
    realControlller.text = (dolar * this.dolar).toStringAsFixed(2);
    euroControlller.text = (dolar * this.dolar / euro).toStringAsFixed(2);
  }

  void euroChanged(String text){
    if(text.isEmpty){
      dolarControlller.text = "";
      realControlller.text = "";
      return;
    }
    double euro = double.parse(text);
    realControlller.text = (euro * this.euro).toStringAsFixed(2);
    dolarControlller.text = (euro * this.euro / dolar).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$ Conversor \$", style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text("Carregando dados...",
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                )
              );
            default:
              if(snapshot.hasError){
                return Center(
                  child: Text("Error ao carregar dados",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  )
                );
              }else{
                dolar = snapshot.data!["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data!["results"]["currencies"]["EUR"]["buy"];
                return SingleChildScrollView(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Icon(Icons.monetization_on, size: 150, color: Colors.amber),
                      buildTextField("Real", "R\$", realControlller, realChanged),
                      Divider(),
                      buildTextField("Dólar", "US\$", dolarControlller, dolarChanged),
                      Divider(),
                      buildTextField("Euro", "€", euroControlller, euroChanged),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}

Widget buildTextField(String label, String prefix, TextEditingController c, Function(String) f){
  return TextField(
    controller: c,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: Colors.amber
      ),
      hintStyle: TextStyle(color: Colors.amber),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      prefixText: prefix,
    ),
    style: TextStyle(
      color: Colors.amber,
      fontSize: 25
    ),
    onChanged: f,
    keyboardType: TextInputType.number,
  );
}
