import 'package:client/utilities/time.dart';

class Poll {
  final String id;
  final String price;
  final String content;
  final String thumbnail;
  final String coupangUrl;
  final int likes;
  final int dislikes;
  final bool isVoted;
  final bool isLiked;
  final bool isDisliked;
  final List<Comment> comments;
  final DateTime createdAt;
  final DateTime updatedAt;

  Poll({
    required this.id,
    required this.price,
    required this.content,
    required this.thumbnail,
    required this.coupangUrl,
    required this.likes,
    required this.dislikes,
    required this.isVoted,
    required this.isLiked,
    required this.isDisliked,
    required this.comments,
    required this.createdAt,
    required this.updatedAt,
  });

  String get timeLeft => calculateTimeLeft(createdAt);
}

class Comment {
  final String name;
  final String content;

  Comment({
    required this.name,
    required this.content,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      name: json['name'] as String,
      content: json['content'] as String,
    );
  }
}
