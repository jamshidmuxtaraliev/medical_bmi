import 'dart:async';
import 'package:medical_bmi/models/news_model.dart';
import 'package:stacked/stacked.dart';
import '../api/api_service.dart';
import '../models/login_response.dart';
import '../utility/pref_utils.dart';


class MainViewModel extends BaseViewModel {
  final api = ApiService();
  final StreamController<String> _errorStream = StreamController();

  final StreamController<LoginResponse> _loginConfirmStream = StreamController();
  Stream<LoginResponse> get loginConfirmData {
    return _loginConfirmStream.stream;
  }

  final StreamController<LoginResponse> _registrationResponseStream = StreamController();
  Stream<LoginResponse> get registrationResponseData {
    return _registrationResponseStream.stream;
  }


  Stream<String> get errorData {
    return _errorStream.stream;
  }

  var progressData = false;
  var progressProjectById = false;

  List<NewsModel> newsList = [];
  // List<OfferModel> offerList = [];
  // List<ProjectModel>? myProjectsList;


  void login(String username, String password) async {
    progressData = true;
    notifyListeners();
    final data = await api.login(username, password, _errorStream);
    if (data != null) {
      PrefUtils.setToken(data.token??"");
      PrefUtils.setUser(data);
      _loginConfirmStream.sink.add(data);
    }
    progressData = false;
    notifyListeners();
  }

  // //news
  void getNews() async {
    progressData = true;
    notifyListeners();
    final data = await api.getNews(_errorStream);
    newsList = data;
    progressData = false;
    notifyListeners();
  }
  //
  //
  // void resetPassword(String phone) async {
  //   progressData = true;
  //   notifyListeners();
  //   final data = await api.resetPassword(phone, _errorStream);
  //   if (data != null) {
  //     _checkSmsStream.sink.add(data);
  //   }
  //   progressData = false;
  //   notifyListeners();
  // }

  // void newPassConfirm(
  //   String phone,
  //   String sms_code,
  //   String password,
  // ) async {
  //   progressData = true;
  //   notifyListeners();
  //   final data = await api.newPassConfirm(phone, sms_code, password, _errorStream);
  //   if (data != null) {
  //     PrefUtils.setToken(data.token);
  //     PrefUtils.setUser(data);
  //     _registrationResponseStream.sink.add(data);
  //   }
  //   progressData = false;
  //   notifyListeners();
  // }

//offer
//   void getOfferList() async {
//     final data = await api.getOfferList(_errorStream);
//     offerList = data;
//     _offerStream.sink.add(data);
//     notifyListeners();
//   }
//

//
// //rates
//   void getRates() async {
//     progressData = true;
//     notifyListeners();
//     final data = await api.getRates(_errorStream);
//     rateList = data;
//     progressData = false;
//     notifyListeners();
//   }



  // StreamController<bool> _sendRequestStream = StreamController();
  // Stream<bool> get sendRequestData {
  //   return _sendRequestStream.stream;
  // }
  //
  // StreamController<String> _sendVoiceMessageStream = StreamController();
  // Stream<String> get sendVoiceMessageData {
  //   return _sendVoiceMessageStream.stream;
  // }
  //
  // StreamController<ChatModel> _sendMessageStream = StreamController();
  // Stream<ChatModel> get sendMessageData {
  //   return _sendMessageStream.stream;
  // }
  //
  // StreamController<bool> _connectedStream = StreamController();
  // Stream<bool> get connectedData {
  //   return _connectedStream.stream;
  // }
  //
  // StreamController<UserModel> _userStream = StreamController();
  //
  // Stream<UserModel> get getUserData {
  //   return _userStream.stream;
  // }
  //
  // List<ChatModel> chatList = [];


  // void sendRequest(
  //     String project_id, String title, String comment, int prioritet, String image, String voice) async {
  //   progressData = true;
  //   notifyListeners();
  //   final data = await api.sendRequest(project_id, title, comment, prioritet, image, voice, _errorStream);
  //   progressData = false;
  //   notifyListeners();
  //   if (data != null) {
  //     _sendRequestStream.sink.add(data);
  //   }
  // }



  // void sendMessage(String message, String chat_id) async {
  //   progressData = true;
  //   notifyListeners();
  //   final data = await api.sendMessage(message, chat_id, _errorStream);
  //   progressData = false;
  //   notifyListeners();
  //   if (data != null) {
  //     _sendMessageStream.sink.add(data);
  //   }
  // }




  @override
  void dispose() {
    _errorStream.close();
    // _sendRequestStream.close();
    // _sendVoiceMessageStream.close();
    // _sendMessageStream.close();
    // _connectedStream.close();
    // _userStream.close();
    super.dispose();
  }
}
