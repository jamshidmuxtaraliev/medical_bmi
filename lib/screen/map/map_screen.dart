import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:medical_bmi/api/main_viewmodel.dart';
import 'package:medical_bmi/models/clinica_location_model.dart';
import 'package:stacked/stacked.dart';

import '../../generated/assets.dart';
import '../../utility/app_constant.dart';
import '../../utility/color_utility.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final List<Marker> _markers = <Marker>[];
  List<LatLng> latLen = [];

  // <LatLng>[
  //   LatLng(40.36670366997483, 71.77366069638434),
  //   LatLng(40.36823792163901, 71.79024545747686),
  //   LatLng(40.378547708377525, 71.76931479096903),
  //   LatLng(40.36565820931183, 71.78354023776305)
  // ];

  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;
  Uint8List? marketimages;

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  Future<Uint8List> getImages(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  addMarkersData(List<ClinicaLocationModel> clinicaList) async {
    for (int i = 0; i < 4; i++) {
      final Uint8List markIcons = await getImages(Assets.imagesHospital, 80);
      _markers.add(Marker(
        markerId: MarkerId(i.toString()),
        icon: BitmapDescriptor.fromBytes(markIcons),
        position: latLen[i],
        infoWindow: InfoWindow(
          title: "Batafsil malumot 👆",
          onTap: (){
            print("aaaaaaaaaaaaaaaaaaa");
            for (var element in clinicaList) {
              if (element.lat == latLen[i].latitude.toString() &&
                  element.long == latLen[i].longitude.toString()) {
                showClinicInfo(element);
              }
            }
          }
        ),
      ));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () {
        return MainViewModel();
      },
      builder: (context, viewModel, child) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                title: Text("Sanitariya Stansiyalari"),
                backgroundColor: Color(0xFF40858B),
              ),
              body: GoogleMap(
                // myLocationButtonEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: LatLng(currentLocation?.latitude ?? 40.36488216064841,
                      currentLocation?.longitude ?? 71.77510355792066),
                  // target: LatLng(40.36565820931183, 71.78354023776305),
                  zoom: 13.5,
                ),
                markers: Set<Marker>.of(_markers),
                onTap: (latLong) {
                  viewModel.clinicaList.forEach((element) {
                    if (element.lat == latLong.latitude.toString() &&
                        element.long == latLong.longitude.toString()) {
                      showClinicInfo(element);
                      print("aaaaaaaaaaaaaaaaaaa");
                    }
                  });
                },
                onMapCreated: (mapController) {
                  _controller.complete(mapController);
                },
              ),
            ),
            if (viewModel.progressData)
              Container(
                color: Colors.lightBlueAccent.withOpacity(0.3),
                width: double.infinity,
                height: double.infinity,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
          ],
        );
      },
      onViewModelReady: (viewModel) {
        viewModel.getClinicLOcations();

        viewModel.locationListStream.listen((event) {
          latLen = event.map((e) => LatLng(double.parse(e.lat), double.parse(e.long))).toList();
          addMarkersData(event);
        });

        viewModel.errorData.listen((event) {
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

  void getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then(
      (location) {
        currentLocation = location;
      },
    );
    GoogleMapController googleMapController = await _controller.future;
    location.onLocationChanged.listen(
      (newLoc) {
        currentLocation = newLoc;
        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 13.5,
              target: LatLng(
                newLoc.latitude ?? 40.36488216064841,
                newLoc.longitude ?? 71.77510355792066,
              ),
            ),
          ),
        );
        setState(() {});
      },
    );
  }

  TextStyle greyTextStill() {
    return const TextStyle(color: Colors.black, fontSize: 14, fontFamily: "semibold");
  }

  void showClinicInfo(ClinicaLocationModel latLong) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(18.0)),
        ),
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
            return DraggableScrollableSheet(
                initialChildSize: 0.5,
                maxChildSize: 0.5,
                expand: false,
                builder: (BuildContext context, ScrollController scrollController) {
                  return SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const SizedBox(
                          height: 10,
                        ),
                        dialogRoundedShapeB(),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            print("${CLINIC_BASE_URL}${latLong.image}");
                            final imageProvider = Image.network("${CLINIC_BASE_URL}${latLong.image}").image;
                            showImageViewer(
                                swipeDismissible: true,
                                doubleTapZoomable: true,
                                useSafeArea: true,
                                immersive: false,
                                context,
                                imageProvider, onViewerDismissed: () {
                              print("dismissed");
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            height: 170,
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueGrey, width: .5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl: "${CLINIC_BASE_URL}${latLong.image}",
                                  placeholder: (context, url) => const Center(
                                      child: SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            color: Colors.grey,
                                          ))),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.image_not_supported_outlined),
                                  height: 170,
                                  width: double.infinity,
                                  fit: BoxFit.contain,
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                latLong.name,
                                style: TextStyle(color: Colors.black, fontSize: 20),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                latLong.text ?? "",
                                style: TextStyle(color: Colors.black, fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });
          });
        });
  }
}
