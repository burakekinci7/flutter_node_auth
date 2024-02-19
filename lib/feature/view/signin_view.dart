import 'package:flutter/material.dart';
import 'package:flutter_node_auth/core/services/auth_services.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final AuthService authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Future<void> signInFunc() async {
    await authService.signInUser(
        context: context,
        email: emailController.text,
        password: passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In View'),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            ElevatedButton(
              onPressed: signInFunc,
              child: const Center(child: Text('Sign In ')),
            )
          ],
        ),
      )),
    );
  }
}
