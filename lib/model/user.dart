

class User {
  int id;
  String name;
  List friends; 
  List interests;
  User(this.id, this.name, this.friends, this.interests);

  @override
  String toString() {
    return '$id $name $friends $interests';
  }
}

