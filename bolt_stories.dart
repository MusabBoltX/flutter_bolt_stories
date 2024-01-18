import 'package:flutter/material.dart';
import 'package:investinationmobileapp/src/app_theme/app_theme.dart';
import 'package:investinationmobileapp/src/components/buttons/button.dart';
import 'package:investinationmobileapp/src/components/functions/navigation.dart';
import 'package:investinationmobileapp/src/components/text_widgets/custom_text.dart';
import 'package:investinationmobileapp/src/core/utils/constants.dart';
import 'package:investinationmobileapp/src/core/utils/size_config.dart';
import 'package:investinationmobileapp/src/views/authentication/create_an_account.dart';
import 'package:investinationmobileapp/src/views/authentication/log_in_page.dart';
import 'package:local_auth/local_auth.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../core/auth/biometric.dart';
import '../risk_profiling/risk_profiling_questions_page.dart';

class OnboardingStories extends StatefulWidget {
  @override
  State<OnboardingStories> createState() => _OnboardingStoriesState();
}

class _OnboardingStoriesState extends State<OnboardingStories> {
  @override
  void initState() {
    _animatePages();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int _currentPage = 0;
  PageController _pageController = new PageController();
  final _momentDuration = const Duration(seconds: 5);

  bool _isFirst = true;
  bool _isSecond = false;
  bool _isThird = false;

  final List<Widget> _images = [
    Image.asset(
      "assets/images/registeration/Splash1.png",
      fit: BoxFit.fill,
    ),
    Image.asset(
      "assets/images/registeration/Splash2.png",
      fit: BoxFit.fill,
    ),
    Image.asset(
      "assets/images/registeration/Splash3.png",
      fit: BoxFit.fill,
    ),
  ];

  final List<String> _titles = [
    "Invest today, secure your tomorrow",
    "Minimum Investment from just 500 AED",
    "Refer friends and family and earn reward points!",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemCount: _titles.length,
            physics: const ScrollPhysics(),
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: SizeConfig.screenHeight,
                        width: SizeConfig.screenWidth,
                        child: _images[index],
                      ),
                      Container(
                        height: SizeConfig.screenHeight,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.center,
                            end: Alignment.bottomCenter,
                            stops: [
                              0.1,
                              0.2,
                              0.4,
                              0.6,
                              0.8,
                            ],
                            colors: [
                              baseDarkGrey.withOpacity(0.1),
                              baseDarkGrey.withOpacity(0.4),
                              baseDarkGrey.withOpacity(0.5),
                              baseDarkGrey.withOpacity(0.8),
                              baseDarkGrey.withOpacity(0.8),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: SizeConfig.screenHeight,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.topCenter,
                            stops: [
                              0.3,
                              0.5,
                              0.7,
                              0.9,
                            ],
                            colors: [
                              baseDarkGrey.withOpacity(0.1),
                              baseDarkGrey.withOpacity(0.1),
                              baseDarkGrey.withOpacity(0.1),
                              baseDarkGrey.withOpacity(0.1),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: SizeConfig.screenHeight! / 1.5,
                    width: SizeConfig.screenWidth! / 1.2,
                    padding: const EdgeInsets.only(left: 10),
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      _titles[index],
                      style: TextStyle(
                        fontSize: SizeConfig.screenWidth! / 12,
                        fontWeight: FontWeight.w600,
                        color: SimpleTextField_theme.white,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          GestureZone(),
          Padding(
            padding: EdgeInsets.only(
              top: SizeConfig.screenHeight! * 0.06,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: LinearPercentIndicator(
                        animation: _isFirst,
                        animationDuration: _momentDuration.inMilliseconds,
                        onAnimationEnd: () {
                          setState(() {
                            _isFirst = false;
                            _isSecond = true;
                            _isThird = false;
                            _currentPage = 0;
                          });
                        },
                        lineHeight: 8,
                        percent: 1.0,
                        barRadius: Radius.circular(30),
                        progressColor:
                            _currentPage == 0 ? baseBtnGold : baseLightGrey,
                        backgroundColor: baseLightGrey,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: LinearPercentIndicator(
                        animation: _isSecond,
                        animationDuration: _momentDuration.inMilliseconds,
                        onAnimationEnd: () {
                          setState(() {
                            _isFirst = false;
                            _isSecond = false;
                            _isThird = true;
                            _currentPage = 1;
                          });
                        },
                        lineHeight: 8,
                        percent: 1.0,
                        barRadius: Radius.circular(30),
                        progressColor:
                            _currentPage == 1 ? baseBtnGold : baseLightGrey,
                        backgroundColor: baseLightGrey,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: LinearPercentIndicator(
                        animation: _isThird,
                        animationDuration: _momentDuration.inMilliseconds,
                        onAnimationEnd: () {
                          setState(() {
                            _isFirst = true;
                            _isSecond = false;
                            _isThird = false;
                            _currentPage = 2;
                          });
                        },
                        lineHeight: 8,
                        percent: 1.0,
                        barRadius: Radius.circular(30),
                        progressColor:
                            _currentPage == 2 ? baseBtnGold : baseLightGrey,
                        backgroundColor: baseLightGrey,
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      push(context, LogInPage());
                    },
                    child: CustomText(
                      text: "\nLogin    ",
                      color: SimpleTextField_theme.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Button(
            text: "Let's Start",
            tapAction: () {
              push(context, CreateAccount());
            },
          ),
          SizedBox(height: 10),
          Button(
            text: "Explore",
            transparent: true,
            active: true,
            tapAction: () async {
              // BankTransferBeneficiaryPage();
              // push(context, BankTransferBeneficiaryPage());
              // push(context, RiskProfileQuestionsScreen());
            },
          ),
        ],
      ),
    );
  }

  Widget GestureZone() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: () {
              if (_currentPage != 0) {
                _pageController.previousPage(
                  duration: Duration(milliseconds: 100),
                  curve: Curves.bounceIn,
                );
              }
            },
            child: Container(color: Colors.transparent),
          ),
        ),
        Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: () {
              if (_currentPage != 2) {
                _pageController.nextPage(
                  duration: Duration(milliseconds: 100),
                  curve: Curves.decelerate,
                );
              }
            },
            child: Container(color: Colors.transparent),
          ),
        ),
      ],
    );
  }

  Future<void> _animatePages() async {
    print(_currentPage);
    if (_currentPage == 0) {
      Future.delayed(
        Duration(seconds: 5),
        () async {
          await _pageController.animateToPage(
            1,
            duration: Duration(milliseconds: 10),
            curve: Curves.fastOutSlowIn,
          );
          _animatePages();
        },
      );
    }
    if (_currentPage == 1) {
      Future.delayed(
        Duration(seconds: 5),
        () async {
          await _pageController.animateToPage(
            2,
            duration: Duration(milliseconds: 10),
            curve: Curves.fastOutSlowIn,
          );
          _animatePages();
        },
      );
    }
    if (_currentPage == 2) {
      Future.delayed(
        Duration(seconds: 5),
        () async {
          await _pageController.animateToPage(
            0,
            duration: Duration(milliseconds: 10),
            curve: Curves.fastOutSlowIn,
          );
          _animatePages();
        },
      );
    }
  }
}
