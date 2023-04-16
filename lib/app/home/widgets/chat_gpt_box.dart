import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';

class ChatGPTBox extends StatefulWidget {
  const ChatGPTBox({super.key, required this.initialQuestion});
  final String initialQuestion;

  static Future<void> show(BuildContext context, String initialQuestion) async {
    await showModalBottomSheet(
        context: context,
        builder: (context) {
          return ChatGPTBox(initialQuestion: initialQuestion);
        });
  }

  @override
  State<ChatGPTBox> createState() => _ChatGPTBoxState();
}

class _ChatGPTBoxState extends State<ChatGPTBox> {
  ApiRepository apiRepository = ApiV1Repository();
  bool isLoading = false;
  String error = "";
  List<String> messages = [];
  void getResponse(String question) async {
    print('start');
    setState(() {
      isLoading = true;
    });
    try {
      final res = await apiRepository.generateResponseFromOpenAI(question);
      print("data => " + res);
      setState(() {
        messages = [...messages, res];
      });
    } catch (e) {
      setState(() {
        error = e.toString();
      });
      print("ERROR : " + e.toString());
    }
    setState(() {
      isLoading = false;
    });
    print('end');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getResponse(widget.initialQuestion);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (isLoading) CircularProgressIndicator(),
            if (error == '') Text(error),
            Text("Suggestion Based On Selection"),
            ListView.builder(
              itemCount: messages.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final message = messages[index];
                return Text(message);
              },
            ),
          ],
        ),
      ),
    );
  }
}
