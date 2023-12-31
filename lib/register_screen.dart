import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _auth = FirebaseAuth.instance;
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WhatsAI', style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
              color: Theme.of(context).canvasColor
          ),
          child: Center(
            child: Container(
              width: 400,
              // decoration: BoxDecoration(
              //   color: Colors.white,
              //   borderRadius: BorderRadius.all(Radius.circular(10)),
              //   boxShadow: [
              //     BoxShadow(color: Colors.grey, offset: Offset(8, 8), blurRadius: 20)
              //   ]
              //
              // ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 64.0),
                        child: Text("Register",
                            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    TextField(
                      controller: _emailTextController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(labelText: 'Email'),
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: _passwordTextController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Password'),
                    ),
                    const SizedBox(height: 32.0),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          await _auth.createUserWithEmailAndPassword(
                            email: _emailTextController.text,
                            password: _passwordTextController.text,
                          );
                          Navigator.pushNamed(context, '/login');
                          _emailTextController.text = '';
                          _passwordTextController.text = '';
                        } catch (exception) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Register failed')));
                        }
                      },
                      child: const Text('Register'),
                    ),
                    TextButton(onPressed: (){
                      Navigator.popAndPushNamed(context, '/login');
                    }, child: const Text("Have an account?"))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
