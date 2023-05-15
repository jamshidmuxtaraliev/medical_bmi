import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medical_bmi/models/news_model.dart';
import 'package:medical_bmi/screen/news/news_detail_screen.dart';

import '../../utility/app_constant.dart';

class NewsItemView extends StatefulWidget {
  NewsModel item;

  NewsItemView({Key? key, required this.item}) : super(key: key);

  @override
  State<NewsItemView> createState() => _NewsItemViewState();
}

class _NewsItemViewState extends State<NewsItemView> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => NewsDetailScreen(newsItem: widget.item)));
      },
      child: Container(
          margin: const EdgeInsets.only(left: 14, right: 14, top: 8, bottom: 6),
          // padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: ACCENT.withOpacity(0.1),
                spreadRadius: 3,
                blurRadius: 3,
                offset: const Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.5, color: Colors.grey),
                        borderRadius: const BorderRadius.all(Radius.circular(6)),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6), // Image border
                        child: SizedBox.fromSize(
                            size: const Size.fromHeight(150), // Image radius
                            child: CachedNetworkImage(
                              imageUrl: (widget.item.image != "")
                                  ? "${IMAGE_BASE_URL}${widget.item.image}"
                                  : "https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg",
                              // imageUrl: widget.houseItem.images![0].image,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                  child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.grey,
                                      ))),
                              errorWidget: (context, url, error) => ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                      color: Colors.grey.shade50,
                                      child: Image.asset(
                                        "assets/images/image_icon.png",
                                      ))),
                            )),
                      ),
                    ),
                    Positioned(
                      bottom: 3,
                      left: 2,
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                        // shape: BeveledRectangleBorder(),
                        color: Colors.white,
                        elevation: 4,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: Text(
                            "news",
                            style: TextStyle(
                                color: COLOR_PRIMARY, fontFamily: "semibold", fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.item.title ?? "SES Yangiliklari",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  widget.item.sub_title ?? "Batafsil o'qish...",
                  style:
                      const TextStyle(color: Colors.black87, fontSize: 16, overflow: TextOverflow.ellipsis),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 6,
                ),
              ],
            ),
          )),
    );
  }
}
