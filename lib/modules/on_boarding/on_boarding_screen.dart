import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/modules/login/login_screen.dart';
import 'package:shopping_app/shared/components/components.dart';
import 'package:shopping_app/shared/networks/local/cache_helper.dart';
import 'package:shopping_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel(
      this.image,
      this.title,
      this.body);
}

class OnBoardingScreen extends StatefulWidget {

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel('assets/images/on_boarding_1.jpg', 'On Bord 1 Title', 'On Bord 1 Body'),
    BoardingModel('assets/images/on_boarding_2.jpg', 'On Bord 2 Title', 'On Bord 2 Body'),
    BoardingModel('assets/images/on_boarding_3.jpg', 'On Bord 3 Title', 'On Bord 3 Body'),
  ];

  bool isLast = false;

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value){
      if(value) navigateAndFinish(context, LoginScreen());
      print(CacheHelper.getData('onBoarding'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: () {
            submit();
          }, child: Text('SKIP'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(29.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                 onPageChanged: (int index) {
                   index == boarding.length-1? setState(() {isLast = true;}) : setState(() {isLast = true;});

                 },
                controller: boardController,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildPageViewItem(boarding[index]),
              itemCount: boarding.length,),
            ),
            SizedBox(height: 39,),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                effect: ExpandingDotsEffect(
                  dotColor: Colors.grey,
                  activeDotColor:  defaultColor,
                  dotHeight: 9,
                  dotWidth: 9,
                  spacing: 5,
                  expansionFactor: 3,
                ) ,),
                Spacer(),
                FloatingActionButton(onPressed: () {
                  if(isLast) submit();
                  boardController.nextPage(
                      duration: Duration(milliseconds: 751),
                      curve: Curves.fastLinearToSlowEaseIn,
                  );
                },
                child: Icon(Icons.arrow_forward_ios),)
              ],
            ),

          ],
        ),
      )
    );
  }

  Widget buildPageViewItem(BoardingModel model) => Column(
    children: [
      Image(
        image: AssetImage('${model.image}'),
      ),
      SizedBox(height: 29,),
      Text('${model.title}',
        style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold
        ),
      ),
      SizedBox(height: 15,),
      Text('${model.body}',
        style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold
        ),
      ),
      SizedBox(height: 15,),
    ],
  );
}
