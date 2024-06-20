import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';

class RefundPolicyScreen extends StatefulWidget {
  const RefundPolicyScreen({Key? key}) : super(key: key);

  @override
  State<RefundPolicyScreen> createState() => _RefundPolicyScreenState();
}

class _RefundPolicyScreenState extends State<RefundPolicyScreen> {
  Future<dynamic>? policyData;

  @override
  void initState() {
    policyData = fetchRefund();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Refund Policy"),
        ),
        body: Center(
          child: FutureBuilder<dynamic>(
            future: policyData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  children: [
                    Html(data: snapshot.data["data"]),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          ),
        ));
  }

  Future<dynamic> fetchRefund() async {
    final response = await http
        .get(Uri.parse("https://mdayurvediccollege.in/demo/autopart/api/policy"),headers:{'Content-Type': 'application/json'});
    try{
      return jsonDecode(response.body);
    }catch(e){
      print(response.statusCode);
      print("error=??"+e.toString());
    }
  }
}
