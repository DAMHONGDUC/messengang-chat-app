import 'package:chat_app/models/userChat.dart';
import 'package:chat_app/providers/authProvider.dart';
import 'package:chat_app/screens/main_screen.dart';
import 'package:chat_app/screens/sign_up_screen.dart';
import 'package:chat_app/values/app_asstets.dart';
import 'package:chat_app/values/session_manager.dart';
import 'package:chat_app/widget/custom_dialog.dart';
import 'package:chat_app/widget/loadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoaing = false;
  bool _obscureText = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void SignIn(AuthProvider authProvider, BuildContext context) {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoaing = true;
      });
      authProvider.SignIn_WithEmailPasword(
              emailController.text, passwordController.text)
          .then((userchat) {
        if (userchat != null) {
          // lưu user hiện tại vào
          SessionManager prefs = SessionManager();
          prefs.setCurrUser(userchat.email.toString(), userchat.id.toString(),
              userchat.name.toString(), userchat.photo.toString());

          // điều hướng qua main
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MainsScreen()));
        } else {
          showAlertDialog(context, "Wrong email or password. Please try again",
              () {
            Navigator.of(context).pop();
          });
          setState(() {
            _isLoaing = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: SafeArea(
          child: _isLoaing
              ? LoadingWidget()
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 70,
                      ),
                      Image.asset(
                        Assets.Logo,
                        height: 100,
                        width: 100,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        "Sign in",
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 23),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                validator: (val) {
                                  return RegExp(
                                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                          .hasMatch(val.toString())
                                      ? null
                                      : "Please enter a valid email";
                                },
                                controller: emailController,
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.all(15.0),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    labelText: 'Email',
                                    labelStyle: TextStyle(fontSize: 14)),
                              ),
                              SizedBox(height: 15),
                              TextFormField(
                                obscureText: _obscureText,
                                validator: (val) {
                                  return val.toString().length <= 7
                                      ? "Please enter password 8+ character"
                                      : null;
                                },
                                controller: passwordController,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(15.0),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    labelText: 'Password',
                                    labelStyle: TextStyle(fontSize: 14),
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          _toggle();
                                        },
                                        icon: Icon(
                                          Icons.visibility,
                                          size: 20,
                                        ))),
                              ),
                              SizedBox(height: 15),
                              ElevatedButton(
                                  onPressed: () {
                                    SignIn(authProvider, context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: Size.fromHeight(40),
                                      shape: new RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)))),
                                  child: Text('Sign in')),
                            ],
                          ),
                        ),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.black),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account?',
                            style: TextStyle(color: Colors.black),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            SignUpScreen())));
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(color: Colors.black),
                              )),
                        ],
                      )
                    ],
                  ),
                )),
    );
  }
}
