import 'package:flutter/material.dart';
import 'package:flutter_node_auth/core/services/auth_services.dart';
import 'package:flutter_node_auth/feature/view/home_view.dart';
import 'package:flutter_node_auth/feature/view/signup_view.dart';
import 'package:flutter_node_auth/providers/user_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final tokenIsEmpty = context.watch<UserProvider>().userModel.token.isEmpty;
    return MaterialApp(
      title: 'Node auth process',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: tokenIsEmpty
          ? const SignUpView()
          : const HomeView(),
    );
  }
}
