import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';
import 'package:plant_disease_application/component/tcolor.dart';

class BotScreen extends StatefulWidget {
  const BotScreen({super.key});

  @override
  State<BotScreen> createState() => _BotScreenState();
}

class _BotScreenState extends State<BotScreen> {
  final TextEditingController _userMessage = TextEditingController();

  static const apiKey = "AIzaSyB8mJpL0e2VOcMGfzCftg__tSVJFB9Om3M";

  final model = GenerativeModel(model: 'models/gemini-pro', apiKey: apiKey);
  final List<Message> _messages = [];

  // Method to send the message and get the response
  Future<void> sendMessage() async {
    final message = _userMessage.text;
    _userMessage.clear();

    setState(() {
      _messages.add(
        Message(isUser: true, message: message, date: DateTime.now()),
      );
    });

    final content = [Content.text(message)];
    try {
      final response = await model.generateContent(content);
      print("Response: ${response.text}"); // أضف طباعة لمعرفة الاستجابة
      setState(() {
        _messages.add(
          Message(
            isUser: false,
            message: response.text ?? "No response from model.",
            date: DateTime.now(),
          ),
        );
      });
    } catch (e) {
      print("Error: $e"); // طباعة الأخطاء في حال وجود مشاكل
      setState(() {
        _messages.add(
          Message(
            isUser: false,
            message: "Error: Unable to fetch response. Please check the model.",
            date: DateTime.now(),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bot')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Messages(
                  isUser: message.isUser,
                  message: message.message,
                  date: DateFormat('HH:mm').format(message.date),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
            child: Row(
              children: [
                Expanded(
                  flex: 15,
                  child: TextFormField(
                    controller: _userMessage,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 5, 75, 28),
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      label: const Text("Ask Gemini..."),
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  padding: const EdgeInsets.all(15),
                  iconSize: 30,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      Tcolor.buttonColor,
                    ),
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                    shape: WidgetStateProperty.all(const CircleBorder()),
                  ),
                  onPressed: () {
                    sendMessage();
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Messages extends StatelessWidget {
  final bool isUser;
  final String message;
  final String date;
  const Messages({
    super.key,
    required this.isUser,
    required this.message,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(
        vertical: 15,
      ).copyWith(left: isUser ? 100 : 10, right: isUser ? 10 : 100),
      decoration: BoxDecoration(
        color: isUser ? Tcolor.buttonColor : Colors.grey.shade200,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(30),
          bottomLeft: isUser ? const Radius.circular(30) : Radius.zero,
          topRight: const Radius.circular(30),
          bottomRight: isUser ? Radius.zero : const Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: TextStyle(color: isUser ? Colors.white : Colors.black),
          ),
          Text(
            date,
            style: TextStyle(color: isUser ? Colors.white : Colors.black),
          ),
        ],
      ),
    );
  }
}

class Message {
  final bool isUser;
  final String message;
  final DateTime date;

  Message({required this.isUser, required this.message, required this.date});
}
