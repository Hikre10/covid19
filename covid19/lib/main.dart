import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // * login Screen
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Firestore _firestore = Firestore();

  Widget emailField() {
    return TextFormField(
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(5),
          border: OutlineInputBorder(),
          hintText: "Email...",
          labelText: "Email"),
    );
  }

  Widget pwdField() {
    return TextFormField(
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(5),
          border: OutlineInputBorder(),
          hintText: "Password...",
          labelText: "Password"),
    );
  }

  Widget signinForm() {
    return Form(
      child: Column(
        children: <Widget>[
          emailField(),
          SizedBox(
            height: 8,
          ),
          pwdField(),
        ],
      ),
    );
  }

  Widget signinButton() {
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      // padding: EdgeInsets.all(10),
      child: MaterialButton(
        color: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.of(context).pushReplacement(PageRouteBuilder(
              pageBuilder: (_, __, ___) => Dashboard(),
              transitionDuration: Duration(seconds: 2)));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "LogIn",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget signinLogo() {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          shape: BoxShape.circle, border: Border.all(color: Colors.blue)),
      child: Icon(
        Icons.person_outline,
        size: 35,
        color: Colors.blue,
      ),
    );
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> _handleSignIn() async {
    print("hello");
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);
    return user;
  }

  void _signInWithEmailAndPassword() async {
    final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
      email: "sangamsky10@gmail.com",
      password: "bigbang123456789",
    )).user;
    if (user != null) {
      print(user.email);
    } else {
      print("something went wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // ! check in other device if form is centered or not
              SizedBox(height: 150),

              // * whole sign in form
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width / 2.8,
                  child: Column(
                    children: <Widget>[
                      // * signin logo
                      signinLogo(),

                      // * sign in text
                      Text(
                        "Sign In",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w400),
                      ),

                      SizedBox(
                        height: 30,
                      ),

                      // * delivery signin form
                      signinForm(),

                      SizedBox(
                        height: 10,
                      ),

                      // *  button
                      signinButton(),

                      // ! google signin
                      MaterialButton(
                        color: Colors.redAccent,
                        onPressed: () {
                          
                          _signInWithEmailAndPassword();
                          _handleSignIn();
                        },
                        child: Text(
                          "Google Sign In",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
