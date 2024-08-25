class PollDetailModel {
  final String content;
  final String price;
  final String thumbnail;
  final String coupangUrl;
  final List<Reaction> reactions;

  PollDetailModel({
    required this.content,
    required this.price,
    required this.thumbnail,
    required this.coupangUrl,
    required this.reactions,
  });
}

class Reaction {
  bool isLike;
  String reactionStatement;

  Reaction({
    required this.isLike,
    required this.reactionStatement,
  });
}

// List<PollDetailModel> polls = [
//   PollDetailModel(
//     content: 'Modern T-shirt',
//     price: '₩ 18,000',
//     reactions: [
//       Reaction(isLike: true, reactionStatement: 'Really love this style!'),
//       Reaction(isLike: false, reactionStatement: 'Not my type.'),
//     ],
//   ),
//   PollDetailModel(
//     content: 'Vintage Jeans',
//     price: '₩ 25,000',
//     reactions: [
//       Reaction(isLike: true, reactionStatement: 'Fits perfectly!'),
//       Reaction(isLike: true, reactionStatement: 'Great material.'),
//     ],
//   ),
//   PollDetailModel(
//     content: 'Classic Watch',
//     price: '₩ 150,000',
//     reactions: [
//       Reaction(isLike: false, reactionStatement: 'Too expensive for me.'),
//       Reaction(isLike: true, reactionStatement: 'Looks really elegant.'),
//     ],
//   ),
//   PollDetailModel(
//     content: 'Sneakers',
//     price: '₩ 70,000',
//     reactions: [
//       Reaction(isLike: true, reactionStatement: 'Very comfortable!'),
//       Reaction(isLike: false, reactionStatement: 'Not a fan of the color.'),
//     ],
//   ),
//   PollDetailModel(
//     content: 'Leather Jacket',
//     price: '₩ 120,000',
//     reactions: [
//       Reaction(isLike: true, reactionStatement: 'Perfect for the winter!'),
//       Reaction(isLike: false, reactionStatement: 'Feels a bit heavy.'),
//     ],
//   ),
// ];
