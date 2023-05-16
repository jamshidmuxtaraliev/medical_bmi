import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:medical_bmi/widget/report_item_view.dart';
import 'package:stacked/stacked.dart';

import '../../api/main_viewmodel.dart';
import '../../utility/color_utility.dart';
import '../news/news_item_view.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
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
                      itemCount: viewModel.reportList.length,
                      itemBuilder: (context, position) {
                        var item = viewModel.reportList[position];
                        return ReportItemView(item:item);
                      }),
                  onRefresh: () async {
                    viewModel.getMyReports();
                  }),
            ),
            if(viewModel.progressData) showMyProgress()
          ],
        );
      },
      onViewModelReady: (viewmodel){
        viewmodel.getMyReports();

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
