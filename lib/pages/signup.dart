import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_mobile_app/backend/controllers/auth_controller.dart';
import 'package:food_mobile_app/components/buttons.dart';
import 'package:food_mobile_app/components/custom_textfield.dart';
import 'package:food_mobile_app/consts/consts.dart';
import 'package:food_mobile_app/main.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:food_mobile_app/pages/login.dart';
import 'package:get/get.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isCheck = false;

  var controller = Get.put(AuthController());

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Text(
                "Join to the $appName",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    customeTextField(
                      hint: nameHint,
                      title: name,
                      controller: nameController,
                      isPass: false,
                    ),
                    SizedBox(height: 20),
                    customeTextField(
                      hint: emailHint,
                      title: email,
                      controller: emailController,
                      isPass: false,
                    ),
                    SizedBox(height: 10),
                    customeTextField(
                      hint: passwordHint,
                      title: password,
                      controller: passwordController,
                      isPass: true,
                    ),
                    SizedBox(height: 10),
                    customeTextField(
                      hint: passwordConfirm,
                      title: password,
                      controller: passwordRetypeController,
                      isPass: true,
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.red,
                          value: isCheck,
                          onChanged: (newValue) {
                            setState(() {
                              isCheck = newValue!;
                            });
                          },
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "I agree to the ",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                TextSpan(
                                  text: "Terms and Conditions",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    buttons(
                      color: isCheck ? Colors.red : Colors.grey,
                      title: "Sign Up",
                      textColor: Colors.white,
                      onPress: () async {
                        print("Name: ${nameController.text}");
                        print("Email: ${emailController.text}");
                        print("Password: ${passwordController.text}");

                        if (nameController.text.isEmpty ||
                            emailController.text.isEmpty ||
                            passwordController.text.isEmpty ||
                            passwordRetypeController.text.isEmpty) {
                          VxToast.show(context, msg: "Please fill in all fields.");
                          return;
                        }
                        if (passwordController.text != passwordRetypeController.text) {
                          VxToast.show(context, msg: "Passwords do not match.");
                          return;
                        }
                        if (!isCheck) {
                          VxToast.show(context, msg: "Please agree to the Terms and Conditions.");
                          return;
                        }
                        try {
                          await controller.signupMethod(
                            context: context,
                            email: emailController.text,
                            password: passwordController.text,
                            name: nameController.text, // Pass the name field here
                          ).then((value) {
                            VxToast.show(context, msg: "Logged in successfully");
                            // Get.offAll(() => HomePage());
                          });
                        } catch (e) {
                          auth.signOut();
                          print("Error: $e");
                          // VxToast.show(context, msg: e.toString());
                        }
                      },
                    ).box.width(context.screenWidth - 50).make(),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: "Having an Account ?".text.make(),
                          ),
                          buttons(
                            title: "Login",
                            color: Colors.transparent,
                            textColor: Colors.red,
                            onPress: () {
                              Get.to(() => const LoginPage());
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}