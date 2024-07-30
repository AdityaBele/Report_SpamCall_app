import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SMS Launcher Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String companyName = "ExampleCompany";
  final String mobileNoWithCountryCode = "+1234567890";
  final String callDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

  void _sendSms() async {
    final String message =
        "Unsolicited marketing call from $companyName, $mobileNoWithCountryCode, $callDate";

    final Uri smsUri = Uri(

      scheme: 'sms',
      queryParameters: <String, String>{
        'body': message,
      },
    );


    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
      throw 'Could not launch $smsUri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SMS Launcher Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _sendSms,
          child: Text('Send SMS'),
        ),
      ),
    );
  }
}
