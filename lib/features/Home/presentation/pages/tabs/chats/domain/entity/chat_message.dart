class ChatMessage {
  final String name;
  final String lastMessage;
  final String time;
  final String? imageUrl;
  final bool isOnline;
  final bool isDeveloper;

  ChatMessage({
    required this.name,
    required this.lastMessage,
    required this.time,
    this.imageUrl,
    this.isOnline = false,
    this.isDeveloper = false,
  });
}