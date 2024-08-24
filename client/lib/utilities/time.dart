// utilities/time.dart
String calculateTimeLeft(DateTime createdAt) {
  final now = DateTime.now();
  final endTime = createdAt.add(const Duration(hours: 24));
  final difference = endTime.difference(now);

  if (difference.isNegative) {
    return '00:00:00'; // 시간이 다 지난 경우
  } else {
    final hours = difference.inHours.toString().padLeft(2, '0');
    final minutes = (difference.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (difference.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }
}
