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
              child: Icon(FontAwesomeIcons.search,
                  color: Colors.white.withOpacity(0.9)),
            ),
          ),
        ],
      ),
      body: StreamBuilder(
          stream: _firestore.collection("survey").snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<DocumentSnapshot> document = snapshot.data.documents;
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text("मिति")),
                    DataColumn(label: Text("Status")),
                    DataColumn(label: Text("नाम")),
                    DataColumn(label: Text("सम्पर्क नम्बर")),
                    DataColumn(label: Text("उमेर")),
                    DataColumn(label: Text("प्रयोककर्ता\nको लिङ्ग")),
                    DataColumn(label: Text("तापक्रम")),
                    DataColumn(label: Text("क्वारेन्टाइनमा \nबसेको")),
                    DataColumn(label: Text("सुख्खा तथा \nलहरे खोकीः")),
                    DataColumn(label: Text("थकाई लाग्ने")),
                    DataColumn(label: Text("घाँटी बस्नेः")),
                    DataColumn(
                        label: Text("आराम गर्दा पनि सास\n छोटो भएजस्तो लाग्ने")),
                    DataColumn(label: Text("जीउ दुखाईः")),
                    DataColumn(label: Text("पखालाः")),
                    DataColumn(label: Text("वाकवाकीः")),
                    DataColumn(label: Text("सिँगान बग्नेः")),
                    DataColumn(
                        label: Text("कोरोनाले ग्रस्त \nमुलुकबाट फर्कनुभएको")),
                    DataColumn(
                        label: Text("संक्रमणको भएको \nव्यक्तिको सम्पर्कमा")),
                    DataColumn(label: Text("ठेकाना")),
                    DataColumn(label: Text("वार्ड")),
                    DataColumn(label: Text("घर नम्बर")),
                    DataColumn(label: Text("something")),
                  ],
                  rows: document.map((e) {
                    // * converting timestamp into date
                    Timestamp time = e.data["date"];
                    DateTime _date = time.toDate();

                    // * calculating 
                    Color _riskcolor = Colors.red;
                    Color _normalcolor = Colors.green;
    
                    return DataRow(
                      cells: [
                        DataCell(Text(_date.toString())),
                        DataCell(Text(e.data["status"], style: TextStyle(color: e.data["status"] == "High Risk" ? _riskcolor: _normalcolor),)),
                        DataCell(Text(e.data["fullname"])),
                        DataCell(Text(e.data["contactno"])),
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
                        DataCell(Text(e.data["ans10"])),
                        DataCell(Text(e.data["ans11"])),
                        DataCell(Text(e.data["ans12"])),
                        DataCell(Text(e.data["ans13"])),
                        DataCell(Text(e.data["address"])),
                        DataCell(Text(e.data["ward"])),
                        DataCell(Text(e.data["houseno"])),
                        DataCell(MaterialButton(onPressed: (){}, color: Colors.red, child: Text("Take Action", style: TextStyle(color: Colors.white),))),
                      ],
                    );
                  }).toList(),
                ),
              );
            } else {
              return Center(child: Text("Loading"));
            }
          }),
    );
  }
}
