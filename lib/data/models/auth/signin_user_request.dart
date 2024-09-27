class SigninUserRequest {
  final String email;
  final String password;

  SigninUserRequest({ required this.email, required this.password} ){
    print('test: SigninUserRequest: email: $email, password: $password');
  }
}
