class User {
  final int id;
  final String username;
  final String nom;
  final String prenom;
  final int accountType;
  final int isVerified;
  final String accessToken;

  User({
    required this.id,
    required this.username,
    required this.nom,
    required this.prenom,
    required this.accountType,
    required this.isVerified,
    required this.accessToken,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      nom: json['nom'],
      prenom: json['prenom'],
      accountType: json['accountType'],
      isVerified: json['isVerified'],
      accessToken: json['accessToken'],
    );
  }
}