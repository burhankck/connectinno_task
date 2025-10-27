import 'package:connectinno_task/core/global/reflector.dart';
import 'package:connectinno_task/core/global/result_model.dart';
@reflector
class NotesAddRequestModel  extends BaseResultModel{
    final String title;
    final String content;
    final bool isPinned;

    NotesAddRequestModel({
        required this.title,
        required this.content,
         this.isPinned =false,
    });

    factory NotesAddRequestModel.fromJson(Map<String, dynamic> json) => NotesAddRequestModel(
        title: json["title"],
        content: json["content"],
        isPinned: json["is_pinned"],
    );

    @override
      Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
        "is_pinned": isPinned,
    };
}
