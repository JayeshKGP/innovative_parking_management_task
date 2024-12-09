import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:innovative_parking_management_task/core/constants/colors.dart';
import 'package:innovative_parking_management_task/core/widgets/custom_button_black_text.dart';
import '../home/home.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _phoneController = TextEditingController();
  String _verificationId = '';
  bool _hasSent = false;
  bool _isLoading = false;
  int number = 0;

  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  Future<void> sendOtp() async {
    setState(() {
      _isLoading = true;
      number = int.parse(_phoneController.text);
    });

    await _auth.verifyPhoneNumber(
      phoneNumber: '+91'+_phoneController.text.trim(),
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-verification success
        await _auth.signInWithCredential(credential);
        setState(() {
          _hasSent = false; // Reset state after successful login
          _isLoading = false;
        });
        // Handle success (navigate or show success message)
      },
      verificationFailed: (FirebaseAuthException e) {
        setState(() {
          _isLoading = false;
        });
        // Handle errors
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(e.message ?? 'Verification failed'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _verificationId = verificationId;
          _hasSent = true;
          _isLoading = false;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  Future<void> verifyOtp() async {
    // Combine the text from all OTP input fields
    final otp = _controllers.map((controller) => controller.text).join();

    if (otp.length < 6) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Please fill all OTP fields'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    try {
      setState(() {
        _isLoading = true;
      });

      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: otp,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      setState(() {
        _hasSent = false; // Reset state after successful verification
        _isLoading = false;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      });

      // Navigate or show success message
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      // Handle errors
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Invalid OTP or verification failed'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 250,
            ),
            Center(
              child: Image.asset(
                'assets/images/vegenewlogo.png', // Replace with your image asset path
                width: 142,
                height: 46,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
                width: 100, // Diameter of the circle
                height: 100, // Diameter of the circle
                decoration: BoxDecoration(
                  color: AppColors.primaryColor, // Background color
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/security-user.png', // Replace with your asset path
                      fit: BoxFit.cover,
                      width: 60,
                      height: 60,
                    ),
                  ),
                )),
            SizedBox(
              height: 10,
            ),
            Text(
              'Verify Account',
              style: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontWeight: FontWeight.w800,
                  fontSize: 30),
            ),
            _hasSent ? Padding(
              padding: EdgeInsets.all(35),
              child: Text(
                "We’ve sent unique OTP to  "+number.toString()+" to confirm your real identity now",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Color(0xff878698)),
              ),
            ) : Padding(
              padding: EdgeInsets.all(35),
              child: Text(
                'We will send OTP to your phone number to verify your account right now',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Color(0xff878698)),
              ),
            ),
            SizedBox(height: 20),
            !_hasSent ? Container(child: Column(children: [
              Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0), child: Row(children: [Text('Phone Number', textAlign: TextAlign.start, style: TextStyle(fontSize: 16, fontFamily: 'PlusJakartaSans'),),],)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 16,
                    ),
                    hintText: 'Your phone number',
                    hintStyle: const TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff4031F),
                    ),
                    filled: true,
                    fillColor: AppColors.primaryColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: const BorderSide(
                        color: Color(0xff3f46f9),
                        width: 2.0,
                      ),
                    ),
                  ),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  controller: _phoneController,
                  style: const TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff070625),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(height: 50, width: double.maxFinite, child:
                  customButtonBlackText(label: 'Get OTP Code', onPressed: sendOtp),)
              ),
            ],),) :
                Container(child: Column(children: [

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(6, (index) {
                        return Container(
                          width: 50,
                          height: 60,
                          decoration: BoxDecoration(
                            color: _areAllFilled() ? Colors.white : AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: _controllers[index],
                            focusNode: _focusNodes[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            style: const TextStyle(
                              fontFamily: 'PlusJakartaSans',
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                            decoration: const InputDecoration(
                              counterText: '', // Hides the counter
                              border: InputBorder.none,
                              hintText: '_',
                              hintStyle: const TextStyle(
                                fontFamily: 'PlusJakartaSans',
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Color(0xff04031F), // Light color for the placeholder
                              ),
                            ),
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                if (index < 5) {
                                  _focusNodes[index + 1].requestFocus();
                                } else {
                                  _focusNodes[index].unfocus(); // Removes focus when all filled
                                }
                              }
                              if (value.isEmpty && index > 0) {
                                _focusNodes[index - 1].requestFocus();
                              }
                              setState(() {});
                            },
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextButton(onPressed: (){
                    Fluttertoast.showToast(
                        msg: "Not implemented",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }, child: Text('Resend OTP code')),
                  SizedBox(height: 25,),
                  if(_areAllFilled())Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(height: 60, width: double.maxFinite, child:
                      customButtonBlackText(label: 'Verify Now', onPressed: verifyOtp),)
                  ),


                ],),),
            SizedBox(height: 20,)
          ],
        ),));
  }
  bool _areAllFilled() {
    return _controllers.every((controller) => controller.text.isNotEmpty);
  }
}
