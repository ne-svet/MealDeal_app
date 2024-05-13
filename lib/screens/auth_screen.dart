import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                  onTap: _signInWithGoogle,
                  child: Container(
                    width: double.infinity,
                    // width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Center(
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

    // извлечение текста из контроллеров и сохранение их в переменные
    String email = _emailController.text;
    String password = _passwordController.text;

    // Аутентификация пользователя с использованием электронной почты и пароля
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

  // Вход с помощью google account
  _signInWithGoogle() async {
    // Создание экземпляра класса GoogleSignIn из пакета google_sign_in, который позволит аутентифицировать пользователя через Google.
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      // Попытка выполнить вход через Google. Результат сохраняется в переменной googleSignInAccount, которая может быть null.
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        // Получение учетных данных аутентификации Google для аутентифицированного аккаунта.
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        // Создание учетных данных аутентификации Firebase (AuthCredential) на основе учетных данных аутентификации Google. Эти учетные данные будут использоваться для входа в Firebase.
        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        // Аутентификация в Firebase с использованием учетных данных, созданных на предыдущем шаге. signInWithCredential
        await _firebaseAuth.signInWithCredential(credential);
        Navigator.pushNamed(context, "/menu");
      }
    } catch (e) {
      showToast(message: "some error occured $e");
    }
  }
}
