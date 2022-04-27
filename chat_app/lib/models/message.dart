enum ChatMessageType { text, audio, image, video }
enum MessageStatus { not_sent, not_view, viewed }

class ChatMessage {
  final String text;
  final ChatMessageType messageType;
  final MessageStatus messageStatus;
  final bool isSender;

  ChatMessage({
    required this.text,
    required this.messageType,
    required this.messageStatus,
    required this.isSender,
  });
}

// List demoChatMessages = [
//   ChatMessage(
//     text: "Hi Sajol",
//     messageType: ChatMessageType.text,
//     messageStatus: MessageStatus.viewed,
//     isSender: false,
//   ),
//   ChatMessage(
//     text: "Hello, How are you?",
//     messageType: ChatMessageType.text,
//     messageStatus: MessageStatus.viewed,
//     isSender: true,
//   ),
//   ChatMessage(
//     text: ".",
//     messageType: ChatMessageType.audio,
//     messageStatus: MessageStatus.viewed,
//     isSender: false,
//   ),
//   ChatMessage(
//     text: "ok",
//     messageType: ChatMessageType.video,
//     messageStatus: MessageStatus.viewed,
//     isSender: true,
//   ),
//   ChatMessage(
//     text: "Error happend",
//     messageType: ChatMessageType.text,
//     messageStatus: MessageStatus.not_sent,
//     isSender: true,
//   ),
//   ChatMessage(
//     text: "This looks great man!!",
//     messageType: ChatMessageType.text,
//     messageStatus: MessageStatus.viewed,
//     isSender: false,
//   ),
//   ChatMessage(
//     text: "Glad you like it",
//     messageType: ChatMessageType.text,
//     messageStatus: MessageStatus.not_view,
//     isSender: true,
//   ),
//   ChatMessage(
//     text: "See you later",
//     messageType: ChatMessageType.text,
//     messageStatus: MessageStatus.viewed,
//     isSender: false,
//   ),
//   ChatMessage(
//     text: "Yes. See you later",
//     messageType: ChatMessageType.text,
//     messageStatus: MessageStatus.not_view,
//     isSender: true,
//   ),
// ];
