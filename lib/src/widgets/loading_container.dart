import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  const LoadingContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: buildContainer(),
          subtitle: buildContainer(),
        ),
        const Divider(
          height: 5.0,
        ),
      ],
    );
  }
}

Widget buildContainer() {
  return Container(
    color: Colors.grey[200],
    height: 24,
    width: 150,
  );
}
