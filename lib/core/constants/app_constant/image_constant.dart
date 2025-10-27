class ImageConstant {
  static final ImageConstant _instance = ImageConstant._init();
  static ImageConstant get instance => _instance;
  ImageConstant._init();

  final String stickNoteImage = 'assets/images/stick_note.png';
  final String cancelImage = 'assets/images/cancel.png';
  final String basicInfoImage = 'assets/images/no-results.png';
  final String checkImage = 'assets/images/check.png';

}
