import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int snake = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(milliseconds: 200), (_) {
      setState(() {
        snake = snake == 400 ? 0 : snake + 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Snake Game'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 350,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 4,
                  color: Colors.grey,
                ),
              ),
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 20,
                ),
                children: List.generate(
                  400,
                  (index) => Container(
                    margin: const EdgeInsets.all(1.0),
                    width: 15.0,
                    height: 15.0,
                    color: index == snake ? Colors.red : Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: [
              CustomIconButton(
                onPressed: () {},
                icon: Icons.arrow_upward_sharp,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomIconButton(
                    onPressed: () {},
                    icon: Icons.arrow_back,
                  ),
                  CustomIconButton(
                    onPressed: () {},
                    icon: Icons.arrow_forward_outlined,
                  ),
                ],
              ),
              CustomIconButton(
                onPressed: () {},
                icon: Icons.arrow_downward_outlined,
              ),
            ],
          )
        ],
      ),
    );
  }
}

// create custom icon button
class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });
  final VoidCallback onPressed;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: 45,
      ),
    );
  }
}
