class User {
  final String email;
  final String uid;
  final String profilePictureUrl;
  final String uname;
  final String bio;
  final List followers;
  final List following;

  const User({
    required this.email,
    required this.uid,
    required this.profilePictureUrl,
    required this.uname,
    required this.bio,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> userToJson() => {
        "username": uname,
        "uid": uid,
        "email": email,
        "profilePictureUrl": profilePictureUrl,
        "bio": bio,
        "followers": followers,
        "following": following,
      };
}
