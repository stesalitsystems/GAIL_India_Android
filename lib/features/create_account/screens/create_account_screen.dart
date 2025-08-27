import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gail_india/utils/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class CreateAccount extends StatefulWidget {
  CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  String? _selectedRole;

  bool _isLoading = false;

  List<String> kRoles = <String>[
    'Super Admin',
    'GA Incharge',
    'MS Admin',
    'DBS Admin',
    'Driver',
  ];

  // Map of error messages based on status codes
  Map<int, String> errorMessages = {
    400: 'Bad Request: Invalid OTP or password format.',
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

  Widget roleDropdown({
    required String label, // e.g., 'Role'
    required String? value, // current selected value
    required ValueChanged<String?> onChanged,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: screenWidth * 0.035,

              color: const Color.fromARGB(255, 136, 134, 134),
            ),
          ),
          SizedBox(height: screenWidth * 0.01),

          // Field container (same as your _entryField)
          Container(
            padding: EdgeInsets.symmetric(
              vertical: screenWidth * 0.008,
              horizontal: screenWidth * 0.04,
            ),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: const Color.fromARGB(255, 223, 227, 231),
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                // Leading icon (same dimension as _entryField)
                SizedBox(
                  width: screenWidth * 0.06,
                  height: screenWidth * 0.06,
                  child: Image.asset(
                    'assets/icons/User-Icon-face.png',
                    fit: BoxFit.contain,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),

                // Dropdown (expanded to fill remaining space)
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: value,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey,
                      ),
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: const Color.fromARGB(255, 136, 134, 134),
                        fontSize: screenWidth * 0.04,
                      ),
                      hint: const Text(
                        'Select role',
                        style: TextStyle(color: Colors.grey),
                      ),
                      items: kRoles
                          .map(
                            (r) => DropdownMenuItem<String>(
                              value: r,
                              child: Text(r),
                            ),
                          )
                          .toList(),
                      onChanged: onChanged,
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

  Widget _entryField({
    required String label,
    required TextEditingController controller,
    required String hint,
    required String leadingAssetPath,
    TextInputType keyboardType = TextInputType.text,
    bool obscure = false,
    bool showEye = false,
  }) {
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
            label,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: screenWidth * 0.035,

              color: const Color.fromARGB(255, 136, 134, 134),
            ),
          ),
          SizedBox(height: screenWidth * 0.01),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: screenWidth * 0.008,
              horizontal: screenWidth * 0.04,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: const Color.fromARGB(255, 223, 227, 231),
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: screenWidth * 0.06,
                  height: screenWidth * 0.06,
                  child: Image.asset(
                    leadingAssetPath,
                    fit: BoxFit.contain,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                Expanded(
                  child: TextField(
                    controller: controller,
                    keyboardType: keyboardType,
                    obscureText: obscure && !_isPasswordVisible,
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
                if (showEye)
                  GestureDetector(
                    onTap: () => setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    }),
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

  // Widget to build the Reset Password button
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
                  'Create Account',
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
        // Row for the image and "Create New Password" text
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image.asset('assets/Red-Vertical-Line.png', width: 40, height: 40),
            SizedBox(width: 0.02), // Adjust the width for desired spacing
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Create',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    TextSpan(
                      text: ' ', // Add a space here
                    ),
                    TextSpan(
                      text: 'New Account!',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: screenWidth * 0.02),
        // Padding(
        //   padding: const EdgeInsets.only(left: 20.0),
        //   child: Text(
        //     'Please enter the 6-digit code sent to your registered email and create your new password.',
        //     style: TextStyle(
        //       fontSize: 15,
        //       fontWeight: FontWeight.normal,
        //       color: Color.fromARGB(255, 136, 134, 134),
        //
        //     ),
        //   ),
        // ),
      ],
    );
  }

  // Widget _ResetPasswordSection() {
  //   return Container(
  //     padding: EdgeInsets.symmetric(vertical: 10),
  //     alignment: Alignment.center,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Text(
  //           'Reset Password ?',
  //           style: TextStyle(
  //             fontSize: 14,
  //             fontWeight: FontWeight.w500,
  //
  //           ),
  //         ),
  //         SizedBox(width: 5),
  //         GestureDetector(
  //           onTap: () {
  //             // Handle "Click here to reset" tap
  //             print('Redirecting to password reset page...');
  //             // You can navigate to a password reset screen here or show a dialog.
  //           },
  //           child: Text(
  //             'Click here to reset',
  //             style: TextStyle(
  //               fontSize: 14,
  //               fontWeight: FontWeight.w500,
  //
  //               color: const Color.fromARGB(255, 25, 81, 156),
  //             ),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

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
                  _launchURL('https://bbxvisible.com/terms-of-service/');
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
                  _launchURL('https://bbxvisible.com/privacy-policy/');
                },
            ),
            TextSpan(text: ' will be applied.'),
          ],
        ),
      ),
    );
  }

  // Widget _buildPrivacyPolicyWidget() {
  //   return Center(
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         // 1. Image in the center
  //         Image.asset(
  //           'assets/Black-Box-Black-Logo.png',
  //           width: 150,
  //           height: 50,
  //         ),

  //         // const SizedBox(height: 12),

  //         // 2. RichText inside a Row, centered
  //         Row(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             RichText(
  //               textAlign: TextAlign.center,
  //               text: TextSpan(
  //                 style: const TextStyle(
  //                   fontSize: 12,
  //                   color: Colors.grey,
  //                 ),
  //                 children: [
  //                   TextSpan(
  //                     text: 'Terms & Conditions',
  //                     style: TextStyle(
  //                       color: AppThemeData.containerColor,
  //                     ),
  //                     recognizer: TapGestureRecognizer()
  //                       ..onTap = () {
  //                         _launchURL(
  //                             'https://bbxvisible.com/terms-of-service/');
  //                       },
  //                   ),
  //                   const TextSpan(text: ' and '),
  //                   TextSpan(
  //                     text: 'Privacy Policy',
  //                     style: TextStyle(
  //                       color: AppThemeData.containerColor,
  //                     ),
  //                     recognizer: TapGestureRecognizer()
  //                       ..onTap = () {
  //                         _launchURL('https://bbxvisible.com/privacy-policy/');
  //                       },
  //                   ),
  //                   const TextSpan(text: ' will be applied.'),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
          // Background image
          // Positioned.fill(
          //   child: Image.asset('assets/BG.jpg', fit: BoxFit.cover),
          // ),

          // Main content
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: width * 0.043),
              constraints: BoxConstraints(minHeight: height),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * 0.1),
                  _title(),
                  SizedBox(height: height * 0.01),
                  _entryField(
                    label: 'Full Name',
                    controller: _fullNameController,
                    hint: 'Enter your full name',
                    leadingAssetPath: 'assets/icons/User-Icon-face.png',
                    keyboardType: TextInputType.name,
                  ),
                  _entryField(
                    label: 'Email',
                    controller: _emailController,
                    hint: 'Enter your email',
                    leadingAssetPath: 'assets/icons/email.png',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  _entryField(
                    label: 'Password',
                    controller: _passwordController,
                    hint: 'Enter your password',
                    leadingAssetPath: 'assets/icons/Lock-Icon-face.png',
                    keyboardType: TextInputType.text,
                    obscure: true,
                    showEye: true, // shows the eye toggle
                  ),
                  roleDropdown(
                    label: 'Role',
                    value: _selectedRole,
                    onChanged: (val) => setState(() => _selectedRole = val),
                  ),
                  SizedBox(height: height * 0.03),
                  _submitButton(),
                ],
              ),
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
            bottom: 16,
            left: 0,
            right: 0,
            child: _buildPrivacyPolicyWidget(),
          ),
        ],
      ),
    );
  }
}
