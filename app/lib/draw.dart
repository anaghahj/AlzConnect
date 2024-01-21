import 'package:flutter/material.dart';
import 'package:spryzen/listv.dart';

class appdrawer extends StatelessWidget {
  const appdrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            child: Row(
              children: [
                const Icon(Icons.health_and_safety_sharp,
                    size: 24, color: Colors.white),
                SizedBox(width: 18),
                Text(
                  "SPRYZEN",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                ),
              ],
            ),
          ),
          const liste(),
        ],
      ),
    );
  }
}
