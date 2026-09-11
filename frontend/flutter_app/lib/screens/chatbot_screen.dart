import 'package:flutter/material.dart';
import '../models/medicine.dart';
import '../theme/app_theme.dart';

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}

class ChatbotScreen extends StatefulWidget {
  final Medicine? medicine;
  final String? initialQuestion;

  const ChatbotScreen({Key? key, this.medicine, this.initialQuestion}) : super(key: key);

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  late Medicine _med;

  final List<String> _suggestedQuestions = [
    'What is the active ingredient?',
    'Why is my batch showing attention required?',
    'What does duplicate active ingredient mean?',
    'Explain my scan result.',
    'Can I take this medicine now?',
  ];

  @override
  void initState() {
    super.initState();
    _med = widget.medicine ?? Medicine.sampleGlycomet();

    // Initial greeting
    _messages.add(
      ChatMessage(
        text:
            'Hello! I am your MediCheck AI Assistant. I can help explain the extracted packaging details, active ingredients, and verification flags for ${_med.name}.',
        isUser: false,
      ),
    );

    _messages.add(
      ChatMessage(
        text:
            'The scanned medicine contains ${_med.activeIngredient} as its active ingredient. Your medication profile already contains Metformin, so the system has flagged a potential duplicate active ingredient. Please confirm with a doctor or pharmacist.',
        isUser: false,
      ),
    );

    if (widget.initialQuestion != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _handleSendMessage(widget.initialQuestion!);
      });
    }
  }

  void _handleSendMessage(String question) {
    if (question.trim().isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(text: question, isUser: true));
    });
    _inputController.clear();
    _scrollToBottom();

    // Response with strict guardrails
    Future.delayed(const Duration(milliseconds: 400), () {
      final response = _generateGuardrailedResponse(question);
      setState(() {
        _messages.add(ChatMessage(text: response, isUser: false));
      });
      _scrollToBottom();
    });
  }

  String _generateGuardrailedResponse(String question) {
    final q = question.toLowerCase();

    // Guardrail: No prescribing or advising consumption
    if (q.contains('can i take') || q.contains('should i take') || q.contains('cure') || q.contains('diagnose')) {
      return 'As an informational decision-support assistant, MediCheck AI does not prescribe medicines or advise whether to take any product. Please consult your physician or licensed pharmacist for medical guidance.';
    }

    // Guardrail: No counterfeit / genuine claims
    if (q.contains('fake') || q.contains('genuine') || q.contains('real') || q.contains('counterfeit')) {
      return 'MediCheck AI does not declare products as genuine or fake. The system compares extracted text against available reference records. An unverified batch simply indicates the batch is not found in our reference dataset, and professional review is recommended.';
    }

    // Active ingredient query
    if (q.contains('active ingredient') || q.contains('ingredient')) {
      return 'The active ingredient in ${_med.name} is "${_med.activeIngredient}" with a declared strength of ${_med.strength}. Active ingredients are the biologically active substances responsible for the pharmaceutical effect.';
    }

    // Attention required / batch query
    if (q.contains('attention required') || q.contains('batch')) {
      return 'The system flagged "Attention Required" because batch "${_med.batchNumber}" could not be matched against our current reference dataset. This does not prove the medicine is counterfeit; the reference database may not yet contain this batch record.';
    }

    // Duplicate active ingredient query
    if (q.contains('duplicate') || q.contains('double')) {
      return 'A "Potential Duplicate Active Ingredient" occurs when the scanned package contains an active pharmaceutical ingredient (such as ${_med.activeIngredient}) that is already logged in your personal medication profile. Taking both simultaneously may cause duplicate dosing. Always check with your doctor.';
    }

    // Explain scan result
    if (q.contains('explain') || q.contains('result')) {
      return 'Your scan of ${_med.name} showed 4 out of 5 checks matched against reference specifications (Name, Strength, Manufacturer, Expiry Date). Only the batch number requires attention as it was not matched in the current reference database.';
    }

    return 'MediCheck AI extracted: Name: ${_med.name}, Active Ingredient: ${_med.activeIngredient}, Batch: ${_med.batchNumber}, Expiry: ${_med.expDate}. Always consult a healthcare professional for clinical decisions.';
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('MediCheck AI Assistant', style: TextStyle(fontSize: 15)),
            Text('Discussing: ${_med.name}', style: const TextStyle(fontSize: 11, color: AppColors.slate500)),
          ],
        ),
      ),
      body: Column(
        children: [
          // Guardrail Banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: AppColors.slate100,
            child: const Text(
              'Informational assistant only. Does not diagnose, prescribe, or certify authenticity.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10.5, color: AppColors.slate600),
            ),
          ),

          // Message Thread
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return Align(
                  alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
                    decoration: BoxDecoration(
                      color: msg.isUser ? AppColors.primaryBlue : Colors.white,
                      borderRadius: BorderRadius.circular(16).copyWith(
                        bottomRight: msg.isUser ? const Radius.circular(2) : const Radius.circular(16),
                        bottomLeft: !msg.isUser ? const Radius.circular(2) : const Radius.circular(16),
                      ),
                      border: msg.isUser ? null : Border.all(color: AppColors.slate200),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      msg.text,
                      style: TextStyle(
                        fontSize: 13,
                        color: msg.isUser ? Colors.white : AppColors.slate900,
                        height: 1.4,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Suggested Questions Chips
          Container(
            height: 42,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            color: Colors.white,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: _suggestedQuestions.map((q) {
                return Padding(
                  padding: const EdgeInsets.only(right: 6.0),
                  child: ActionChip(
                    label: Text(q, style: const TextStyle(fontSize: 11)),
                    backgroundColor: AppColors.slate50,
                    side: const BorderSide(color: AppColors.slate200),
                    onPressed: () => _handleSendMessage(q),
                  ),
                );
              }).toList(),
            ),
          ),

          // Input Bar
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _inputController,
                    decoration: const InputDecoration(
                      hintText: 'Ask about this medicine scan...',
                      isDense: true,
                    ),
                    onSubmitted: _handleSendMessage,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send_rounded, color: AppColors.primaryBlue),
                  onPressed: () => _handleSendMessage(_inputController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
