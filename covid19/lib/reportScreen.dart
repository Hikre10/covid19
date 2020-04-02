import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  Firestore _firestore = Firestore();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Total Reports"),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              tooltip: "Filter",
              elevation: 0,
              backgroundColor: Colors.redAccent.shade200,
              onPressed: () {
                // TODO implement search [ data will be key of search ]
                // _filterDialog();
              },
              child:
                  Icon(FontAwesomeIcons.search, color: Colors.white.withOpacity(0.9)),
            ),
          ),
        ],
      ),
      body: StreamBuilder(
          stream: _firestore.collection("survey").snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<DocumentSnapshot> document = snapshot.data.documents;
              return DataTable(
                columns: [
                  DataColumn(label: Text("Address")),
                  DataColumn(label: Text("Age")),
                  DataColumn(label: Text("Address")),
                  DataColumn(label: Text("Age")),
                  DataColumn(label: Text("Address")),
                  DataColumn(label: Text("Age")),
                  DataColumn(label: Text("Address")),
                  DataColumn(label: Text("Age")),
                  DataColumn(label: Text("Address")),
                  DataColumn(label: Text("Age")),
                  DataColumn(label: Text("Address")),
                  DataColumn(label: Text("Age")),
                  DataColumn(label: Text("Address")),
                  DataColumn(label: Text("Age")),
                  DataColumn(label: Text("Address")),
                  DataColumn(label: Text("Age")),
                ],
                rows: document.map((e) {
                  Timestamp time = e.data["date"];
                  DateTime _date = time.toDate();
                  return DataRow(
                    cells: [
                      DataCell(Text(e.data["address"])),
                      DataCell(Text(e.data["age"])),
                      DataCell(Text(e.data["ans1"])),
                      DataCell(Text(e.data["ans2"])),
                      DataCell(Text(e.data["ans3"])),
                      DataCell(Text(e.data["ans4"])),
                      DataCell(Text(e.data["ans5"])),
                      DataCell(Text(e.data["ans6"])),
                      DataCell(Text(e.data["ans7"])),
                      DataCell(Text(e.data["ans8"])),
                      DataCell(Text(e.data["ans9"])),
                      DataCell(Text(e.data["contactno"])),
                      DataCell(Text(_date.toString())),
                      DataCell(Text(e.data["fullname"])),
                      DataCell(Text(e.data["houseno"])),
                      DataCell(Text(e.data["ward"])),
                    ],
                  );
                }).toList(),
              );
            } else {
              return Center(child: Text("Loading"));
            }
          }),
    );
  }
}
