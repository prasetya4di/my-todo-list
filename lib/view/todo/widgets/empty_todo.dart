import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_todo_list/generated/assets.dart';

class EmptyTodo extends StatelessWidget {
  const EmptyTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SvgPicture.asset(Assets.imagesEmptyTodo, width: 250),
                const SizedBox(height: 20),
                Text(
                    "Looks like you're all caught up! No todos to show. Why not take a break and enjoy some free time? Or, if you're feeling productive, click the plus button to start adding some new todos and manage your tasks like a pro!",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
          ),
          Positioned(
            bottom: 80,
            right: 10,
            child: SvgPicture.asset(Assets.imagesIcArrowDownBlue, width: 100),)
        ],
      ),
    );
  }
}
