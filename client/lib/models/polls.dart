import 'package:client/utilities/time.dart';

class Poll {
  final String id;
  final double price;  // 수정: double로 변경
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

  factory Poll.fromJson(Map<String, dynamic> json) {
    return Poll(
      id: json['_id'],
      price: json['price'].toDouble(),  // 수정: double로 변환하여 저장
      content: json['content'],
      thumbnail: json['thumbnail'],
      coupangUrl: json['coupangUrl'],
      likes: json['likes'],
      dislikes: json['dislikes'],
      isVoted: json['isVoted'],
      isLiked: json['isLiked'],
      isDisliked: json['isDisliked'],
      comments: (json['comments'] as List).map((comment) => Comment.fromJson(comment)).toList(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
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
