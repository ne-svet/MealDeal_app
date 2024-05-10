import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meal_deal_app/entities/toast.dart';
import 'package:meal_deal_app/model/firebase_auth_services.dart';
import 'package:meal_deal_app/widgets/form_container_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FireBaseAuthService _auth = FireBaseAuthService();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

//Очищает контроллеры
  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                // Виджет с формой для аутентицикации
                FormContainerWidget(
                    controller: _nameController,
                    hintText: 'Name',
                    isPasswordField: false),
                const SizedBox(
                  height: 15,
                ),
                // Виджет с формой для аутентицикации
                FormContainerWidget(
                    controller: _surnameController,
                    hintText: 'Surname',
                    isPasswordField: false),
                const SizedBox(
                  height: 15,
                ),
                // Виджет с формой для аутентицикации
                FormContainerWidget(
                    controller: _emailController,
                    hintText: 'Email',
                    isPasswordField: false),
                const SizedBox(
                  height: 15,
                ),
                // Виджет с формой для аутентицикации
                FormContainerWidget(
                    controller: _passwordController,
                    hintText: 'Password',
                    isPasswordField: true),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: _signUp,
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/');
                      },
                      child: const Text("Login",
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold)),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

// отправляем данные для регистрации в FireBase
  void _signUp() async {
    // помещаем текст из контроллеров в отдельные переменные
    String name = _nameController.text;
    String surname = _surnameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    // проверяем user на Null
    if (user != null) {
      showToast(message: "User is successfully created");
      Navigator.pushReplacementNamed(context, "/menu");
    } else {
      showToast(message: "Happend some error", backgroundColor: Colors.red);
    }
  }
}
