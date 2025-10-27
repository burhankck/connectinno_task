import 'package:connectinno_task/core/global/reflector.dart';
import 'package:connectinno_task/core/global/result_model.dart';
@reflector
class DeleteResponseModel extends BaseResultModel {
    final String message;

    DeleteResponseModel({
        required this.message,
    });

    factory DeleteResponseModel.fromJson(Map<String, dynamic> json) => DeleteResponseModel(
        message: json["message"],
    );

    @override
      Map<String, dynamic> toJson() => {
        "message": message,
    };
}
