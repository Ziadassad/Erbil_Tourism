

class Member{
  int id;
  String name;
  String email;
  String password;

  Member(this.id,this.name , this.email , this.password);

  Map<String , dynamic> toMap(){
    var map = <String , dynamic>{
      'id' : id,
      'name' : name,
      'email' : email,
      'password' : password
    };
    return map;
  }

  Member.fromMap(Map<String , dynamic> map){
    id = map['id'];
    name = map['name'];
    email = map['email'];
    password = map['password'];
  }

}