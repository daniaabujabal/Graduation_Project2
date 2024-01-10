import 'package:flutter/material.dart';
import 'package:graduation_project2/widgets/image_constant.dart';
import 'SignUpForm.dart';
import 'package:graduation_project2/pages/navigation.dart';
import 'package:graduation_project2/Start_Pages/Sign_in.dart';


class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF4BD8BB),
                Color(0xFF55AFBC),
                Color(0xFF5DAFCA),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround, 
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Image.asset(ImageConstant.NoBackgroundLOGO, height: MediaQuery.of(context).size.height * 0.25),
              Text(
                "Welcome",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SignUpForm(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05), 
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MainNavigationPage()),
                  );
                },
                child: Text('Skip Account', style: TextStyle(color: Colors.white)),
              ),
              TextButton(
                onPressed: () {
Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
    );                },
                child: Text(
                  'Already Registered? Log In',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
