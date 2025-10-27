import 'package:connectinno_task/core/global/reflector.dart';
import 'package:connectinno_task/core/global/result_model.dart';
@reflector
class NotesAddResponseModel extends BaseResultModel {
  NotesAddResponseModel({
    this.durum,
    this.hataMesaji,
  });

  bool? durum;
  String? hataMesaji;

  factory NotesAddResponseModel.fromJson(Map<String, dynamic> json) => NotesAddResponseModel(
        durum: json["Durum"],
        hataMesaji: json["HataMesaji"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "Durum": durum,
        "HataMesaji": hataMesaji,
      };
}