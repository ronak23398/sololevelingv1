class UserModel {
  String? id;
  String? name;
  String? email;
  int level;
  int xp;
  List<String> completedTasks;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.level = 1,
    this.xp = 0,
    this.completedTasks = const [],
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      level: json['level'] ?? 1,
      xp: json['xp'] ?? 0,
      completedTasks: json['completed_tasks'] != null
          ? List<String>.from(json['completed_tasks'])
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'level': level,
      'xp': xp,
      'completed_tasks': completedTasks,
    };
  }
}
