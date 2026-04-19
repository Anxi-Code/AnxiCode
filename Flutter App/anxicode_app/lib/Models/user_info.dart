


class UserInfo{
  String name;
  String userName;
  String email;
  String password;
  UserInfo({
    required this.name,
    required this.userName,
    required this.email,
    required this.password,
  });

  //getters
  String get getName => name;
  String get getUserName => userName;
  String get getEmail => email;
  String get getPassword => password;
}

