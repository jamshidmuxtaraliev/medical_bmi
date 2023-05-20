import 'dart:async';
import 'package:medical_bmi/api/covidAPI.dart';
import 'package:medical_bmi/models/clinica_location_model.dart';
import 'package:medical_bmi/models/news_model.dart';
import 'package:medical_bmi/models/report_model.dart';
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

  StreamController<LoginResponse> _userStream = StreamController();
  Stream<LoginResponse> get getUserData {
    return _userStream.stream;
  }

  StreamController<List<ClinicaLocationModel>> _locationListStream = StreamController();
  Stream<List<ClinicaLocationModel>> get locationListStream {
    return _locationListStream.stream;
  }

  StreamController<bool> _sendReportStream = StreamController();

  Stream<bool> get sendReportData {
    return _sendReportStream.stream;
  }

  Stream<String> get errorData {
    return _errorStream.stream;
  }

  var progressData = false;
  var progressProjectById = false;

  List<NewsModel> newsList = [];
  List<ClinicaLocationModel> clinicaList = [];
  List<ReportModel> reportList = [];

  // List<OfferModel> offerList = [];
  // List<ProjectModel>? myProjectsList;

  void login(String username, String password) async {
    progressData = true;
    notifyListeners();
    final data = await api.login(username, password, _errorStream);
    if (data != null) {
      PrefUtils.setToken(data.token ?? "");
      // PrefUtils.setUser(data);
      _loginConfirmStream.sink.add(data);
    }
    progressData = false;
    notifyListeners();
  }

  // void getCovid() async {
  //   progressData = true;
  //   notifyListeners();
  //   final data = await api.getCovidApi( _errorStream);
  //   if (data != null) {
  //     _loginConfirmStream.sink.add(data);
  //   }
  //   progressData = false;
  //   notifyListeners();
  // }

  void updateUser(
    String username,
    String password,
    String fullname,
    String phone_number,
    String email,
    String bio,
  ) async {
    progressData = true;
    notifyListeners();
    final data = await api.updateUser(username, password, fullname, phone_number, email, bio, _errorStream);
    if (data != null) {
      // PrefUtils.setUser(data);
      _loginConfirmStream.sink.add(data);
    }
    progressData = false;
    notifyListeners();
  }

  void getUser() async {
    progressData = true;
    notifyListeners();
    final data = await api.getUser(_errorStream);
    progressData = false;
    notifyListeners();
    if (data != null) {
      _userStream.sink.add(data);
    }
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

  void getClinicLOcations() async {
    progressData = true;
    notifyListeners();
    final data = await api.getClinicLOcations(_errorStream);
    clinicaList = data;
    if (data != null) {
      _locationListStream.sink.add(data);
    }
    progressData = false;
    notifyListeners();
  }

  void getMyReports() async {
    progressData = true;
    notifyListeners();
    final data = await api.getMyReports(_errorStream);
    reportList = data;
    progressData = false;
    notifyListeners();
  }

  void sendReport(
    String title,
    String text,
    int report_id,
    String image,
  ) async {
    progressData = true;
    notifyListeners();
    final data = await api.sendReport(title, text, report_id, image, _errorStream);
    progressData = false;
    notifyListeners();
    if (data != null) {
      _sendReportStream.sink.add(data);
    }
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
