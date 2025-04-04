class TaskModel {
  String? id;
  String name;
  int xp;
  bool isCompleted;

  TaskModel({
    this.id,
    required this.name,
    required this.xp,
    this.isCompleted = false,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      name: json['name'] ?? '',
      xp: json['xp'] ?? 0,
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'xp': xp,
      'isCompleted': isCompleted,
    };
  }
}
