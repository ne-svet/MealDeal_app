import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meal_deal_app/entities/toast.dart';
import 'package:meal_deal_app/model/firebase_auth_services.dart';
import 'package:meal_deal_app/widgets/form_container_widget.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // используется для индикатора загрузки
  bool _isSigning = false;

  final FireBaseAuthService _auth = FireBaseAuthService();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  //Очищает контроллеры
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('lib/assets/images/logo_ver1.png'),
                const Text(
                  'Welcome to MealDeal',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
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
                  onTap: _signIn,
                  child: Container(
                    width: double.infinity,
                    // width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      // если isSigning равен true, то показывается колесико загрузки пока данные подгружаются
                      child: _isSigning
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  child: Container(
                    width: double.infinity,
                    // width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Center(
                      // если isSigning равен true, то показывается колесико загрузки пока данные подгружаются
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.google,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Sign In with Google',
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/signUp');
                      },
                      child: const Text("Sign Up",
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
  void _signIn() async {
    setState(() {
      _isSigning = true;
    });

    // помещаем текст из контроллеров в отдельные переменныеч
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      _isSigning = false;
    });

    // проверяем user на Null
    if (user != null) {
      showToast(message: "Successfully SignIn");
      Navigator.pushReplacementNamed(context, "/menu");
    } else {
      print("Some error happend");
    }
  }
}
