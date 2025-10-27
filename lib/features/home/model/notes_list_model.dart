import 'package:connectinno_task/core/global/reflector.dart';
import 'package:connectinno_task/core/global/result_model.dart';

@reflector
class NotesListModel extends BaseResultModel {
  final String? id;
  final String title;
  final String content;
  final bool isPinned;
  final String? userId;

  NotesListModel({
    required this.id,
    required this.title,
    required this.content,
    required this.isPinned,
     this.userId,
  });

  factory NotesListModel.fromJson(Map<String, dynamic> json) => NotesListModel(
    id: json["id"]?.toString() ?? '',
    title: json["title"] ?? '',
    content: json["content"] ?? '',
    isPinned: json["is_pinned"] ?? false,
    userId: json["user_id"]?.toString() ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "content": content,
    "is_pinned": isPinned,
    "user_id": userId,
  };
}
