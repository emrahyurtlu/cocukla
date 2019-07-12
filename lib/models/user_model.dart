class UserModel {
  String uid;
  String name;
  String email;
  String password;
  bool isActive;
  int role;

  UserModel(
      {this.uid,
      this.name,
      this.email,
      this.password,
      this.isActive,
      this.role});
}
