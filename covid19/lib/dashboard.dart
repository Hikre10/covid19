import 'package:covid19/reportScreen.dart';
import 'package:covid19/tips.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Widget _dashboardInfo() {
    return GridView.count(
      crossAxisSpacing: 4,
      mainAxisSpacing: 2,
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      children: <Widget>[
        //! total report section
        StreamBuilder(
          stream: Firestore.instance.collection("survey").snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<DocumentSnapshot> document = snapshot.data.documents;
              return Opacity(
                opacity: 0.8,
                child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: Colors.green.shade300,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ReportScreen()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Row(
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.truckLoading,
                                color: Colors.green.shade800,
                                size: 15,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text("Report",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.green.shade800,
                                        fontSize: 20)),
                              ),
                            ],
                          ),
                          subtitle: Center(
                              child: Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Text(document.length.toString(),
                                style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                )),
                          )),
                        ),
                      ),
                    )),
              );
            } else {
              return Center(child: Text("Loading..."));
            }
          },
        ),

        //! Total Recovered section
        Opacity(
          opacity: 0.8,
          child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.blueAccent.shade100,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Dashboard()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Row(
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.moneyBillAlt,
                          color: Colors.blueAccent.shade700,
                          size: 15,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            "Recovered",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.blueAccent.shade700,
                                fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Center(
                        child: Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Text("4",
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          )),
                    )),
                  ),
                ),
              )),
        ),

        // ! Total Tips section
        StreamBuilder(
          stream: Firestore.instance.collection("tips").snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<DocumentSnapshot> document = snapshot.data.documents;
              return Opacity(
                opacity: 0.8,
                child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Colors.yellow.shade400,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Tips()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Row(
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.luggageCart,
                                size: 15,
                                color: Colors.yellow.shade900,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  "Tips",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.yellow.shade900,
                                      fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                          subtitle: Center(
                              child: Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Text(document.length.toString(),
                                style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                )),
                          )),
                        ),
                      ),
                    )),
              );
            } else {
              return Center(
                child: Text("Loading..."),
              );
            }
          },
        ),

        // ! Total Victim section
        Opacity(
          opacity: 0.8,
          child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.redAccent.shade200,
              child: InkWell(
                onTap: () {
                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Wallet()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Row(
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.wallet,
                          size: 15,
                          color: Colors.redAccent.shade700,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            "Victim",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.redAccent.shade700,
                                fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Center(
                        child: Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Text("4",
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          )),
                    )),
                  ),
                ),
              )),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white.withOpacity(0.9)),
        // backgroundColor: Colors.grey[100],
        title: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.redAccent, borderRadius: BorderRadius.circular(10)),
          child: Text(
            'COVID-19',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: <Widget>[
          SizedBox(
            height: 5,
          ),
          _dashboardInfo(),
        ],
      ),
    );
  }
}
