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

  Poll getPollById(String pollId) {
    return _polls.firstWhere(
          (poll) => poll.id == pollId,
      orElse: () => Poll(
        id: '',
        price: 0,
        content: '',
        thumbnail: '',
        coupangUrl: '',
        likes: 0,
        dislikes: 0,
        isVoted: false,
        isLiked: false,
        isDisliked: false,
        comments: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
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
}
