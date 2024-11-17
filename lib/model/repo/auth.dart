import 'package:realm/realm.dart';

class Auth{

  String id;
  Uri baseUrl;
  App app;
  User? currentUser;
  Auth(this.id, this.baseUrl) : app = App(AppConfiguration(id, baseUrl: baseUrl));

  Future<User> logInUserEmailPassword(String email, String password) async {
      User loggedInUser = await app.logIn(Credentials.emailPassword(email, password));
      currentUser = loggedInUser;
      print('logged in');
      return loggedInUser;
  }

  Future<User> registerUserEmailPassword(String email, String password) async {
    EmailPasswordAuthProvider authProvider = EmailPasswordAuthProvider(app);
    await authProvider.registerUser(email, password);
    User loggedInUser = await app.logIn(Credentials.emailPassword(email, password));
    currentUser = loggedInUser;
    return loggedInUser;
  }

  Future<User> logInUserAnonymous() async {
    User loggedInUser = await app.logIn(Credentials.anonymous());
    currentUser = loggedInUser;
    print('logged in');
    return loggedInUser;
  }

  Future<void> logOut() async {
    await currentUser?.logOut();
    currentUser = null;
  }

}