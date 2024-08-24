class Poll {
  final String id;
  final int price;
  final String content;
  final String thumbnail;
  final String coupangUrl;
  int likes;
  int dislikes;
  bool isVoted;
  bool isLiked;
  bool isDisliked;
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

  factory Poll.fromJson(Map<String, dynamic> json) {
    try {
      return Poll(
        id: json['_id'] as String,
        price: json['price'] as int,
        content: json['content'] as String,
        thumbnail: json['thumbnail'] as String,
        coupangUrl: json['coupangUrl'] as String,
        likes: json['likes'] as int,
        dislikes: json['dislikes'] as int,
        isVoted: json['isVoted'] as bool ?? false,
        isLiked: json['isLiked'] as bool ?? false,
        isDisliked: json['isDisliked'] as bool ?? false,
        comments: (json['comments'] as List<dynamic>)
            .map((item) => Comment.fromJson(item as Map<String, dynamic>))
            .toList(),
        createdAt: DateTime.parse(json['createdAt'] as String),
        updatedAt: DateTime.parse(json['updatedAt'] as String),
      );
    } catch (e) {
      print('Failed to parse poll data: $e');
      print('JSON data: $json');
      throw Exception('Failed to parse poll data');
    }
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
