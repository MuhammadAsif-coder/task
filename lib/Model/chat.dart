class Chat {
  final String name;
  final String body;

  Chat({
    this.name,
    this.body,
  });

  factory Chat.fromJson(Map<String, dynamic> jsondata) {
    return Chat(
      name: jsondata['title'],
      body: jsondata['body'],
    );
  }
}
