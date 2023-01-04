import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 20),
              Text(
                'Welcome',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const Spacer(flex: 1),
              ElevatedButton(
                onPressed: () {
                  context.pushReplacement('/');
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.yellow,
                ),
                child: const Text('ENTER'),
              ),
              const Spacer(flex: 20),
            ],
          ),
        ),
      ),
    );
  }
}
