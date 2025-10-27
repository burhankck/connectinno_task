import 'package:hive/hive.dart';



@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String content;

  @HiveField(3)
  bool isPinned;
  
  @HiveField(4)
  bool isDirty; 

  Note({
    required this.id,
    required this.title,
    required this.content,
    this.isPinned = false,
    this.isDirty =false,
  });

  Note copyWith({
    String? id,
    String? title,
    String? content,
    bool? isPinned,
    bool? isDirty,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      isPinned: isPinned ?? this.isPinned,
      isDirty: isDirty ?? this.isDirty,
    );
  }
}

