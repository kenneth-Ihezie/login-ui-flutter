import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/Api/Api.dart';
import 'package:login_ui/model/Http_Response.dart';
import 'HomeScreen.dart';
import 'ForgotPassword.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _textControllerUserName = TextEditingController();
  var _textControllerPassword = TextEditingController();
  var result = "";

  @override
  void dispose() {
    _textControllerUserName.dispose();
    _textControllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LoginUI"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0)),
            /*Image(
              image: AssetImage('images/img.jpeg'),
              width: 150.0,
              height: 150.0,
            ),*/
            Text(result),
            Padding(padding: EdgeInsets.only(top: 16.0)),
            TextField(
              controller: _textControllerUserName,
              onChanged: (String text) {
                setState(() {});
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: "Example@gmail.com",
                  prefixIcon: Icon(
                    Icons.email,
                  )),
            ),
            TextField(
              controller: _textControllerPassword,
              onChanged: (String text) {
                setState(() {});
              },
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.vpn_key),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 16.0)),
            _widgetButton(_textControllerUserName.text, _textControllerPassword.text),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                    textColor: Colors.blue,
                    color: Colors.white,
                    onPressed: _navigateForgotPassword,
                    child: Text("Forgot Password?"))
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      /*  bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavBarItem(),
      ),*/
    );
  }

  //bottom navigation bar.
 /* List<BottomNavigationBarItem> _bottomNavBarItem() {
    var _bottomNavBar = List<BottomNavigationBarItem>();
    _bottomNavBar.add(BottomNavigationBarItem(
        icon: Icon(Icons.android, color: Colors.blueAccent), label: ""));
    _bottomNavBar.add(BottomNavigationBarItem(
        icon: Icon(Icons.android, color: Colors.blueAccent), label: ""));
    _bottomNavBar.add(BottomNavigationBarItem(
        icon: Icon(Icons.android, color: Colors.blueAccent), label: ""));
    _bottomNavBar.add(BottomNavigationBarItem(
        icon: Icon(Icons.android, color: Colors.blueAccent), label: ""));
    return _bottomNavBar;
  }*/

  Widget _widgetButton(String email, String password) {
    return RaisedButton(
        color: Colors.blue,
        onPressed: _trackButtonState() ? () => _getUserStatus(email, password) : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Login")],
          ),
        ));
  }

  _getUserStatus(String email, String password){
    var api = Api();
    var response = api.getUserStatus(email, password);
    FutureBuilder<HttpResponse>(
      future: response,
      builder: (context, snapshot){
        if(snapshot.hasData){
          if(snapshot.data.status == "success"){
            return _navigateHomeScreen();
          }
        } else if(snapshot.hasError){
          setState(() {
            result = "Failed to login";
          });
        }
        return CircularProgressIndicator();
      },
    );
  }

  //to navigate to the home screen
  _navigateHomeScreen() {
    Navigator.of(context).pushNamed('/homeScreen');
    setState(() {
      //initialize the userName variable from HomeScreen class
      userName = _textControllerUserName.text;
      //store the user password in map variable in the ForgotScreen class
      ForgotPasswordState.map[_textControllerUserName.text] = _textControllerPassword.text;
    });
  }
  //to navigate to the forgot password screen
  _navigateForgotPassword(){
    Navigator.of(context).pushNamed('/forgotPassword');
  }
  //track the state of the login button
  bool _trackButtonState() {
    bool check = false;
    setState(() {
      if (_textControllerUserName.text.length > 0 &&
          _textControllerPassword.text.length > 0) {
        check = true;
      }
    });
    return check;
  }
}
