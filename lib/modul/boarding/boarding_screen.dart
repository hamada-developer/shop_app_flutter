
import 'package:flutter/material.dart';
import 'package:shop_app/modul/login/login_screen.dart';
import 'package:shop_app/shared/compents/color.dart';
import 'package:shop_app/shared/compents/compents.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'model.dart';

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({Key? key}) : super(key: key);

  @override
  _BoardingScreenState createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  PageController pageController = PageController();
  List<Model> pages = [
    Model(
      url: 'assets/images/boarding_1.png',
      title: 'this is title 1',
      body: 'this is body 1',
    ),
    Model(
      url: 'assets/images/boarding_2.png',
      title: 'this is title 2',
      body: 'this is body 2',
    ),
    Model(
      url: 'assets/images/boarding_4.png',
      title: 'this is title 3',
      body: 'this is body 3',
    ),
    Model(
      url: 'assets/images/boarding_5.png',
      title: 'this is title 4',
      body: 'this is body 4',
    ),
    Model(
      url: 'assets/images/boarding_6.png',
      title: 'this is title 5',
      body: 'this is body 5',
    ),
  ];
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              CashHelper.saveData(key: 'doneBoarding', value: true);
              navigateToAndFinish(
                context: context,
                widget: LoginScreen(),
              );
            },
            child: Text(
              'skip'.toUpperCase(),
              style: TextStyle(
                color: primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  if (index == pages.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                physics: BouncingScrollPhysics(),
                controller: pageController,
                itemBuilder: (context, index) => boardingItem(pages[index]),
                itemCount: pages.length,
              ),
            ),
            SizedBox(
              height: 80.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: pages.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 4,
                    activeDotColor: primaryColor,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      CashHelper.saveData(key: 'doneBoarding', value: true);
                      navigateToAndFinish(
                        context: context,
                        widget: LoginScreen(),
                      );
                    } else {
                      pageController.nextPage(
                        duration: Duration(
                          milliseconds: 1000,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
    );
  }
}


