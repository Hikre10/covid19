import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  Firestore _firestore = Firestore();
  var _key = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _mobile = TextEditingController();
  TextEditingController _post = TextEditingController();
  TextEditingController _ward = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width / 2,
        child: Form(
          key: _key,
          child: Column(
            children: <Widget>[
              // * name
              TextFormField(
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Please Enter Name";
                  }
                },
                decoration: InputDecoration(hintText: "Name"),
                controller: _name,
              ),

              // * mobile
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please Enter Mobile Number";
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: "Mobile"),
                controller: _mobile,
              ),

              // * post
              TextFormField(
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Please Enter post";
                  }
                },
                decoration: InputDecoration(hintText: "Post"),
                controller: _post,
              ),

              // * ward
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: "Ward"),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please Enter Ward Number";
                  }
                },
                controller: _ward,
              ),

              MaterialButton(
                onPressed: () async {
                  if (_key.currentState.validate()) {
                    await _firestore.collection("contact").add({
                      "name": _name.text,
                      "post": _post.text,
                      "ward": int.parse(_ward.text),
                      "mobile": _mobile.text
                    });
                  }
                },
                child: Text("Send", style: TextStyle(color: Colors.white)),
                color: Colors.green,
              )
            ],
          ),
        ),
      ),
    );
  }
}
