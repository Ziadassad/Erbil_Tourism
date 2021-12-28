
class DBTourism{

  int id;
  String name;
  String address;
  String image;
  double lang;
  double lat;

  DBTourism(this.id , this.name , this.address , this.image , this.lat, this.lang);

  Map<String, dynamic> toMap(){
    var map = <String, dynamic> {
      'id' : id,
      'name' : name,
      'address' : address,
      'image' : image,
      'late' : lat,
      'lang' : lang
    };
    return map;
  }

  DBTourism.fromMap(Map<String, dynamic> map){
    id = map['id'];
    name = map['name'];
    address = map['address'];
    image = map['image'];
    lat = map['late'];
    lang = map['lang'];
  }
}