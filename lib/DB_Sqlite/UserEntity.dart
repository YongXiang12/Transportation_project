class UserEntity {
  final int id;
  final String audioPath;
  final String audioIndentity;
  final String fileName;

  UserEntity({
    required this.id,
    required this.audioPath,
    required this.audioIndentity,
    required this.fileName,
  });

  Map<String, dynamic> toMapping() {
    return {
      'id': id,
      'audioPath': audioPath,
      'audioIndentity': audioIndentity,
      'fileName': fileName,
    };
  }
}
