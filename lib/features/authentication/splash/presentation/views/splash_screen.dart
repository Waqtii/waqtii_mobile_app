import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:waqtii/core/components/default_button.dart';
import 'package:waqtii/features/authentication/login/presentation/views/login_screen.dart';
import 'package:waqtii/features/authentication/register/presentation/views/register_monitor_screen.dart';
import 'package:waqtii/features/authentication/register/presentation/views/register_user_screen.dart';

class OnBoardingModel {
  final String image;
  final String body;

  OnBoardingModel({required this.image, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var onBoardController = PageController();

  List<OnBoardingModel> onboard = [
    OnBoardingModel(
      image: 'assets/images/splash1.jpeg',
      body:
          "Learning new things is a process of acquiring knowledge and skills in various areas. It involves exploration, growth, and stepping out of one's comfort zone.",
    ),
    OnBoardingModel(
        image: 'assets/images/splash2.jpeg',
        body:
            "Time management is the process of organizing and utilizing time effectively to maximize productivity."),
    OnBoardingModel(image: 'assets/images/logo.jpeg', body: '')
  ];

  bool isLast = false;

  void submit() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: SizedBox.expand(
                child: PageView.builder(
                  onPageChanged: (index) {
                    if (index == onboard.length - 1) {
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
                  controller: onBoardController,
                  itemBuilder: (BuildContext context, int index) =>
                      BuildItem(onboard[index]),
                  itemCount: onboard.length,
                ),
              ),
            ),
            ConditionalBuilder(
              condition: isLast,
              builder: (context) => Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DefaultButton(
                      color: Color(0xfffab94f),
                      text: 'SignUp as User',
                      onPressed: () {
                        if (isLast) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterUserScreen(),
                            ),
                            (route) => false,
                          );
                        } else {
                          onBoardController.nextPage(
                              duration: Duration(milliseconds: 700),
                              curve: Curves.decelerate);
                        }
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  DefaultButton(
                      color: Color.fromARGB(255, 250, 155, 2),
                      text: 'SignUp as Monitor',
                      onPressed: () {
                        if (isLast) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterMonitorScreen(),
                            ),
                            (route) => false,
                          );
                        } else {
                          onBoardController.nextPage(
                              duration: Duration(milliseconds: 700),
                              curve: Curves.decelerate);
                        }
                      }),
                ],
              ),
              fallback: (context) => DefaultButton(
                  color: Color(0xfffab94f),
                  text: 'Next',
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      onBoardController.nextPage(
                          duration: Duration(milliseconds: 700),
                          curve: Curves.decelerate);
                    }
                  }),
            ),
            ConditionalBuilder(
              condition: isLast,
              builder: (context) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account? '),
                  TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                          (route) => false,
                        );
                      },
                      child: Text(
                        'Sign in',
                        style:
                            TextStyle(fontSize: 17, color: Color(0xfffab94f)),
                      ))
                ],
              ),
              fallback: (context) => TextButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      onBoardController.animateToPage(
                          onBoardController.page!.toInt() + 2,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    }
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(fontSize: 17, color: Colors.grey),
                  )),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
          ],
        ),
      ),
    );
  }

  Widget BuildItem(OnBoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('${model.image}'),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Text(
            '${model.body}',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w300, height: 1.3),
          ),
        ],
      );
}
