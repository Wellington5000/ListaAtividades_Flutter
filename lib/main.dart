import 'Register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'ListActivity.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'LoginUser.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool login;
  String email, senha;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    setState(() {
      login = false;
    }); 
  }

  void initiateFacebookLogin() async {
    var facebookLogin = FacebookLogin();
    var facebookLoginResult = await facebookLogin.logIn(['email']);
     switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        setState(() {
          login = false;
        });
        break;
      case FacebookLoginStatus.cancelledByUser:
        setState(() {
          login = false;
        });
        break;
      case FacebookLoginStatus.loggedIn:
        var graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=${facebookLoginResult.accessToken.token}');
        var profile = json.decode(graphResponse.body);
        
        Navigator.push(context, MaterialPageRoute(builder: (context) => Tela2(profile)),);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      	width: double.maxFinite,
      	height: double.maxFinite,
      	color: Colors.tealAccent,
      	child: Stack(
      	  children: <Widget>[
            Image.asset('images/postIt.jpg'),
      	  	Positioned(
              top: 200,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 42, horizontal: 42),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(90)
                  )
                ),
                child: Column(
                  children: <Widget>[
                    TextField(
                      onChanged: (text){
                        email = text;
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.perm_identity),
                        hintText: "Email",
                      ),
                    ),
                    TextField(
                      onChanged: (text){
                        senha = text;
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.vpn_key),
                        hintText: "Senha"
                      ),
                    ),
                    SizedBox(
                      height: 20
                    ),
                    Text("OU"),
                    SizedBox(height: 20,),
                    Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                       width: 150,
                       height: 40,
                       child: RaisedButton.icon(
                         onPressed: initiateFacebookLogin,
                         icon: Image.asset('images/1.png', width: 40, height: 33,),
                         label: Text("Facebook", style: TextStyle(color: Colors.white),),
                         color: Color(0xff3b5998),
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(20)
                         ),
                       ),
                     ),
                     SizedBox(width: 25,),
                      Container(
                        width: 150,
                        height: 40,
                        child: RaisedButton.icon(
                          onPressed: (){
                            Auth au = new Auth();
                            print(email);
                            au.signIn(email, senha);
                          },
                          label: Text("Google  "),
                          color: Colors.white,
                          icon: Image.asset('images/google.png'),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                          ),
                        ),
                      ),
                    ],
                  )
                ]
              ),
            ),
                  ]
                )
              )
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Não tem acesso?',
                        style: TextStyle(
                          color: Colors.grey
                        ),
                      ),
                      RaisedButton(
                        onPressed: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => Cadastro()))},
                        child: Text("Cadastre-se", style: TextStyle(color: Colors.grey, decoration: TextDecoration.underline),),
                        color: Colors.white,
                        elevation: 0,
                      )
                    ],
                  ),
                ],
              ),
            ),
      	  ]
      	)
      )
    );
  }
}
