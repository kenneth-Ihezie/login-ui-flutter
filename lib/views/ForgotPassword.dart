import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  ForgotPasswordState createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPassword> {
  var _textPasswordController = TextEditingController();
  //this is used to store the user password and static identify makes it store the password of different users.
  static Map map = Map();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Forgot Password"),
        ),
        body: Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                        child: TextField(
                      controller: _textPasswordController,
                      onChanged: (String text){
                        setState(() {
                          _textPasswordController.text;
                        });
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                        Icons.email,
                        color: Colors.blue,
                      )),
                    )),
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 16.0)),
                //the text widget to print out the user password
                Text(_showPassword(_textPasswordController.text)),
              ],
            )));
  }
  //to change the text widget and print out the user password
  String _showPassword(String text) {
    String password;
    setState(() {
      if (text == null) {
        password = "text is null";
      } else {
        password = text;
        if (password.length > 0)
          try {
            password = "Your Password is: " + map[text];
          } catch (e) {
            password = "No Match Found";
          }
      }
      print(_textPasswordController.text);
    });

    return password;
  }

}
