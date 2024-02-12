import 'package:flutter/material.dart';
import 'package:fluttersanctum/providers/auth.dart';
import 'package:fluttersanctum/screen/login_screen.dart';
import 'package:provider/provider.dart';
import '../screen/posts_screen.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key, Key? key2});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Consumer<Auth>(builder: (context, auth, child) {
        if (auth.isAuthenticated) {
          return Column(
            children: <Widget>[
              const SizedBox(height: 50), // Add space at the top
              ListTile(
                title: Text(auth.user.name),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PostScreen()),
                  );
                },
              ),
              ListTile(
                title: const Text('Posts'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PostScreen()),
                  );
                },
              ),
              ListTile(
                title: const Text('Logout'),
                onTap: () {
                  Provider.of<Auth>(context, listen: false).logout();
                  Navigator.pop(context);
                },
              ),
            ],
          );
        } else {
          return Column(
            children: <Widget>[
              const SizedBox(height: 50), // Add space at the top
              ListTile(
                title: const Text('Login'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                },
              ),
              ListTile(
                title: const Text('Register'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                },
              ),
            ],
          );
        }
      }),
    );
  }
}
