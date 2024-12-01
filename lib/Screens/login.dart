import 'package:flutter/material.dart';
import 'package:task1/Providers/authProvider.dart';
import 'package:task1/Screens/home.dart';
import 'package:task1/Widgets/customTextField.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController tcEmail = TextEditingController();
  final TextEditingController tcPassword = TextEditingController();

  @override
  void dispose() {
    tcEmail.dispose();
    tcPassword.dispose();
    super.dispose();
  }

  void _login(BuildContext context, AuthProvider authProvider) async {
    await authProvider.login(
      tcEmail.text,
      tcPassword.text,
      context,
    );

    if (authProvider.token != null) {
      // On successful login, navigate to Home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Stack(
          children: [
            Positioned(
                top: 0,
                child: Container(
                    height: 50.h,
                    width: 100.w,
                    color: const Color.fromARGB(224, 155, 220, 252),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          'Flutter Mechine Test',
                          style: TextStyle(
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w600
                          ),
                        )
                      ],
                    )
                )
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 75.h,
                width: 100.w,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 12.h),
                    Text(
                      'Enter Login ID',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 71, 71, 71),
                        fontSize: 18.sp,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    customTextField(
                      title: 'Email',
                      width: 80.w,
                      tc: tcEmail,
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    customTextField(
                      title: 'Password',
                      width: 80.w,
                      tc: tcPassword,
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    SizedBox(
                      height: 5.h,
                      width: 30.w,
                      child: Consumer<AuthProvider>(
                        builder: (context, authProvider, child) {
                          return ElevatedButton(
                            onPressed: authProvider.isLoading
                                ? null
                                : () => _login(context, authProvider),
                            style: ButtonStyle(
                              shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              backgroundColor: const WidgetStatePropertyAll(
                                Color.fromARGB(255, 30, 121, 249),
                              ),
                            ),
                            child: authProvider.isLoading
                                ? SizedBox(
                              height: 3.h,
                              width: 7.w,
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ) // Show loader while loading
                                : Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Colors.white
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
