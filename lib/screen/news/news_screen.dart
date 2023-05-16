import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:medical_bmi/api/main_viewmodel.dart';
import 'package:medical_bmi/screen/news/news_item_view.dart';
import 'package:stacked/stacked.dart';

import '../../utility/color_utility.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () {
        return MainViewModel();
      },
      builder: (BuildContext context, MainViewModel viewModel, Widget? child) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                backgroundColor: Color(0xFF40858B),
                title: const Text(
                  "Yangiliklar",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              body: RefreshIndicator(
                  child: ListView.builder(
                      itemCount: viewModel.newsList.length,
                      itemBuilder: (context, position) {
                        var item = viewModel.newsList[position];
                        return NewsItemView(item:item);
                      }),
                  onRefresh: () async {}),
            ),
            if(viewModel.progressData) showMyProgress()
          ],
        );
      },
      onViewModelReady: (viewmodel){
        viewmodel.getNews();

        viewmodel.errorData.listen((event) {
          CherryToast.error(
            title: const Text('Error'),
            enableIconAnimation: false,
            displayTitle: false,
            description: Text(event),
            animationType: AnimationType.fromTop,
            animationDuration: const Duration(milliseconds: 1000),
            autoDismiss: true,
          ).show(context);
        });
      },
    );
  }
}
