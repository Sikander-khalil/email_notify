import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sendgrid_mailer/sendgrid_mailer.dart';

class GridMailScreen extends StatefulWidget {
  const GridMailScreen({super.key});

  @override
  State<GridMailScreen> createState() => _GridMailScreenState();
}

class _GridMailScreenState extends State<GridMailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            sendMail();
          },
          child: Container(
            padding: EdgeInsets.all(10),
            color: Colors.lightBlue,
            child: Text("Send Mail"),
          ),
        ),
      ),
    );
  }

  void sendMail() {
    final mailer = Mailer(
        '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');

    final toAddress = Address('sikanderkhalil056@gmail.com');
    final fromAddress = Address('sikubahibaijan@gmail.com');

    final content = Content('text/plain', 'Hello Sir Please login');
    final subject = "Info about Login!";

    final personalization = Personalization([toAddress]);
    final email =
        Email([personalization], fromAddress, subject, content: [content]);

    mailer.send(email).then((result) {
      print(result.isValue);
    });
  }
}
