import 'package:fideos_mobile_app/controllers/auth.controller.dart';
import 'package:fideos_mobile_app/models/color.model.dart';
import 'package:fideos_mobile_app/presentations/auth/login.dart';
import 'package:fideos_mobile_app/utils/button.dart';
import 'package:fideos_mobile_app/utils/loader.dart';
import 'package:fideos_mobile_app/utils/seperator.dart';
import 'package:fideos_mobile_app/utils/spacer.dart';
import 'package:fideos_mobile_app/utils/text.form.field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Importing auth controller
  final _authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    _authController.regNameContoller.clear();
    _authController.regEmailController.clear();
    _authController.regPasswordController.clear();
    _authController.regConfirmPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
            key: _authController.registerFormKey,
            child: Column(
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
                      // Name
                      CommonTextFormField(
                              controller: _authController.regNameContoller,
                              validator: (name) {
                                if (name!.isEmpty) {
                                  return 'Name is required';
                                }
                                return null;
                              },
                              hint: 'Name')
                          .show(),

                      // Adding some space
                      Space.show(height: 10),

                      // Email text field
                      CommonTextFormField(
                              controller: _authController.regEmailController,
                              validator: (email) {
                                if (email!.isEmpty) {
                                  return 'Email is required';
                                } else if (!email.isEmail) {
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
                            controller: _authController.regPasswordController,
                            hint: "Password",
                            validator: (password) {
                              if (password!.isEmpty) {
                                return 'Password is required';
                              }
                              return null;
                            },
                            passwordObsecured:
                                _authController.regPasswordObsecured.value,
                            onTapSuffix: () =>
                                _authController.regPasswordObsecured.value =
                                    !_authController.regPasswordObsecured.value,
                            suffix: _authController.regPasswordObsecured.value
                                ? Feather.eye
                                : Feather.eye_off,
                          ).show()),

                      //Adding some space
                      Space.show(height: 10),

                      // Confirm Password text field
                      Obx(() => CommonTextFormField(
                            controller:
                                _authController.regConfirmPasswordController,
                            hint: "Confirm Password",
                            validator: (confirmPassword) {
                              if (confirmPassword!.isEmpty) {
                                return 'Confirm password is required';
                              } else if (_authController
                                      .regPasswordController.text !=
                                  confirmPassword) {
                                return 'Password not match';
                              }
                              return null;
                            },
                            passwordObsecured: _authController
                                .regConfirmPasswordObsecured.value,
                            onTapSuffix: () => _authController
                                    .regConfirmPasswordObsecured.value =
                                !_authController
                                    .regConfirmPasswordObsecured.value,
                            suffix: _authController
                                    .regConfirmPasswordObsecured.value
                                ? Feather.eye
                                : Feather.eye_off,
                          ).show()),

                      //Adding some space
                      Space.show(height: 10),

                      // Register button
                      Obx(() => _authController.regLoader.value
                          ? Loader().show()
                          : Button(
                                  onPressed: () {
                                    if (_authController
                                        .registerFormKey.currentState!
                                        .validate()) {
                                      _authController
                                          .registerFormKey.currentState!
                                          .save();
                                      _authController.register();
                                    }
                                  },
                                  text: 'Register')
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

                // Log In option
                logInOption,

                // Terms and policy
                termAndPolicy
              ],
            )),
      ),
    );
  }

  // Title
  Widget get title => const Text('India’s #1 Food Video and Delivery App',
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.black, fontSize: 25, fontWeight: FontWeight.w600));

// Log In option
  Widget get logInOption => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Already have an account?"),

          // Sign up button
          TextButton(
              onPressed: () {
                Get.to(() => const LoginScreen());
              },
              child:
                  Text('Log In Now', style: TextStyle(color: AppColor.primary)))
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
