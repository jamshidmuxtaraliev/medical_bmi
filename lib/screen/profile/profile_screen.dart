import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:medical_bmi/api/main_viewmodel.dart';
import 'package:medical_bmi/utility/pref_utils.dart';
import 'package:stacked/stacked.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

var nameController = TextEditingController();
var emailController = TextEditingController();
var phoneController = TextEditingController();
var bioController = TextEditingController();

class _ProfileScreenState extends State<ProfileScreen> {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    nameController.text = PrefUtils.getUser()?.fullname.toString() ?? "";
    emailController.text = PrefUtils.getUser()?.email.toString() ?? "";
    phoneController.text = PrefUtils.getUser()?.phone_number.toString() ?? "";
    bioController.text = PrefUtils.getUser()?.bio.toString() ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () {
        return MainViewModel();
      },
      builder: (BuildContext context, MainViewModel viewModel, Widget? child) {
        return Scaffold(
            body: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: 200.0,
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.black,
                                    size: 22.0,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 25.0),
                                  child: Text('PROFILE',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                          fontFamily: 'sans-serif-light',
                                          color: Colors.black)),
                                )
                              ],
                            )),
                        Container(
                            width: 140.0,
                            height: 140.0,
                            padding: const EdgeInsets.only(top: 20.0),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: ExactAssetImage('assets/images/as.png'),
                                fit: BoxFit.cover,
                              ),
                            ))
                      ],
                    ),
                  ),
                  Container(
                    color: const Color(0xffFFFFFF),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(
                                left: 25.0,
                                right: 25.0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: const <Widget>[
                                      Text(
                                        'Foydalanuvchi malumotari',
                                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      _status ? _getEditIcon() : Container(),
                                    ],
                                  )
                                ],
                              )),
                          Padding(
                              padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: const <Widget>[
                                      Text(
                                        'Lavozim',
                                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Flexible(
                                    child: TextField(
                                      controller: nameController,
                                      decoration: const InputDecoration(
                                        hintText: "Lavozimni kiriting",
                                      ),
                                      enabled: !_status,
                                      autofocus: !_status,
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: const <Widget>[
                                      Text(
                                        'Email ID',
                                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Flexible(
                                    child: TextField(
                                      controller: emailController,
                                      decoration: const InputDecoration(hintText: "Email ID kiriting"),
                                      enabled: !_status,
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: const <Widget>[
                                      Text(
                                        'Telefon',
                                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Flexible(
                                    child: TextField(
                                      controller: phoneController,
                                      decoration: const InputDecoration(hintText: "Raqamingizni kiriting"),
                                      enabled: !_status,
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: const <Widget>[
                                      Text(
                                        'Qisqacha tavsif',
                                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Flexible(
                                    child: TextField(
                                      minLines: 1,
                                      maxLines: 5,
                                      keyboardType: TextInputType.multiline,
                                      controller: bioController,
                                      decoration:
                                          const InputDecoration(hintText: "O'zingiz haqingizda qisqacha"),
                                      enabled: !_status,
                                    ),
                                  ),
                                ],
                              )),
                          // Padding(
                          //     padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                          //     child: Row(
                          //       mainAxisSize: MainAxisSize.max,
                          //       mainAxisAlignment: MainAxisAlignment.start,
                          //       children: const <Widget>[
                          //         Expanded(
                          //           flex: 2,
                          //           child: Text(
                          //             'Pin Code',
                          //             style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                          //           ),
                          //         ),
                          //         Expanded(
                          //           flex: 2,
                          //           child: Text(
                          //             'State',
                          //             style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                          //           ),
                          //         ),
                          //       ],
                          //     )),
                          // Padding(
                          //     padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                          //     child: Row(
                          //       mainAxisSize: MainAxisSize.max,
                          //       mainAxisAlignment: MainAxisAlignment.start,
                          //       children: <Widget>[
                          //         Flexible(
                          //           flex: 2,
                          //           child: Padding(
                          //             padding: const EdgeInsets.only(right: 10.0),
                          //             child: TextField(
                          //               decoration: const InputDecoration(hintText: "Enter Pin Code"),
                          //               enabled: !_status,
                          //             ),
                          //           ),
                          //         ),
                          //         Flexible(
                          //           flex: 2,
                          //           child: TextField(
                          //             decoration: const InputDecoration(hintText: "Enter State"),
                          //             enabled: !_status,
                          //           ),
                          //         ),
                          //       ],
                          //     )),
                          !_status ? _getActionButtons(viewModel) : Container(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
      },
      onViewModelReady: (viewmodel){
        viewmodel.errorData.listen((event) {
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
          });        });

        viewmodel.loginConfirmData.listen((event) {
          PrefUtils.setUser(event);
          Navigator.pop(context);
        });
      },
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons(MainViewModel viewmodel) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                    )),
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(FocusNode());
                  });
                  viewmodel.updateUser(
                      PrefUtils.getUser()!.username,
                      PrefUtils.getUser()!.password,
                      nameController.text,
                      phoneController.text,
                      emailController.text,
                      bioController.text);
                },
                child: const Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                    )),
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(FocusNode());
                  });
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return GestureDetector(
      child: const CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}
