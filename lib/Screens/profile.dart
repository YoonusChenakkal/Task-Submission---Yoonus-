import 'package:flutter/material.dart';
import 'package:task1/Providers/authProvider.dart';
import 'package:task1/Screens/login.dart';
import 'package:task1/main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100.h,
        width: 100.w,
        color: Colors.white,
        child: SizedBox(
          height: 100.h,
          width: 100.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 14.w,
                child: Icon(
                  Icons.person_2_outlined,
                  size: 35.sp,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text('Logged in as: ${Provider.of<AuthProvider>(context).email}'),
              SizedBox(
                height: 2.h,
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthProvider>().logout();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => false,
                  );
                },
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  backgroundColor: WidgetStateProperty.all(
                      const Color.fromARGB(255, 249, 30, 30)),
                ),
                child: Text(
                  'Log Out',
                  style: TextStyle(fontSize: 15.sp, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
