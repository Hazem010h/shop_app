import 'package:flutter/material.dart';
import 'package:shop_app/cache_helper.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/login_screen.dart';
import 'package:shop_app/reusable_widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel{

  Icon icon;
  String title;
  String body;

  BoardingModel({
    required this.icon,
    required this.title,
    required this.body,
});
}

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});

  List<BoardingModel> boardingItems=[
    BoardingModel(
      icon: Icon(Icons.looks_one_rounded),
      title: 'title 1',
      body: 'body 1',
    ),
    BoardingModel(
      icon: Icon(Icons.looks_two_rounded),
      title: 'title 2',
      body: 'body 2',
    ),
    BoardingModel(
      icon: Icon(Icons.looks_3_rounded),
      title: 'title 3',
      body: 'body 3',
    ),
  ];
  PageController boardingController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: PageView.builder(
                    itemBuilder: (context,index)=>boardingItem(boardingItems[index]),
                  itemCount: boardingItems.length,
                  controller: boardingController,

                ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: (){
                    boardingController.previousPage(duration: Duration(seconds: 1), curve: Curves.ease);
                  },
                  icon: Icon(
                      Icons.arrow_back
                  ),
                ),
                Spacer(),
                SmoothPageIndicator(
                  controller: boardingController,
                  count: boardingItems.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: defaultLightColor,
                  ),
                ),
                Spacer(),
                IconButton(
                    onPressed: (){
                      boardingController.nextPage(duration: Duration(seconds: 1), curve: Curves.ease);
                    },
                    icon: Icon(
                      Icons.arrow_forward
                    ),
                ),
              ],
            ),
            reusableElevatedButton(
                label: 'Skip',
                width: double.infinity,
                backColor: defaultLightColor,
                radius: buttonsBoarderRaduis,
                function: (){
                  CacheHelper.saveData(key: 'showBoardingScreen', value: false);
                  navigateAndFinish(context: context, screen: LoginScreen());
                },
            ),
          ],
        ),
      ),
    );
  }

  Widget boardingItem(BoardingModel item){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Center(child: item.icon),
        ),
        const SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            item.title,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
            item.body,
        ),
      ],
    );
  }

}
