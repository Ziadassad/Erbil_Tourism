
import 'package:firstapp/language.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();

}

class _SettingState extends State<Setting> {

  bool isSwitched = false;
  int selected ;

  getSelected() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    isSwitched =  sharedPreferences.getBool("dark");
    return isSwitched;
  }

  getlocal() async{ SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String str = sharedPreferences.getString("local");
    setState(() {
      switch(str){
        case "en":
          selected = 1;
          break;
        case "ar":
          selected = 2;
          break;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initStateg
    setState(() {
      getlocal();
      print(selected);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 30),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(Languages.of(context).getLocal("Setting") , style: TextStyle(fontSize: 40 , color: Colors.blue,)),
            SizedBox(height: 40,),
            ListTile(
                title: Row(
                  children: <Widget>[
                    Text("Dark Mode", style: TextStyle(fontSize: 20),),
                    SizedBox(width: 10,),
                    Icon(Icons.brightness_6),
                  ],
                ),
              trailing: FutureBuilder(
                future: getSelected(),
                builder: (context , snapshot){
                  if(snapshot.connectionState == ConnectionState.none || snapshot.data == null){
                    return Switch(
                      value: false,
                      activeTrackColor: Colors.green,
                      onChanged: (check) {
                        this.setState((){
                          isSwitched = check;
                          SentDark(isSwitched);
                        });
                      },
                      activeColor: Colors.blue,
                    );
                  }else{
                    return Switch(
                      value: isSwitched,
                      activeTrackColor: Colors.green,
                      onChanged: (check) {
                        this.setState((){
                          isSwitched = check;
                          SentDark(isSwitched);
                          Navigator.pushAndRemoveUntil(context ,MaterialPageRoute(builder: (context) => MyApp()),  (Route<dynamic> route) => false);
                        });
                      },
                      activeColor: Colors.blue,
                    );
                  }
                },
              ),
              ),
            SizedBox(
              height: 100,
            ),
            Text(Languages.of(context).getLocal('changeLang') ,style: TextStyle(fontSize: 30,color: Colors.red),),
            Container(
              margin: EdgeInsets.only(left: 20, top: 50),
              alignment: Alignment.centerLeft,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Radio(
                        value : 1 ,
                        onChanged: (value){
                          setState(() {
                            selected = value;
                          });
                        },
                        groupValue: selected,
                      ),
                      Text("English" , style: TextStyle(fontSize: 20),),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Radio(
                        value: 2,
                        groupValue: selected,
                        onChanged: (value){
                          setState(() {
                            selected = value;
                          });
                        },
                      ),
                      Text(Languages.of(context).getLocal("Kurdish") , style: TextStyle(fontSize: 20),),
                    ],
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
              ),
              margin: EdgeInsets.only(top: 50),
              width: 200,
              child: Center(
                child: Container(
                  width: double.infinity,
                  child: FlatButton(
                    child: Text(Languages.of(context).getLocal('change')),
                    onPressed: (){
                      changeLanguage(selected);
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void changeLanguage(int language) async{
     Locale locale;

     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

     switch(language){
       case 1:
         locale = Locale('en' , 'US');
         sharedPreferences.setString("local", "en");
         break;
       case 2:
         locale = Locale('ar' , 'AE');
         sharedPreferences.setString("local", "ar" );
         break;
       default:
         locale = Locale('en' , 'US');
         sharedPreferences.setString("local", "en");
         break;
     }
     MyApp.setLocal(context , locale);
  }

  void SentDark(bool dark)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("dark", dark);
  }
}