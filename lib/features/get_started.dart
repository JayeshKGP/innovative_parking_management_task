import 'package:flutter/material.dart';
import 'package:innovative_parking_management_task/core/widgets/custom_button_white_text.dart';
import 'auth/auth.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      const Spacer(),
        Image.asset(
          'assets/images/vegenewlogo.png', // Replace with your image asset path
          width: 266,
          height: 94,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 70),
        Container(width: 350, child:
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Text(
                'Quick & Secure Park @ Malls',
                style: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 46,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff04031F),
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 10),
              Text(
                'We provide thousands safe places for your beautiful and luxury vehicles',
                style: TextStyle(fontSize: 16, color: Color(0xff878698), fontFamily: 'PlusJakartaSans', fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),),// Space between image and text
        SizedBox(height: 30,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(height: 50, width: double.maxFinite, child:
          customButtonWhiteText(label: 'Get Started', onPressed: (){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AuthScreen()),
            );
          }),)
        ),
        SizedBox(height: 20,)
    ],));
  }
}
