import 'package:flutter/material.dart';
import 'package:flutter_node_auth/core/services/auth_services.dart';
import 'package:flutter_node_auth/feature/view/signin_view.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    void signupFunc() {
      authService.signUpUser(
        context: context,
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up - Login '),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: "Password"),
              ),
              ElevatedButton(
                onPressed: signupFunc,
                child: const Center(child: Text('Sign Up ')),
              ),
              Row(
                children: [
                  const Text('I Have a acconut'),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignInView(),
                            ));
                      },
                      child: const Text('Sign In '))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
