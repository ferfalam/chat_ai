import 'package:flutter/material.dart';
import 'package:open_ai/Components/rotating_logo.dart';
import 'package:open_ai/theme/AppTheme.dart';

class MySplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      // Navigate to the main app using a named route
      Navigator.pushReplacementNamed(context, '/chat');
    });
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              color: AppTheme.define().primaryColor
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(tag: 'logo', child: MyRotatingImage()),
                Text(
                  "Open AI",
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      color: AppTheme.define().focusColor,
                      fontSize: 35,
                      fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}