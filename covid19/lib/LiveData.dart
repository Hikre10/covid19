import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LiveData extends StatefulWidget {
  @override
  _LiveDataState createState() => _LiveDataState();
}

class _LiveDataState extends State<LiveData> {
  bool flag = false;
  int result;

  String url = "https://api.covid19api.com/summary";
  List data = [];
  Future<String> getJsonData() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {'Accept': 'application/json'});
    // print(response.body);
    setState(() {
      var convertDataJson = json.decode(response.body);
      data = convertDataJson['Countries'];
    });
    return 'success';
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      this.getJsonData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('COVID 19 LIVE UPDATE'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: data.length == null ? 0 : data.length,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    index = 1;
                    flag = false;
                  } else {
                    if (flag == false) {
                      flag = true;
                    } else {
                      flag = false;
                    }
                  }

                  return data.length == null
                      ? CircularProgressIndicator()
                      : Card(
                          elevation: 0,
                          color: flag == false
                              ? Colors.orange.shade100
                              : Colors.green.shade100,
                          child: ListTile(
                            title: Text(data[index]['Country'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                    'New Comfirmed: ' +
                                        data[index]['NewConfirmed'].toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                                Text(
                                    'Total Confirmed: ' +
                                        data[index]['TotalConfirmed']
                                            .toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                                Text(
                                    'New Deaths:' +
                                        data[index]['NewDeaths'].toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                                Text(
                                    'Total Deaths: ' +
                                        data[index]['TotalDeaths'].toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                                Text(
                                    'New Revocered: ' +
                                        data[index]['NewRecovered'].toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                                Text(
                                    'Total Recovered: ' +
                                        data[index]['TotalRecovered']
                                            .toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                        );
                },
              )
            ],
          ),
        ));
  }
}