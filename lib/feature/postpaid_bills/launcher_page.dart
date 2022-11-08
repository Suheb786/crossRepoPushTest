import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';

class PostPaidUiScreenLauncherPage extends StatelessWidget {
  const PostPaidUiScreenLauncherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  RoutePaths.PayAllPostPaidBillsPage,
                );
              },
              child: Text('All Pay Bills')),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  RoutePaths.ViewPostPaidBillsPage,
                );
              },
              child: Text('view my Bills')),
        ],
      ),
    );
  }
}
