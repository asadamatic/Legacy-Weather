class City {
  final int? id;
  final String? name;
  final String? country;
  City({this.id, this.name, this.country});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}
