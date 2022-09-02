class UserSelectEntity {
  final int id;
  final String default_select;
  final String select_indentity;
  final String audioPath;

  UserSelectEntity(
      {required this.id, // 1 ~ 18
      required this.default_select,
      required this.select_indentity,
      required this.audioPath});

  Map<String, dynamic> toMapping() {
    return {
      'id': id,
      'default_select': default_select,
      'select_indentity': select_indentity,
      'audioPath': audioPath
    };
  }
}
