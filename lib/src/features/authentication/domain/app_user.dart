class AppUser {
  const AppUser({
    required this.uid,
    required this.name,
  });
  final String uid;
  final String name;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppUser && other.uid == uid && other.name == name;
  }

  @override
  int get hashCode => uid.hashCode ^ name.hashCode;

  @override
  String toString() => 'AppUser(uid: $uid, name: $name)';
}
