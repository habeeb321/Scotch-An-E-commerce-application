import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/auth/loginscreen/view/login_screen.dart';
import 'package:scotch/view/auth/signupscreen/controller/signup_controller.dart';
import 'package:scotch/view/auth/widgets/auth_elev_button.dart';
import 'package:scotch/view/auth/widgets/auth_textfields.dart';
import 'package:scotch/view/auth/widgets/wave.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  SignUpController signUpController = Get.put(SignUpController());
  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Opacity(
                        opacity: 0.5,
                        child: ClipPath(
                          clipper: WaveClipper(),
                          child: Container(
                            color: themeColor,
                            height: size.height * 0.40,
                          ),
                        ),
                      ),
                      ClipPath(
                        clipper: WaveClipper(),
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 50),
                          color: themeColor,
                          height: size.height * 0.36,
                          alignment: Alignment.center,
                        ),
                      ),
                      Column(
                        children: const [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(logo),
                          ),
                          kHeight10,
                          Text(
                            'Sign Up',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: kWhitecolor),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Form(
                  key: formGlobalKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: GetBuilder<SignUpController>(builder: (controller) {
                    return Column(
                      children: [
                        AuthTextField(
                            controller: signUpController.fullNameController,
                            validator: (value) =>
                                signUpController.nameValidation(value),
                            label: 'Enter Your FullName'),
                        kHeight10,
                        AuthTextField(
                            controller: signUpController.emailController,
                            validator: (value) =>
                                signUpController.emailValdation(value),
                            label: 'Enter Your E-mail'),
                        kHeight10,
                        AuthTextField(
                            validator: (value) =>
                                signUpController.mobileValdation(value),
                            controller: signUpController.mobileController,
                            inputType: TextInputType.number,
                            label: 'Enter Your Mobile Number'),
                        kHeight10,
                        AuthTextField(
                            controller: signUpController.passController,
                            validator: (value) =>
                                signUpController.passwordValdation(value),
                            obscureText: signUpController.obscureText,
                            suffix: IconButton(
                                onPressed: () => signUpController.visibility(),
                                icon: signUpController.icon),
                            inputType: TextInputType.visiblePassword,
                            label: 'Enter Your Password'),
                        kHeight10,
                        AuthTextField(
                            controller: signUpController.confirmPassController,
                            validator: (value) =>
                                signUpController.passwordValdation(value),
                            obscureText: signUpController.obscureText,
                            suffix: IconButton(
                                onPressed: () => signUpController.visibility(),
                                icon: signUpController.icon),
                            inputType: TextInputType.visiblePassword,
                            label: 'Confirm Your Password'),
                      ],
                    );
                  }),
                ),
                kHeight20,
                GetBuilder<SignUpController>(builder: (controller) {
                  return SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: AuthElevatedButton(
                      label: 'Sign Up',
                      onPressed: () {
                        if (formGlobalKey.currentState!.validate()) {
                          formGlobalKey.currentState!.save();
                          signUpController.signupUser(context);
                        }
                      },
                    ),
                  );
                }),
                kHeight10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        Get.to(LoginScreen());
                      },
                      child: const Text('Login'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}