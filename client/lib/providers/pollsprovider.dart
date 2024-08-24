import 'package:flutter/material.dart';
import 'package:client/models/polls.dart';
import 'package:client/services/getpolls_service.dart';

class PollsProvider with ChangeNotifier {
  List<Poll> _polls = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Poll> get polls => _polls;
  bool get isLoading => _isLoading;
  bool get hasError => _errorMessage != null;
  String? get errorMessage => _errorMessage;

  Poll? getPollById(String pollId) {
    try {
      return _polls.firstWhere((poll) => poll.id == pollId);
    } catch (e) {
      _errorMessage = 'Poll not found';
      return null;
    }
  }

  Future<void> fetchPolls() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final polls = await GetPollsService().getPolls();
      _polls = polls;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void updatePollReaction(String pollId, bool like, String? comment) {
    final poll = _polls.firstWhere((poll) => poll.id == pollId);

    if (like && !poll.isLiked) {
      poll.likes += 1;
      poll.isLiked = true;
      if (poll.isDisliked) {
        poll.dislikes -= 1;
        poll.isDisliked = false;
      }
    } else if (!like && !poll.isDisliked) {
      poll.dislikes += 1;
      poll.isDisliked = true;
      if (poll.isLiked) {
        poll.likes -= 1;
        poll.isLiked = false;
      }
    }

    if (comment != null && comment.isNotEmpty) {
      poll.comments.add(Comment(name: 'You', content: comment, isLiked: like));
    }

    notifyListeners();
  }
}
