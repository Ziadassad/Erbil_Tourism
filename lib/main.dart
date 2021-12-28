import 'dart:async';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firstapp/language.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Map.dart';
import 'HomePage.dart';
import 'PersonInformation.dart';
import 'Setting.dart';
import 'About.dart';
import 'Login.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


Future<void> main() async{
  runApp(MyApp());
}



class MyApp extends StatefulWidget {


  @override
  _MyAppState createState() => _MyAppState();

  static void setLocal(BuildContext context , Locale locale){
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocal(locale);
  }
}

class _MyAppState extends State<MyApp> {

  Future<dynamic> isLogin() async{
    bool login ;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    login = sharedPreferences.getBool("login");
    if(login == null){
      return false;
    }
    if(login){
      return true;
    }
    else{
      return false;
    }
  }

  Stream<bool> DarkMode() async*{
  SharedPreferences sh = await SharedPreferences.getInstance();
  bool dark = sh.getBool("dark");
  if(dark == null){
    darkMode = true;
    yield false;
  }
  if(dark == true){
    darkMode = true;
    yield true;
  }
  else{
    darkMode = false;
    yield false;
  }
  }

  bool darkMode ;


  Locale _locale ;

  void setLocal(Locale locale){
    setState(() {
      _locale = locale;
    });
  }

  getlocal() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String str = sharedPreferences.getString("local");
    switch(str){
      case "en":
        setLocal(Locale("en" , "US"));
        break;
      case "ar":
        setLocal(Locale("ar" , "AE"));
        break;
    }
  }

  @override
  void initState(){
    // TODO: implement initStateg
    getlocal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   // final themeNotifier = Provider.of<ThemeChange>(context);
    return StreamBuilder(
      stream: DarkMode(),
       builder: (context , snapshot){
          if(!snapshot.hasData){
            return Container();
          }
          else{
            return MaterialApp(
              locale: _locale,

              supportedLocales: [
                Locale("en" , "EN"),
                Locale("ar" , "AE")
              ],

              localizationsDelegates: [
                Languages.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate
              ],
              localeResolutionCallback: (deviceLocal , supportLocal){
                for(var local in supportLocal){
                  if(local.languageCode == deviceLocal.languageCode && local.countryCode == deviceLocal.countryCode){
                      return local;
                  }
                }
                return supportLocal.first;
              },

              theme: snapshot.data || darkMode ? ThemeData.dark(): ThemeData.light(),
              home: FutureBuilder(
                future: isLogin(),
                builder: (context , snapshot){
                  if(snapshot.connectionState == ConnectionState.none &&
                      snapshot.hasData == null){
                    return Container();
                  }
                  else{
                    if(snapshot.data == false){
                      return Login();
                    }
                    else{
                      return MainApp();
                    }
                  }
                },
              ),
            );
          }
        }
    );
  }
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  int currentPage = 0;

  final pages = [
    HomePage(),
    Map(),
    PersonInformation(),
    Setting(),
    About()
  ];

  @override
  Widget build(BuildContext context) {
    return  Builder(
      builder : (context) => Scaffold(
        appBar: AppBar(
          title: Text(Languages.of(context).getLocal('Tourism')),
          centerTitle: true,
        ),

        body: pages[currentPage] ,
        bottomNavigationBar: CurvedNavigationBar(
          color: Colors.blue,
          backgroundColor: Colors.white,
          buttonBackgroundColor: Colors.green,
          height: 50,
          items: <Widget>[
            Icon(Icons.home , size: 20,color: Colors.black,),
            Icon(Icons.map , size: 20,color: Colors.black,),
            Icon(Icons.person , size: 20,color: Colors.black,),
            Icon(Icons.settings , size: 20,color: Colors.black,),
            Icon(Icons.help , size: 20,color: Colors.black,)
          ],
//            animationDuration: Duration(
//              microseconds: 200
//            ),
          //animationCurve: Curves.bounceIn,
          onTap: (index){
            this.setState(() {
              currentPage = index;
            });
            //print(index);
          },
        ),
      ),
    );
  }
}



