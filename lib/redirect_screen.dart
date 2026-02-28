import 'package:ecommerce_app/providers/auth_controller.dart';
import 'package:ecommerce_app/screens/home_screen.dart';
import 'package:ecommerce_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RedirectScreen extends ConsumerWidget {
  const RedirectScreen({super.key});

  @override
  Widget build(BuildContext context,ref) {
    final authController = ref.watch(authControllerProvider);
    return Scaffold(
      body: Center(
        child:  authController.when(
          data: (data){
            if(data==null) return LoginScreen();
            return HomeScreen(userEmail: data.email);
          },
          error: (e,s)=>LoginScreen(),
          loading: ()=>CircularProgressIndicator()

        ),
      ),
    );
  }
}
