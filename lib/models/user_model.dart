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

  @override
  String toString() {
    return 'UserModel{uid: $uid, name: $name, email: $email, password: $password, isActive: $isActive, role: $role}';
  }
}
