import 'package:chat_app/screens/chats_screen.dart';
import 'package:chat_app/screens/singn_in_screen.dart';
import 'package:chat_app/screens/verification_screen.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/values/app_asstets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpProvider extends ChangeNotifier {
  bool _isLoading = false;

  get isLoading => _isLoading;

  void set_isloading(bool val) {
    _isLoading = val;
    notifyListeners();
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController? email_TextEditingController;
  TextEditingController? fullname_TextEditingController;
  TextEditingController? password_TextEditingController;
  TextEditingController? repeatPassword_TextEditingController;
  final _formKey = GlobalKey<FormState>();
  final AuthServices authServices = new AuthServices();
  bool _isLoaing = false;
  bool _obscureText2 = true;
  bool _obscureText = true;

  //final AuthServices authServices = Provider.of<AuthServices>(context);

  @override
  void initState() {
    email_TextEditingController = new TextEditingController();
    fullname_TextEditingController = new TextEditingController();
    password_TextEditingController = new TextEditingController();
    repeatPassword_TextEditingController = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    email_TextEditingController!.dispose();
    fullname_TextEditingController!.dispose();
    password_TextEditingController!.dispose();
    repeatPassword_TextEditingController!.dispose();
    super.dispose();
  }

  signUp() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoaing = true;
      });
      authServices.SignUp_WithEmailPasword(email_TextEditingController!.text,
              password_TextEditingController!.text)
          .then((val) {
        print(val);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VerificationScreen(
                    email: email_TextEditingController!.text)));
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
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
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
                                  controller: email_TextEditingController,
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
                                  controller: fullname_TextEditingController,
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
                                  controller: password_TextEditingController,
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
                                    return password_TextEditingController!
                                                .text ==
                                            val
                                        ? null
                                        : "The password not match";
                                  },
                                  controller:
                                      repeatPassword_TextEditingController,
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
