import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medical_bmi/screen/reports/send_report_screen.dart';

import '../models/report_model.dart';

class ReportItemView extends StatefulWidget {
  ReportModel item;

  ReportItemView({Key? key, required this.item}) : super(key: key);

  @override
  State<ReportItemView> createState() => _ReportItemViewState();
}

class _ReportItemViewState extends State<ReportItemView> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SendReportScreen(currentReport: widget.item)));
      },
      child: Card(
        elevation: 4,
        color: Colors.white70,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 6, top: 6),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              border: Border.all(color: Color(0xFF40858B), width: 1)),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                widget.item.text ?? "Yangi topshiriq",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
              )),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "23:55",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
              const Icon(
                Icons.navigate_next,
                color: Colors.green,
              )
            ],
          ),
        ),
      ),
    );
  }
}
