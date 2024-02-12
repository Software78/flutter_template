import 'package:flutter/material.dart';
import 'package:fluttersanctum/providers/auth.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => LoginState();
}

class LoginState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  void submit() {
    Provider.of<Auth>(context, listen: false).login(
      credentials: {
        'email': _email,
        'password': _password,
      },
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: const Text('Login'),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Login',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    initialValue: 'steve@stevepop.com',
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                    onSaved: (value) => {
                      _email = value!,
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    initialValue: 'password',
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                    onSaved: (value) => {
                      _password = value!,
                    },
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _formKey.currentState?.save();
                    submit();
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ));
  }
}
