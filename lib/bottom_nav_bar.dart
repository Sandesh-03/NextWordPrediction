
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';

import 'package:flutter/material.dart';
import 'package:miniprojectext/rnn.dart';
import 'package:miniprojectext/text_prediction.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {


  final List<Widget> bottomBarPages = [

    const PredictNextWordScreen(),
    const PredictNextWordWithRNNScreen()
  ];
  final _pageController = PageController(initialPage: 0);

  final _controller = NotchBottomBarController(index: 0);

  int maxCount = 1;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
              bottomBarPages.length, (index) => bottomBarPages[index]),
        ),
        extendBody: true,
        bottomNavigationBar:  AnimatedNotchBottomBar(
          /// Provide NotchBottomBarController
          notchBottomBarController: _controller,
          color: Colors.white,
          showLabel: false,
          notchColor: Colors.white,
          removeMargins: true,
          bottomBarWidth: double.infinity -10,
          durationInMilliSeconds: 300,
          kIconSize: 20,
          kBottomRadius: 0,
          bottomBarItems: const [
            BottomBarItem(
              inActiveItem: Icon(
                Icons.home_filled,
              ),
              activeItem: Icon(
                Icons.home_filled,
                color: Colors.blueAccent,
              ),
              itemLabel: 'Page 1',
            ),


            BottomBarItem(
              inActiveItem: Icon(
                Icons.extension,
              ),
              activeItem: Icon(
                Icons.extension,
              ),
              itemLabel: 'Page 2',
            ),
          ],
          onTap: (index) {
            _pageController.jumpToPage(index);
          },
        )

    );
  }
}
