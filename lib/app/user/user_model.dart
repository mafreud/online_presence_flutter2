class UserModel {
  final DateTime createdAt;
  final String id;
  final DateTime updatedAt;
  final bool isOnline;
  final int lastSeen;

  UserModel(
    this.createdAt,
    this.id,
    this.updatedAt,
    this.isOnline,
    this.lastSeen,
  );

  Map<String, dynamic> toMap() {
    return {
      'createdAt': createdAt,
      'id': id,
      'updatedAt': updatedAt,
      'isOnline': isOnline,
      'lastSeen': lastSeen,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      map['createdAt'].toDate(),
      map['id'],
      map['updatedAt'].toDate(),
      map['isOnline'],
      map['lastSeen'],
    );
  }

  factory UserModel.initialData(String userId) {
    return UserModel(
      DateTime.now(),
      userId,
      DateTime.now(),
      true,
      DateTime.now().millisecondsSinceEpoch,
    );
  }
}
