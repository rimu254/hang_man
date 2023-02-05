class User {
  //create login user
  static Future<Null> login(String username, String password) async {
    //create user
    final user = User(username, password);
    //save user
    await user.save();
  }
}