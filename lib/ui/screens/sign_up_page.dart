import 'package:flutter/material.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/ui/widgets/body_background.dart';
import 'package:task_manager/ui/widgets/show_snackbar.dart';
import 'package:task_manager/ui/widgets/verticle.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _secondNameTEController = TextEditingController();
  final TextEditingController _numberTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool signUpInProgress = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BodyBackGround(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Text("Join With Us",
                        style: Theme.of(context).textTheme.titleLarge),
                    verticle(20.0),
                    TextFormField(
                      controller: _emailTEController,
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter valid Email";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Email",
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    verticle(16.0),
                    TextFormField(
                      controller: _firstNameTEController,
                      validator: (String? value) {
                       if(value!.trim().isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)){
                        return "Enter correct name";
                       } else{

                       } return null;
                      
                      },
                      decoration: const InputDecoration(
                        hintText: "First Name",
                      ),
                      keyboardType: TextInputType.name,
                    ),
                    verticle(16.0),
                    TextFormField(
                      controller: _secondNameTEController,
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter your last name ";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Last Name",
                      ),
                      keyboardType: TextInputType.name,
                    ),
                    verticle(16.0),
                    TextFormField(
                      controller: _numberTEController,
                      validator: (String? value) {
                      
                        if (value!.length == 11) {
                        } else {
                          return "Number must be 11 digits: $value";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Mobile",
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    verticle(20.0),
                    TextFormField(
                      controller: _passwordTEController,
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter valid password";
                        }
                        if (value!.length < 6) {
                          return "Enter password more then 6 digits";
                        }

                        return null;
                      },
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Password",
                      ),
                    ),
                    verticle(16.0),
                    ElevatedButton(
                      onPressed: (){
                        _signup();
                      },
                      child: const Icon(Icons.arrow_circle_right),
                    ),
                    verticle(48),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Sign In",
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signup() async {
    signUpInProgress = true;
    if (mounted) {
      setState(() {});
    }
    if (_formKey.currentState!.validate()) {
      final NetworkResponse networkResponse = await NetworkCaller().postRequest(
        Urls.registration,
        body: {
          "email": _emailTEController.text.trim(),
          "firstName": _firstNameTEController.text.trim(),
          "lastName": _secondNameTEController.text.trim(),
          "mobile": _numberTEController.text.trim(),
          "password": _passwordTEController.text,
        },
      );
      signUpInProgress = false;
      if (mounted) {
        setState(() {});
      }
      if (networkResponse.isSuccess) {
        textClear();
        if (mounted) {
          setState(() {});
          showMessage(context, "Account has been created! Please login.");
        }
      } else {
        if (mounted) {
          showMessage(context, "Account creation failed! Try again", true);
        }
      }
    }
  }

  void textClear() {
    _emailTEController.clear();
    _firstNameTEController.clear();
    _secondNameTEController.clear();
    _numberTEController.clear();
    _passwordTEController.clear();
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _secondNameTEController.dispose();
    _numberTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}