
import 'package:shared_preferences/shared_preferences.dart';

class Shared{

  Shared();


  setAccount(name , email)async {
   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
   sharedPreferences.setString("name", name);
   sharedPreferences.setString("email", email);
  }

  isLogin(login)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("login", login);
  }

  Future<List<String>> getaccount() async {
    List<String> account = ["nothing", "nothing"];
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    account[0] = sharedPreferences.getString("name");
    account[1] = sharedPreferences.getString("email");

    return account;
  }

}