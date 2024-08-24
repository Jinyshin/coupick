import 'package:flutter/cupertino.dart';

class PollDetailModel {
  final String title;
  final String price;
  final String city;
  final List<Reaction> reactions;

  PollDetailModel({
    required this.title,
    required this.price,
    required this.city,
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

List<PollDetailModel> polls = [
  PollDetailModel(
    title: 'Modern T-shirt',
    price: '₩ 18,000',
    city: 'Seoul',
    reactions: [
      Reaction(isLike: true, reactionStatement: 'Really love this style!'),
      Reaction(isLike: false, reactionStatement: 'Not my type.'),
    ],
  ),
  PollDetailModel(
    title: 'Vintage Jeans',
    price: '₩ 25,000',
    city: 'Busan',
    reactions: [
      Reaction(isLike: true, reactionStatement: 'Fits perfectly!'),
      Reaction(isLike: true, reactionStatement: 'Great material.'),
    ],
  ),
  PollDetailModel(
    title: 'Classic Watch',
    price: '₩ 150,000',
    city: 'Incheon',
    reactions: [
      Reaction(isLike: false, reactionStatement: 'Too expensive for me.'),
      Reaction(isLike: true, reactionStatement: 'Looks really elegant.'),
    ],
  ),
  PollDetailModel(
    title: 'Sneakers',
    price: '₩ 70,000',
    city: 'Daegu',
    reactions: [
      Reaction(isLike: true, reactionStatement: 'Very comfortable!'),
      Reaction(isLike: false, reactionStatement: 'Not a fan of the color.'),
    ],
  ),
  PollDetailModel(
    title: 'Leather Jacket',
    price: '₩ 120,000',
    city: 'Jeju',
    reactions: [
      Reaction(isLike: true, reactionStatement: 'Perfect for the winter!'),
      Reaction(isLike: false, reactionStatement: 'Feels a bit heavy.'),
    ],
  ),
];
