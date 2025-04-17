import 'dart:developer';

import 'package:fideos_mobile_app/controllers/auth.controller.dart';
import 'package:fideos_mobile_app/models/color.model.dart';
import 'package:fideos_mobile_app/presentations/auth/register.dart';
import 'package:fideos_mobile_app/utils/button.dart';
import 'package:fideos_mobile_app/utils/loader.dart';
import 'package:fideos_mobile_app/utils/seperator.dart';
import 'package:fideos_mobile_app/utils/spacer.dart';
import 'package:fideos_mobile_app/utils/text.form.field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Importing auth controller
  final _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _authController.loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Auth Screen Image
              const Image(image: AssetImage('assets/auth_screen.png')),

              // Adding some space
              Space.show(height: 10),

              // Title
              title,

              // Adding some space
              Space.show(height: 20),

              // Title Seperator
              Seperator(text: 'Log In or Sign Up').show(),

              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    // Email text field
                    CommonTextFormField(
                            controller: _authController.loginEmailController,
                            validator: (email) {
                              if(email!.isEmpty){
                                return 'Email is required';
                              }
                              else if(!email.isEmail){
                                return 'Enter a valid email';
                              }
                              return null;
                            },
                            hint: 'Email')
                        .show(),

                    // Adding some space
                    Space.show(height: 10),

                    // Password text field
                    Obx(() => CommonTextFormField(
                          controller: _authController.loginPasswordcontroller,
                          hint: "Password",
                          validator: (password) {
                            if(password!.isEmpty){
                              return 'Password is required';
                            }
                            return null;
                          },
                          passwordObsecured:
                              _authController.passwordObsecured.value,
                          onTapSuffix: () => _authController.passwordObsecured
                              .value = !_authController.passwordObsecured.value,
                          suffix: _authController.passwordObsecured.value
                              ? Feather.eye
                              : Feather.eye_off,
                        ).show()),

                    // Adding some space
                    Space.show(height: 10),

                    // Forgot password text
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text('Forgot Password',
                          style:
                              TextStyle(color: AppColor.primary, fontSize: 12)),
                    ),

                    //Adding some space
                    Space.show(height: 10),
                    // Login button
                    Obx(() => _authController.loginLoader.value
                        ? Loader().show()
                        : Button(
                                onPressed: () {
                                  if (_authController.loginFormKey.currentState!
                                      .validate()) {
                                    _authController.loginFormKey.currentState!
                                        .save();
                                    _authController.login();
                                  }
                                },
                                text: 'Continue')
                            .show())
                  ],
                ),
              ),

              // Seperator
              Seperator(text: 'or').show(),

              // Adding some space
              Space.show(height: 10),

              const Image(
                  image: AssetImage("assets/google_icon.png"), height: 25),

              // Sign up option
              signUpOption,

              // Terms and policy
              termAndPolicy
            ],
          ),
        ),
      ),
    );
  }

  // Title
  Widget get title => const Text('India’s #1 Food Video and Delivery App',
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.black, fontSize: 25, fontWeight: FontWeight.w600));

  // Sign up option
  Widget get signUpOption => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Don't have an account?"),

          // Sign up button
          TextButton(
              onPressed: () {
                Get.to(() => const RegisterScreen());
              },
              child: Text('Sign Up Now',
                  style: TextStyle(color: AppColor.primary)))
        ],
      );

  // Term and policy
  Widget get termAndPolicy => Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          Text(
            'By continuing, you agree to our',
            style: TextStyle(
                color: AppColor.black.withOpacity(0.5),
                height: 2,
                fontSize: 13),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text('Terms of Service',
                    style: TextStyle(color: AppColor.primary, fontSize: 12)),
              ),
              Expanded(
                child: Text('Terms of Service',
                    style: TextStyle(color: AppColor.primary, fontSize: 12)),
              ),
              Expanded(
                child: Text('Terms of Service',
                    style: TextStyle(color: AppColor.primary, fontSize: 12)),
              )
            ],
          )
        ]),
      );
}
