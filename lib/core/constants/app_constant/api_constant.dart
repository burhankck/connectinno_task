class ApiConstant {
  static final ApiConstant _instance = ApiConstant._init();
  static ApiConstant get instance => _instance;
  ApiConstant._init();

  static const String baseUrl = "http://10.0.2.2:8000/";

  static const String getListNotesEndPoint = "notes";
  static const String addNotesEndPoint = "notes";
  static const String updateNotesEndPoint = "notes";
  static const String deleteNotesEndPoint = "notes";
}
