
class City {
  final int id;
  final String name;

  City({this.id, this.name});

  Map<String, dynamic> toMap() {
    return{
      'id': id,
      'name': name,
    };
    }

}

