// File: lib/screens/login_screen.dart
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:gail_india/common/styles/text_form_field.dart';
import 'package:gail_india/features/Auth/login_screen/controllers/login_controller.dart';
import 'package:gail_india/features/Auth/login_screen/screens/widgets/drop_down2.dart';
import 'package:gail_india/features/Auth/login_screen/screens/widgets/login_buttton.dart';
import 'package:gail_india/features/role_driver/driver_dashboard/controllers/driver_controller.dart';
import 'package:gail_india/utils/constants/colors.dart';
import 'package:gail_india/utils/constants/sizes.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final loginController = LoginController();
  final driverController = DriverController();
  bool _obscureText = true;

  @override
  void dispose() {
    loginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: Gsizes.appBarHeight,
                  ), // Adjusted for AppBar height
                  Center(
                    child: Image.asset('assets/logos/GAIL.png', width: 120),
                  ),
                  const SizedBox(height: Gsizes.defaultSpaceSmall),
                  const Text(
                    'Gas Authority of India Ltd.',
                    style: TextStyle(
                      fontSize: Gsizes.fontLg,
                      fontWeight: FontWeight.bold,
                      color: GColors.primaryText,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(24.0),
                    decoration: BoxDecoration(
                      color: GColors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // const SizedBox(height: Gsizes.defaultSpace),
                        Center(
                          child: Column(
                            children: [
                              Text(
                                "Welcome Back!",
                                style: TextStyle(
                                  fontSize: Gsizes.fontLg,
                                  fontWeight: FontWeight.bold,
                                  color: GColors.primaryText,
                                ),
                              ),
                              Text(
                                "Signin to your account",
                                style: TextStyle(
                                  fontSize: Gsizes.fontSm,
                                  fontWeight: FontWeight.normal,
                                  color: GColors.primaryText,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: Gsizes.defaultSpace),
                        Text(
                          "Email Address",
                          style: TextStyle(
                            fontSize: Gsizes.fontSm,
                            color: GColors.primaryText,
                          ),
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                          controller: loginController.emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                        ),
                        const SizedBox(height: Gsizes.defaultSpace),
                        Text(
                          "Password",
                          style: TextStyle(
                            fontSize: Gsizes.fontSm,
                            color: GColors.primaryText,
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          controller: loginController.passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText =
                                      !_obscureText; // Toggle visibility
                                });
                              },
                            ),
                          ),
                          obscureText: _obscureText, // Use the updated value
                        ),
                        const SizedBox(height: Gsizes.defaultSpaceSmall),
                        Container(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Color.fromARGB(255, 211, 65, 65),
                                fontSize: Gsizes.fontSm,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: Gsizes.defaultSpaceSmall),
                        LoginButton(
                          loginController: loginController,
                          controller: driverController,
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () {},
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'New user? ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: Gsizes.fontSm,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Sign Up',
                                  style: TextStyle(
                                    color: GColors.yellowText,
                                    fontSize: Gsizes.fontSm,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
