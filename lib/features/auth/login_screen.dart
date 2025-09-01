import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gail_india/auth/state/auth_controller.dart';
import 'package:gail_india/utils/constants/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  State<LoginPage> createState() => _LoginPage1State();
}

class _LoginPage1State extends State<LoginPage> {
  bool _isPasswordVisible = false;
  final email = TextEditingController();
  final password = TextEditingController();
  bool _isLoading = false;
  String? _message;
  bool _isErrorMessage = false; // true if error, false if success
  bool _showMessage = false; // Control visibility of the message

  Map<int, String> errorMessages = {
    400:
        'Bad Request: The server could not understand the request due to invalid syntax.',
    401: 'Wrong credentials: Please check your email and password.',
    403: 'Forbidden: You do not have permission to access this resource.',
    404: 'Not Found: The requested resource could not be found.',
    500:
        'Internal Server Error: The server encountered an unexpected condition.',
  };

  @override
  void initState() {
    super.initState();
  }

  Future<void> _login() async {
    setState(() => _isLoading = true);
    try {
      await context.read<AuthController>().loginWithCredentials(
        email.text,
        password.text,
      );
      if (!mounted) return;
      context.go('/dash');
    } catch (_) {
      _message = 'Login failed';
      _isErrorMessage = true;
      _showMessage = true;
      setState(() {});
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Widget _bottomMessage() {
    if (!_showMessage || _message == null) return const SizedBox.shrink();
    return Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: _isErrorMessage
              ? const Color.fromARGB(255, 230, 47, 47)
              : Colors.green,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            _message!,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _entryField(String title, {bool isPassword = false}) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
      ), // Adjust the padding as needed
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: screenWidth * 0.035,
              color: GColors.black,
            ),
          ),
          SizedBox(height: screenWidth * 0.01),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: screenWidth * 0.008,
              horizontal: screenWidth * 0.04,
            ),
            margin: EdgeInsets.symmetric(vertical: screenWidth * 0.01),
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
                    isPassword
                        ? 'assets/icons/Lock-Icon-face.png'
                        : 'assets/icons/email.png',
                    fit: BoxFit.contain,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                Expanded(
                  child: TextField(
                    controller: isPassword ? password : email,
                    obscureText: isPassword && !_isPasswordVisible,

                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: const Color.fromARGB(255, 136, 134, 134),
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
                if (isPassword)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    child: Image.asset(
                      _isPasswordVisible
                          ? 'assets/icons/Eye-Open-Icon.png'
                          : 'assets/icons/Eye-Closed-Icon.png',
                      width: screenWidth * 0.065,
                      height: screenWidth * 0.065,
                      color: Colors.grey,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _submitButton() {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: _isLoading ? null : _login, // Disable button if loading
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
                  'Login',
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

  Widget _title() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row for the image and "Welcome Back" text
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(
            //     left: 15.0,
            //   ), // Adjust this value as needed
            //   child: Image.asset(
            //     'assets/vehicle/cng_tanker.png',
            //     width: 200, // Adjust width as needed
            //     height: 30, // Adjust height as needed
            //   ),
            // ),
            SizedBox(width: 0.02), // Adjust the width for desired spacing
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Welcome',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),

                    TextSpan(
                      text: ' ', // Add a space here
                    ),
                    TextSpan(
                      text: 'Back!',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: screenWidth * 0.02),

        // Adjusted left movement for "Please login to continue" text
        Padding(
          padding: const EdgeInsets.only(
            left: 15.0,
          ), // Adjust left padding as needed
          child: Text(
            'Please login to continue',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ],
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Email"),
        SizedBox(height: 10),
        _entryField("Password", isPassword: true),
        SizedBox(height: 10),
        _forgotPasswordSection(),
      ],
    );
  }

  Widget _forgotPasswordSection() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 18.0,
      ), // Adjust as needed to align with your password field
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              context.push('/reset_password');
            },
            child: Text(
              'Forgot Password?',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,

                color: Color(0xFF000080),
                // decoration: TextDecoration.underline, // Uncomment if you want underline
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _SignupSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0), // optional vertical spacing
      child: Center(
        child: GestureDetector(
          onTap: () {
            context.push('/create_account');
          },
          child: Text(
            'New User? Register Now',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,

              color: Color(0xFF000080),
              // decoration: TextDecoration.underline,
            ),
          ),
        ),
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
          style: TextStyle(fontSize: 12, color: GColors.black),
          children: [
            TextSpan(
              text: 'Terms & Conditions',
              style: TextStyle(
                // decoration: TextDecoration.underline,
                color: GColors.black,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  _launchURL('https://google.com');
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
                  _launchURL('https://google.com');
                },
            ),
            TextSpan(text: ' will be applied.'),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose controllers when the widget is disposed
    email.dispose();
    password.dispose();
    super.dispose();
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
          // Background image that fills the screen.
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

          Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.043),
            constraints: BoxConstraints(minHeight: height),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // SizedBox(height: height * 0.1),
                _title(),
                SizedBox(height: height * .02),
                _emailPasswordWidget(),
                SizedBox(height: height * .03),
                _submitButton(),
                SizedBox(height: height * .01),
                _SignupSection(),
              ],
            ),
          ),
          // Bottom message widget.
          _bottomMessage(),
          // Privacy policy widget positioned at the bottom.
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
