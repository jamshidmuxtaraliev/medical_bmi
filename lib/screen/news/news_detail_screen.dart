import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:medical_bmi/models/news_model.dart';
import 'package:medical_bmi/screen/home/home_page.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import '../../utility/app_constant.dart';

class NewsDetailScreen extends StatefulWidget {
  NewsModel newsItem;

  NewsDetailScreen({super.key, required this.newsItem});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              flexibleSpace: FlexibleSpaceBar(
                  background: InkWell(
                onTap: () {
                  final imageProvider = Image.network("https://picsum.photos/id/1001/5616/3744").image;

                  showImageViewer(
                      swipeDismissible: true,
                      doubleTapZoomable: true,
                      useSafeArea: true,
                      immersive: false,
                      context,
                      imageProvider, onViewerDismissed: () {
                    print("dismissed while on page ");
                  });
                },
                child: CachedNetworkImage(
                  imageUrl: (widget.newsItem.image != "")
                      ? "${IMAGE_BASE_URL}${widget.newsItem.image}"
                      : "https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg",
                  // "${BASE_URL_HOUSE_IMAGE}${widget.houseItem.images?[indexx].image}",
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                      child: Container(
                          height: 20,
                          width: 20,
                          child: const CircularProgressIndicator(
                            color: Colors.grey,
                          ))),
                  errorWidget: (context, url, error) => ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                          color: Colors.grey.shade50,
                          child: Image.asset(
                            "assets/images/image_icon.png",
                          ))),
                ),
              )),
              expandedHeight: 400,
              backgroundColor: BACKGROUND_COLOR,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(10),
                child: Container(
                  height: 20,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    gradient: LinearGradient(
                        colors: [Color(0xFFEEEBEB), Colors.white],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(70),
                      topRight: Radius.circular(70),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 7),
                      Container(
                        height: 4,
                        width: 100,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(70),
                            topRight: Radius.circular(70),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              automaticallyImplyLeading: false,
              title: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(
                    MaterialPageRoute(
                      builder: (BuildContext context) => HomePage(),
                    ),
                  );
                },
                child: const CircleAvatar(
                  backgroundColor: Color.fromRGBO(250, 250, 250, 0.6),
                  radius: 18,
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      widget.newsItem.title ?? "Yangilik sarlavhasi",
                      style: const TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: "semibold"),
                    ),
                    const SizedBox(height: 12),
                    const SizedBox(height: 20),
                    Text(
                      widget.newsItem.sub_title ?? "Batafsil malumot oling",
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    const Text(
                      "Yangilikning to'liq matni",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        widget.newsItem.text ?? "text description",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
