import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Tips extends StatefulWidget {
  @override
  _TipsState createState() => _TipsState();
}

class _TipsState extends State<Tips> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tips"),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection("tips").orderBy("index", descending: false).snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<DocumentSnapshot> document = snapshot.data.documents;
            return ListView.builder(
              itemCount: document.length,
              itemBuilder: (BuildContext context, int index){
                return ListTile(
                  title: Text(document[index].data["question"]),
                  subtitle: Text(document[index].data["answer"]),
                );
              },
            );
          } else {
            return Text("Loading");
          }
        },
      ),
    );
  }
}
