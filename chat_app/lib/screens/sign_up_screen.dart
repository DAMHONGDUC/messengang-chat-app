import 'package:chat_app/models/userChat.dart';
import 'package:chat_app/screens/main_screen.dart';
import 'package:chat_app/screens/sign_in_screen.dart';
import 'package:chat_app/screens/verification_screen.dart';
import 'package:chat_app/services/authService.dart';
import 'package:chat_app/values/app_asstets.dart';
import 'package:chat_app/services/databaseMethod.dart';
import 'package:chat_app/widget/loadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController? emailController;
  TextEditingController? fullnameController;
  TextEditingController? passwordController;
  TextEditingController? repeatPasswordController;
  final _formKey = GlobalKey<FormState>();
  final AuthServices authServices = new AuthServices();
  final DatabaseMethods databaseMethods = new DatabaseMethods();

  bool _isLoaing = false;
  bool _obscureText2 = true;
  bool _obscureText = true;

  @override
  void initState() {
    emailController = new TextEditingController();
    fullnameController = new TextEditingController();
    passwordController = new TextEditingController();
    repeatPasswordController = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController!.dispose();
    fullnameController!.dispose();
    passwordController!.dispose();
    repeatPasswordController!.dispose();
    super.dispose();
  }

  signUp() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoaing = true;
      });

      authServices.SignUp_WithEmailPasword(
              emailController!.text, passwordController!.text)
          .then((val) {
        UserChat userChat = new UserChat(
            email: emailController!.text,
            name: fullnameController!.text,
            id: "1",
            photo: "url");
        databaseMethods.UploadUser(userChat.toJSON());

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    VerificationScreen(email: emailController!.text)));
      });
    }
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggle2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthServices>(
          create: (_) => AuthServices(),
        )
      ],
      child: Scaffold(
        body: SafeArea(
            child: _isLoaing
                ? LoadingWidget()
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Image.asset(
                          Assets.Logo,
                          height: 100,
                          width: 100,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          "Sign Up",
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
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
                                  validator: (val) {
                                    return val.toString().isEmpty ||
                                            val.toString().length < 2
                                        ? "Please enter a valid fullname"
                                        : null;
                                  },
                                  controller: fullnameController,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.all(15.0),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    labelText: 'Fullname',
                                    labelStyle: TextStyle(fontSize: 14),
                                  ),
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
                                TextFormField(
                                  obscureText: _obscureText2,
                                  validator: (val) {
                                    return passwordController!.text == val
                                        ? null
                                        : "The password not match";
                                  },
                                  controller: repeatPasswordController,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(15.0),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      labelText: 'Repeat password',
                                      labelStyle: TextStyle(fontSize: 14),
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            _toggle2();
                                          },
                                          icon: Icon(
                                            Icons.visibility,
                                            size: 20,
                                          ))),
                                ),
                                SizedBox(height: 15),
                                ElevatedButton(
                                    onPressed: () {
                                      signUp();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        minimumSize: Size.fromHeight(40),
                                        shape: new RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)))),
                                    child: Text('Sign up')),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account?',
                              style: TextStyle(color: Colors.black),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Sign in',
                                  style: TextStyle(color: Colors.black),
                                )),
                          ],
                        )
                      ],
                    ),
                  )),
      ),
    );
  }
}
