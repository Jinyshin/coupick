int calculateVotePercentage(int likes, int dislikes) {
  if (likes == 0 && dislikes == 0) {
    return 0; // 투표가 없을 경우 0% 반환
  }
  return ((likes / (likes + dislikes)) * 100).round();
}
