import 'package:flutter/material.dart';

import 'package:sms/sms.dart';
import 'package:sms_reader/parser.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  SMSParser smsParser = new SMSParser();
  List<Map<String, dynamic>> listOfSms = [];

  void readSMS() async {
    SmsQuery smsQuery = new SmsQuery();
    List<SmsMessage> messages = await smsQuery.getAllSms;
    for (SmsMessage item in messages) {
      if(smsParser.checkIfMessageIsSpam(item.body) == false){
        if(smsParser.checkIfTransactionIsFromPaytm(item.body) || smsParser.checkIfTransactionIsFromSBI(item.body)){
          listOfSms.add(Map<String, dynamic>.from(item.toMap));
        }
      }
    }
    listOfSms.sort((a, b){
      return b['dateSent'] - a['dateSent'];
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    readSMS();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: listOfSms.length,
        itemBuilder: (BuildContext context, int index){
          return ListTile(
            title: Text(
              listOfSms[index]['address']
            ),
            subtitle: Text(
              listOfSms[index]['body']
            ),
          );
        },
      ),
    );
  }
}