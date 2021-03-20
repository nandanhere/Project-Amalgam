import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(String email, String password, String userName,
      String role, bool isLogin, BuildContext ctx) submitData;
  final bool isLoading;
  const AuthForm({Key key, this.submitData, this.isLoading}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  String _userEmail = "";
  String _userName = "";
  String _userPassword = "";
  String _userRole = "";

  @override
  Widget build(BuildContext context) {
    FocusNode _user = new FocusNode();
    FocusNode _password = new FocusNode();
    FocusNode _role = new FocusNode();
    TextEditingController _email = new TextEditingController();
    double width = MediaQuery.of(context).size.width;
    return Center(
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _email,
                    key: ValueKey("Email"),
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return "Enter Valid Email";
                      }
                      return null;
                    },
                    onFieldSubmitted: (str) {
                      FocusScope.of(context)
                          .requestFocus(_isLogin ? _password : _user);
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email",
                    ),
                    onSaved: (value) {
                      _userEmail = value;
                    },
                    onChanged: (value) {
                      _userEmail = value;
                    },
                  ),
                  if (_isLogin == false)
                    TextFormField(
                      focusNode: _user,
                      key: ValueKey("UserName"),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "UserName",
                      ),
                      onSaved: (value) {
                        _userName = value;
                      },
                      onFieldSubmitted: (str) {
                        FocusScope.of(context).requestFocus(_role);
                      },
                    ),
                  if (_isLogin == false)
                    TextFormField(
                      focusNode: _role,
                      key: ValueKey("Role"),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Role",
                      ),
                      onSaved: (value) {
                        _userRole = value;
                      },
                      onFieldSubmitted: (str) {
                        FocusScope.of(context).requestFocus(_password);
                      },
                    ),
                  TextFormField(
                    focusNode: _password,
                    key: ValueKey("Password"),
                    validator: (value) {
                      if (value.length < 1) {
                        return "Password must be longer";
                      }
                      return null;
                    },
                    obscureText: true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Password",
                    ),
                    onSaved: (value) {
                      _userPassword = value;
                    },
                    onFieldSubmitted: (str) {},
                  ),
                  (_isLogin == true)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                if (_userEmail.isEmpty ||
                                    !_userEmail.contains('@')) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    backgroundColor:
                                        Theme.of(context).errorColor,
                                    content: Text(
                                      "Enter your email ID to reset your password",
                                    ),
                                  ));
                                } else {}
                              },
                              child: Text("Forgot Password?",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600)),
                            )
                          ],
                        )
                      : Container(),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).primaryColor),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    child: Container(
                        width: width / 2,
                        child: Text(
                          _isLogin ? "Sign In " : "Sign Up",
                          textAlign: TextAlign.center,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          (_isLogin)
                              ? Text("Don't have an account?")
                              : Text("Already have an account?"),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  _isLogin = !_isLogin;
                                });
                              },
                              child: (_isLogin)
                                  ? Text("Sign Up")
                                  : Text("Sign In"))
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
