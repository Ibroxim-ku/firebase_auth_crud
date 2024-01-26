import 'package:contac_app/pages/services/auth_service.dart';
import 'package:contac_app/pages/view/auth/register_page.dart';
import 'package:contac_app/pages/view/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(hintText: "Email"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(hintText: "Password"),
            ),
            const SizedBox(height: 20),
            CupertinoButton(
              onPressed: () async {
                User? user;
                try {
                  user = await AuthService.loginUser(
                      context, emailController.text, passwordController.text);
                  if (user != null) {
                    // ignore: use_build_context_synchronously
                    Navigator.pushAndRemoveUntil(
                      context,
                      // ignore: use_build_context_synchronously
                      CupertinoDialogRoute(
                          builder: (context) => const HomePage(),
                          context: context),
                      (route) => false,
                    );
                  }
                } catch (e) {
                  Future.delayed(Duration.zero).then(
                    (value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Successfully login in",
                          ),
                        ),
                      );
                    },
                  );
                }
              },
              color: Colors.deepPurpleAccent,
              child: const Text(
                "Sign up",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            CupertinoModalPopupRoute(
              builder: (context) => const RegisterPage(),
            ),
          );
        },
        child: const Icon(Icons.create),
      ),
    );
  }
}
