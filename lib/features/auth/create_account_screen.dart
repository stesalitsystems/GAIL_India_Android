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
  String? _selectedGA;
  String? _selectedMS;
  String? _selectedDBS;
  bool _isLoading = false;

  List<String> kRoles = <String>[
    'Super Admin',
    'GA Incharge',
    'MS Admin',
    'DBS Admin',
  ];

  // --- Demo data: replace with your API data ---
  final List<String> gaOptions = const ['North GA', 'South GA', 'West GA'];

  final Map<String, List<String>> msByGa = const {
    'North GA': ['MS-N1', 'MS-N2', 'MS-N3'],
    'South GA': ['MS-S1', 'MS-S2'],
    'West GA': ['MS-W1'],
  };

  final Map<String, List<String>> dbsByMs = const {
    'MS-N1': ['DBS-N1-A', 'DBS-N1-B'],
    'MS-N2': ['DBS-N2-A'],
    'MS-N3': ['DBS-N3-A', 'DBS-N3-B', 'DBS-N3-C'],
    'MS-S1': ['DBS-S1-A'],
    'MS-S2': ['DBS-S2-A', 'DBS-S2-B'],
    'MS-W1': ['DBS-W1-A'],
  };
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

  Widget dropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required String leadingAssetPath,
    bool enabled = true,
    String? hintText,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: 4,
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
          Container(
            padding: EdgeInsets.symmetric(
              vertical: screenWidth * 0.004,
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
                SizedBox(
                  width: screenWidth * 0.05,
                  height: screenWidth * 0.05,
                  child: Image.asset(
                    leadingAssetPath,
                    fit: BoxFit.contain,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: enabled ? value : null,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey,
                      ),
                      hint: Text(
                        hintText ?? 'Select',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: const Color.fromARGB(255, 136, 134, 134),
                        fontSize: screenWidth * 0.04,
                      ),
                      items: (enabled ? items : <String>[])
                          .map(
                            (r) => DropdownMenuItem<String>(
                              value: r,
                              child: Text(r),
                            ),
                          )
                          .toList(),
                      onChanged: enabled ? onChanged : null,
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

  Widget roleDropdown({
    required String label,
    required String? value,
    required ValueChanged<String?> onChanged,
  }) {
    return dropdownField(
      label: label,
      value: value,
      items: kRoles,
      onChanged: onChanged,
      leadingAssetPath: 'assets/icons/User-Icon-face.png',
      hintText: 'Select role',
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
        vertical: 4,
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
              vertical: screenWidth * 0.0002,
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
                  width: screenWidth * 0.05,
                  height: screenWidth * 0.05,
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
                      width: screenWidth * 0.05,
                      height: screenWidth * 0.05,
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
            vertical: screenWidth * 0.03,
            horizontal: screenWidth * 0.05,
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
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
        // SizedBox(height: screenWidth * 0.02),
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

  bool get _showGA =>
      _selectedRole == 'GA Incharge' ||
      _selectedRole == 'MS Admin' ||
      _selectedRole == 'DBS Admin' ||
      _selectedRole == 'Driver';
  bool get _showMS =>
      _selectedRole == 'MS Admin' || _selectedRole == 'DBS Admin';
  bool get _showDBS => _selectedRole == 'DBS Admin';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    // Build cascaded lists based on selection
    final List<String> msOptions = (_selectedGA != null)
        ? (msByGa[_selectedGA] ?? const [])
        : const [];
    final List<String> dbsOptions = (_selectedMS != null)
        ? (dbsByMs[_selectedMS] ?? const [])
        : const [];

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
                  // Role picker
                  roleDropdown(
                    label: 'Role',
                    value: _selectedRole,
                    onChanged: (val) {
                      setState(() {
                        _selectedRole = val;
                        // Reset cascading selections when role changes
                        _selectedGA = null;
                        _selectedMS = null;
                        _selectedDBS = null;
                      });
                    },
                  ),

                  // Conditionally show GA/MS/DBS with proper enable/disable & cascading
                  if (_showGA)
                    dropdownField(
                      label: 'Geographical Area',
                      value: _selectedGA,
                      items: gaOptions,
                      onChanged: (val) {
                        setState(() {
                          _selectedGA = val;
                          // Reset dependents
                          _selectedMS = null;
                          _selectedDBS = null;
                        });
                      },
                      leadingAssetPath:
                          'assets/icons/User-Icon-face.png', // replace with your icon
                      hintText: 'Select geographical area',
                    ),

                  if (_showMS)
                    dropdownField(
                      label: 'Mother Station',
                      value: _selectedMS,
                      items: msOptions,
                      onChanged: (val) {
                        setState(() {
                          _selectedMS = val;
                          _selectedDBS = null;
                        });
                      },
                      enabled: _selectedGA != null,
                      leadingAssetPath:
                          'assets/icons/User-Icon-face.png', // replace with your icon
                      hintText: _selectedGA == null
                          ? 'Select GA first'
                          : 'Select mother station',
                    ),

                  if (_showDBS)
                    dropdownField(
                      label: 'Daughter Booster Station',
                      value: _selectedDBS,
                      items: dbsOptions,
                      onChanged: (val) => setState(() => _selectedDBS = val),
                      enabled: _selectedMS != null,
                      leadingAssetPath:
                          'assets/icons/User-Icon-face.png', // replace with your icon
                      hintText: _selectedMS == null
                          ? 'Select MS first'
                          : 'Select daughter booster station',
                    ),

                  SizedBox(height: height * 0.01),
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
          // Positioned(
          //   bottom: 16,
          //   left: 0,
          //   right: 0,
          //   child: _buildPrivacyPolicyWidget(),
          // ),
        ],
      ),
    );
  }
}
