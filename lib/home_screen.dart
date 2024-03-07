import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  void sendMail(
      {required String recipientEmail, required String mailMessage}) async {
    String senderName = "sikanderkhalil056@gmail.com";

    String senderPasswordOnDevice = "caqbjnsemdaikjhc";
    final smtpServer = gmail(senderName, senderPasswordOnDevice);

    final message = Message()
      ..from = Address(senderName, 'Mail Service')
      ..recipients.add(recipientEmail)
      ..subject = 'Mail'
      ..text = 'Messages: $mailMessage';

    try {
      await send(message, smtpServer);
      showSnackbar("Email Sent Sucessfully");
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Send Mailer"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Recipient Email",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                maxLines: 5,
                controller: messageController,
                decoration: InputDecoration(
                  hintText: "Messages",
                  border: OutlineInputBorder(borderSide: BorderSide()),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  sendMail(
                    recipientEmail: emailController.text.toString(),
                    mailMessage: messageController.text.toString(),
                  );
                },
                child: Text("Send Mail"))
          ],
        ),
      ),
    );
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          message,
          style: TextStyle(fontSize: 10),
        )));
  }
}
