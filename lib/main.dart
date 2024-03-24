import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum DirectionSnake { up, down, left, right }

class Snake {
  final List<int> length;

  Snake(this.length);

  Snake copyWith({
    List<int>? length,
  }) {
    return Snake(
      length ?? this.length,
    );
  }

  @override
  String toString() => 'Snake($length)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Snake && listEquals(other.length, length);
  }

  @override
  int get hashCode => length.hashCode;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int snake = 0;
  int moveTo = 1;
  List<int> snakes = [];
  Map<Snake, DirectionSnake> moveSnake = {};
  DirectionSnake direction = DirectionSnake.right;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(milliseconds: 200), (_) {
      setState(() {
        snake = snake == 400 ? 0 : snake + moveTo;
        moveSnake = {
          Snake([snake, snake + 1, snake + 2]): direction,
        };
        moveSnake.forEach((key, value) {
          switch (value) {
            case DirectionSnake.up:
              moveTo = -20;
              snakes = [
                snake + moveTo,
                snake + moveTo + 20,
                snake + moveTo + 40
              ];
              break;
            case DirectionSnake.down:
              moveTo = 20;
              snakes = [
                snake + moveTo,
                snake + moveTo + 20,
                snake + moveTo + 40
              ];
              break;
            case DirectionSnake.left:
              moveTo = -1;
              snakes = [snake + moveTo, snake + moveTo + 1, snake + moveTo + 2];
              break;
            case DirectionSnake.right:
              moveTo = 1;
              snakes = [snake + moveTo, snake + moveTo + 1, snake + moveTo + 2];
              break;
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
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
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 20,
                ),
                itemCount: 400,
                itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.all(1.0),
                  width: 15.0,
                  height: 15.0,
                  color: snakes.contains(index) ? Colors.red : Colors.white,
                ),
              ),
            ),
          ),
          Column(
            children: [
              CustomIconButton(
                onPressed: () => _setDirection(DirectionSnake.up),
                icon: Icons.arrow_upward_sharp,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomIconButton(
                    onPressed: () => _setDirection(DirectionSnake.left),
                    icon: Icons.arrow_back,
                  ),
                  CustomIconButton(
                    onPressed: () => _setDirection(DirectionSnake.right),
                    icon: Icons.arrow_forward_outlined,
                  ),
                ],
              ),
              CustomIconButton(
                onPressed: () => _setDirection(DirectionSnake.down),
                icon: Icons.arrow_downward_outlined,
              ),
            ],
          )
        ],
      ),
    );
  }

  void _setDirection(DirectionSnake newDirection) {
    setState(() {
      direction = newDirection;
    });
    log(direction.toString());
    log(moveSnake.keys.toString());
  }
}

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
