import 'package:flutter/material.dart';
import 'package:food_mobile_app/components/buttons.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../admin-pages/home/home.dart';
import '../../../components/custom_surfix_icon.dart';
import '../../../components/form_error.dart';
import '../../../consts/consts.dart';
import '../../forgot_password/forgot_password.dart';
import '../../home/home.dart';
import '../../../components/custom_textfield.dart';

class SignForm extends StatefulWidget {
  const SignForm({super.key});

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  bool? remember = false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            hint: emailHint,
            title: email,
            controller: emailController,
            isPass: false,
            suffixIcon: CustomSurffixIcon(svgIcon: "/icons/Mail.svg"),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),

          const SizedBox(height: 20),

          CustomTextField(
            hint: passwordHint,
            title: password,
            controller: passwordController,
            isPass: false,
            suffixIcon: CustomSurffixIcon(svgIcon: "/icons/Lock.svg"),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),

          const SizedBox(height: 20),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              const Text("Remember me"),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: const Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          const SizedBox(height: 16),
          buttons(
              title: "Login",
              color: Colors.red,
              textColor: Colors.white, // Text color set to white
              onPress: () {
                // Check if email and password match the admin credentials
                if (emailController.text == "admin@gmail.com" &&
                    passwordController.text == "testingdemo") {
                  Navigator.pushNamed(context, AdminHomePage.routeName);
                } else {
                  // Navigate to regular home page if credentials don't match
                  Navigator.pushNamed(context, HomePage.routeName);
                }
              }).box.width(context.screenWidth - 50).make(),

          SizedBox(height: 10), // Add more s
        ],
      ),
    );
  }
}
