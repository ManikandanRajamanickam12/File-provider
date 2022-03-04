import 'dart:html';

import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class DisplayData extends StatefulWidget {
  const DisplayData({Key? key}) : super(key: key);

  @override
  State<DisplayData> createState() => _DisplayDataState();
}

class _DisplayDataState extends State<DisplayData> {
  List<List<dynamic>> data = [];

  loadAsset() async {
    final myData = await rootBundle.loadString("questions.csv");
    List<List<dynamic>> csvTable = CsvToListConverter().convert(myData);

    data = csvTable;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: () async {
            await loadAsset();

            setState(() {});
          }),

      body: Table(
        children: data.map((item) {
          return TableRow(
              children: item.map((subitem) {
            return Text(subitem.toString());
          }).toList());
        }).toList(),
      ),

      // body: Container(
      //   child: Column(
      //     children: data.map((e) {
      //       print(data[0][0]);
      //       return Text("shdj");
      //     }).toList(),
      //   ),
      // )
      // body: Table(
      //     children: data.map((item) {
      //   return TableRow(children: [Text("jahdsj")]);
      // }).toList()),
    );
  }
}
