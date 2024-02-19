import 'package:flutter/material.dart';
import 'package:flutter_node_auth/core/services/auth_services.dart';
import 'package:flutter_node_auth/providers/user_provider.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserProvider>().userModel;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home View '),
        actions: [
          IconButton(
              onPressed: () {
                AuthService().signOut(context: context);
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: Column(
        children: [
          Text(user.email),
        ],
      ),
    );
  }
}
