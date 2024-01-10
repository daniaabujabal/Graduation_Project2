import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graduation_project2/widgets/image_constant.dart';
import 'package:graduation_project2/pages/navigation.dart';
import 'package:graduation_project2/Start_Pages/Sign_Up_Page.dart';
import 'package:http/http.dart' as http;


class SignInScreen extends StatelessWidget {
 
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();


  Future<bool> loginUser(BuildContext context) async {
        int? phoneNumber = int.tryParse(_phoneController.text);
    if (phoneNumber == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid phone number format.')),
      );
      return false;
    }

    try {
      final response = await http.post(
        Uri.parse('https://api/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
    'username': _phoneController.text,
    'password': _passwordController.text,
  }),
      );

      if (response.statusCode == 200) {
        // if the server returns a 200 OK response then parse the json.
        return true;
      } else {
        throw Exception('Failed to load data from the server');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign in: ${e.toString()}')),
      );
      return false;
    }
  }

  void forgotPassword(BuildContext context) async {
    int? phoneNumber = int.tryParse(_phoneController.text);
    if (phoneNumber == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid phone number format.')),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('https://api/forgotpassword'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'phone': phoneNumber}),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password reset link sent to your phone.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send password reset link.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred while sending password reset link.')),
      );
    }
  }

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
              colors: [Color(0xFF4BD8BB), Color(0xFF55AFBC), Color(0xFF5DAFCA)],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(ImageConstant.NoBackgroundLOGO, height: MediaQuery.of(context).size.height * 0.25),
              Text(
                "Welcome Back :)",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 30),
              _buildTextField(_phoneController, 'Phone number', false),
              _buildTextField(_passwordController, 'Password', true),
              TextButton(
                onPressed: ()  { forgotPassword(context);},
                child: Text('Forgot password?', style: TextStyle(color: Colors.white70)),                
              ),
              ElevatedButton(
                child: Text('Log in'),
                onPressed: () async {
                  //call api
                  if (_phoneController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
                    bool loginSuccessful = await loginUser(context);
                    if (loginSuccessful) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MainNavigationPage()),
                      );
                    } else {
                       ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Login failed. Please try again.')));
                      
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill in all fields.')),
                    );
                  }
                },
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                  );
                },
                child: Text('No account? Sign up', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildTextField(
    TextEditingController controller,
    String label,
    bool isPassword,
  ) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white70),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        suffixIcon: isPassword ? Icon(Icons.visibility_off, color: Colors.white70) : null,
      ),
      style: TextStyle(color: Colors.white),
    );
  }
}
