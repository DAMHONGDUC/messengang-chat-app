import 'package:chat_app/screens/login.dart';
import 'package:chat_app/values/app_asstets.dart';
import 'package:chat_app/values/app_styles.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Spacer(
            flex: 2,
          ),
          Image.asset(Assets.Welcome),
          Spacer(
            flex: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Welcome to Messengang the best chat app in the world",
              maxLines: 2,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Spacer(
            flex: 1,
          ),
          Text(
            "Connect with the people you love",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .color!
                  .withOpacity(0.64),
            ),
          ),
          Spacer(
            flex: 4,
          ),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Skip',
                    style: TextStyle(
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(0.6),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .color!
                        .withOpacity(0.6),
                    size: 16,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                ],
              ))
        ],
      )),
    );
  }
}
