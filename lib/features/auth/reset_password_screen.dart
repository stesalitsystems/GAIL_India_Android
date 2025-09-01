import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gail_india/utils/constants/colors.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool _isPasswordVisible = false;
  final TextEditingController _usernameController = TextEditingController();
  bool _isLoading = false; // To show loading indicator during login

  // Variables to store message and type
  String? _message;
  bool _isErrorMessage = false; // true if error, false if success
  bool _showMessage = false; // Control visibility of the message

  // Map of error messages based on status codes
  Map<int, String> errorMessages = {
    400: 'Bad Request: Invalid username.',
    401: 'Unauthorized: Please check your credentials.',
    403: 'Forbidden: You do not have permission to access this resource.',
    404: 'Not Found: The requested resource could not be found.',
    500: 'Internal Server Error: Please try again later.',
  };

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevents dismissal by tapping outside
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        );
      },
    );
  }

  void _hideLoadingDialog() {
    Navigator.of(context, rootNavigator: true).pop(); // Close the dialog
  }

  // Widget to build the input field
  Widget _entryField(String title) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: screenWidth * 0.035,

              color: Color.fromARGB(255, 136, 134, 134),
            ),
          ),
          SizedBox(height: screenWidth * 0.01),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: screenWidth * 0.008,
              horizontal: screenWidth * 0.04,
            ),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Color.fromARGB(255, 223, 227, 231),
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: screenWidth * 0.06,
                  height: screenWidth * 0.06,
                  child: Image.asset(
                    'assets/icons/email.png',
                    fit: BoxFit.contain,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                Expanded(
                  child: TextField(
                    controller: _usernameController,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Color.fromARGB(255, 136, 134, 134),
                      fontSize: screenWidth * 0.04,
                    ),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ), // default border
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 2,
                        ), // active border
                      ),
                      border: const OutlineInputBorder(), // fallback border
                      contentPadding: EdgeInsets.symmetric(
                        vertical: screenWidth * 0.008,
                        horizontal:
                            12, // added padding so text isn't glued to border
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget to build the Send OTP button
  Widget _submitButton() {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
        child: Container(
          width: screenWidth,
          padding: EdgeInsets.symmetric(
            vertical: screenWidth * 0.04,
            horizontal: screenWidth * 0.05,
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            // boxShadow: <BoxShadow>[
            //   BoxShadow(
            //     color: Colors.grey.shade200,
            //     offset: Offset(2, 4),
            //     blurRadius: 5,
            //     spreadRadius: 2,
            //   ),
            // ],
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [GColors.black, GColors.black],
            ),
          ),
          child: _isLoading
              ? SizedBox(
                  height: 28,
                  width: 28,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 2.0,
                  ),
                )
              : Text(
                  'Send OTP',
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    color: Colors.white,

                    fontWeight: FontWeight.normal,
                  ),
                ),
        ),
      ),
    );
  }

  // Widget to build the title
  Widget _title() {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row for the image and "Forgot Password" text
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image.asset('assets/Red-Vertical-Line.png', width: 40, height: 40),
            // SizedBox(width: 0),
            SizedBox(width: 0.02), // Adjust the width for desired spacing
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Forgot',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    TextSpan(
                      text: ' ', // Add a space here
                    ),
                    TextSpan(
                      text: 'Password!',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: screenWidth * 0.02),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            'Please enter your email to receive a verification code.',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  Widget _ResetPasswordSection() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Sign Up',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          SizedBox(width: 5),
          GestureDetector(
            onTap: () {
              // Handle "Click here to reset" tap
              print('Redirecting to password reset page...');
              // You can navigate to a password reset screen here or show a dialog.
            },
            child: Text(
              'Click here to reset',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,

                color: const Color.fromARGB(255, 25, 81, 156),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $uri';
    }
  }

  Widget _buildPrivacyPolicyWidget() {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(fontSize: 12, color: Colors.grey),
          children: [
            TextSpan(
              text: 'Terms & Conditions',
              style: TextStyle(
                // decoration: TextDecoration.underline,
                color: GColors.black,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  _launchURL('https://www.google.com/');
                },
            ),
            TextSpan(text: ' and '),
            TextSpan(
              text: 'Privacy Policy',
              style: TextStyle(
                // decoration: TextDecoration.underline,
                color: GColors.black,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  _launchURL('https://www.google.com/');
                },
            ),
            TextSpan(text: ' will be applied.'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: GColors.primary,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          // Background image
          // Positioned.fill(
          //   child: Image.asset('assets/BG.jpg', fit: BoxFit.cover),
          // ),
          Positioned.fill(
            child: Align(
              alignment: Alignment
                  .center, // place it where you want (center/topLeft/etc.)
              child: Opacity(
                opacity: 0.2, // 0.0 = fully transparent, 1.0 = fully visible
                child: Image.asset(
                  'assets/app_icons/GAIL.png',
                  width: 420, // make it small
                  height: 420, // control the size
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          // Main content
          Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.043),
            constraints: BoxConstraints(minHeight: height),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // SizedBox(height: height * 0.05),
                _title(),
                SizedBox(height: height * 0.02),
                _entryField("Email"),
                SizedBox(height: height * 0.03),
                _submitButton(),
              ],
            ),
          ),

          // Back Button
          Positioned(
            top: height * 0.07,
            left: width * 0.05,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context); // Navigate back
              },
              child: Icon(Icons.arrow_back, color: Colors.black, size: 24),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: _buildPrivacyPolicyWidget(),
          ),
        ],
      ),
    );
  }
}
