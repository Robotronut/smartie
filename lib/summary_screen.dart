import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartie/pdf_viewer_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:smartie/contact_messages.dart';
import 'package:smartie/repayment_plan.dart';
import 'package:file_picker/file_picker.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});
  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class DataItem {
  final double value;
  final String label;
  final Color color;
  DataItem(this.value, this.label, this.color);
}

class Message {
  final String text;
  Message(this.text);
}

class Contact {
  final String name;
  final Message message;
  Contact(this.name, this.message);
}

class SmartieNotification {
  final Icon icon;
  final String title;
  final String message;
  SmartieNotification(this.icon, this.title, this.message);
}

class MessageProvider with ChangeNotifier {
  List<Message> _messages = [
    Message("Hello! Please let me know how I can help you today."),
  ];

  List<Message> get messages => _messages;

  Future<void> addMessage(String text) async {
    _messages.add(Message(text));
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    _messages.add(Message("Thank you. Please tell me more."));
    notifyListeners();
  }
}

class MessageWidget extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MessageProvider(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(title: Text('Smarti&e')),
        body: Column(
          children: [
            Expanded(
              child: Consumer<MessageProvider>(
                builder: (context, messageProvider, child) {
                  return ListView.builder(
                    itemCount: messageProvider.messages.length,
                    itemBuilder: (context, index) {
                      if (index % 2 != 0) {
                        return Container(
                          padding: EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                            left: 80,
                            right: 10,
                          ),
                          child: Column(
                            children: [
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.green),
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.green,
                                ),
                                child: ListTile(
                                  title: Text(
                                    messageProvider.messages[index].text,
                                  ),
                                  textColor: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("You"),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Container(
                          padding: EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                            left: 10,
                            right: 80,
                          ),
                          child: Column(
                            children: [
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.blue,
                                ),
                                child: ListTile(
                                  title: Text(
                                    messageProvider.messages[index].text,
                                  ),
                                  textColor: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Smarti&e Bot"),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(8.0),
              child: Consumer<MessageProvider>(
                builder: (context, messageProvider, child) {
                  return Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            labelText: 'Send a message',
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          if (_controller.text.isNotEmpty) {
                            Provider.of<MessageProvider>(
                              context,
                              listen: false,
                            ).addMessage(_controller.text);
                            _controller.clear();
                          }
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StyledExpansionTile extends StatefulWidget {
  final String title;
  final List<Widget> children;
  final bool isTopLevel;

  const StyledExpansionTile({
    Key? key,
    required this.title,
    required this.children,
    this.isTopLevel = false,
  }) : super(key: key);

  @override
  State<StyledExpansionTile> createState() => _StyledExpansionTileState();
}

class _StyledExpansionTileState extends State<StyledExpansionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0),
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.transparent), // Optional
        borderRadius: BorderRadius.circular(8),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent, // Removes inner divider
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: ListTileTheme(
          dense: true,
          minVerticalPadding: 0,
          horizontalTitleGap: 0,
          contentPadding: EdgeInsets.zero,
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 0,
            ), // Inner padding
            childrenPadding: const EdgeInsets.only(
              left: 4,
              right: 4,
              bottom: 2,
            ),
            title: Text(
              widget.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight:
                    widget.isTopLevel
                        ? FontWeight.w600
                        : (_isExpanded ? FontWeight.bold : FontWeight.normal),
                color:
                    widget.isTopLevel
                        ? (_isExpanded
                            ? const Color.fromRGBO(0, 162, 233, 1)
                            : Colors.black)
                        : Colors.black,
              ),
            ),
            onExpansionChanged: (bool expanded) {
              setState(() => _isExpanded = expanded);
            },
            children: widget.children,
          ),
        ),
      ),
    );
  }
}

class SupportWidget extends StatelessWidget {
  SupportWidget({super.key});

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  double installment = 200.34 + Random().nextInt(600).toDouble();
  double totalOutstanding = 5000.56 + Random().nextInt(500).toDouble();

  DateTime now = DateTime.now();

  String get formattedDate {
    DateTime now = DateTime.now();
    return '${now.day.toString().padLeft(2, '0')}/'
        '${now.month.toString().padLeft(2, '0')}/'
        '${now.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 16.0)),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Proposed Plan',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      Padding(padding: EdgeInsets.all(8.0)),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '\$${installment.toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: const Color.fromRGBO(0, 162, 233, 1),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 36.0,
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(left: 4.0),
                                child: Text(
                                  'Installment',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                formattedDate,
                                style: TextStyle(fontSize: 16.0),
                              ),

                              Padding(padding: EdgeInsets.all(4.0)),

                              Text(
                                'Starting Date',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      Padding(padding: EdgeInsets.all(8.0)),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              height: 80,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 239, 237, 237),
                                borderRadius: BorderRadius.circular(
                                  12.0,
                                ), // Rounded corners
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Repayment Plan",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    Padding(padding: EdgeInsets.all(4.0)),

                                    Text(
                                      'Plan',
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                          255,
                                          129,
                                          129,
                                          129,
                                        ),
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          Padding(padding: EdgeInsets.all(4.0)),

                          Expanded(
                            child: Container(
                              height: 80,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 239, 237, 237),
                                borderRadius: BorderRadius.circular(
                                  12.0,
                                ), // Rounded corners
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Monthly",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    Padding(padding: EdgeInsets.all(4.0)),

                                    Text(
                                      'Frequency',
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                          255,
                                          129,
                                          129,
                                          129,
                                        ),
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      Padding(padding: EdgeInsets.all(8.0)),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              height: 80,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 239, 237, 237),
                                borderRadius: BorderRadius.circular(
                                  12.0,
                                ), // Rounded corners
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '\$${totalOutstanding.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    Padding(padding: EdgeInsets.all(4.0)),

                                    Text(
                                      'Total outstanding',
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                          255,
                                          129,
                                          129,
                                          129,
                                        ),
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          Padding(padding: EdgeInsets.all(4.0)),

                          Expanded(
                            child: Container(
                              height: 80,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 239, 237, 237),
                                borderRadius: BorderRadius.circular(
                                  12.0,
                                ), // Rounded corners
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "12",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    Padding(padding: EdgeInsets.all(4.0)),

                                    Text(
                                      'Term',
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                          255,
                                          129,
                                          129,
                                          129,
                                        ),
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      Padding(padding: EdgeInsets.all(8.0)),

                      Divider(color: Colors.grey),

                      Padding(padding: EdgeInsets.all(8.0)),

                      Text(
                        'FAQs',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      Padding(padding: EdgeInsets.all(8.0)),

                      StyledExpansionTile(
                        title: 'Budgeting',
                        isTopLevel: true,
                        children: [
                          StyledExpansionTile(
                            title: 'What counts as fixed vs flexible expenses?',
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Fixed expenses include rent, bills, subscriptions—things that are the same each month. Flexible expenses include groceries, transport, entertainment, and other spending that varies.',
                                ),
                              ),
                            ],
                          ),
                          StyledExpansionTile(
                            title: 'What is MDI?',
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'MDI stands for Monthly Disposable Income. It’s the amount left after fixed, flexible, debt, savings, and emergency fund allocations.',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      StyledExpansionTile(
                        title: 'Savings',
                        isTopLevel: true,
                        children: [
                          StyledExpansionTile(
                            title: 'How much should I save each month?',
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'A good rule of thumb is to save at least 20% of your income. This app starts by suggesting 5% for emergency savings and 5% for general savings, but you can adjust based on your goals.',
                                ),
                              ),
                            ],
                          ),
                          StyledExpansionTile(
                            title: 'What is an Emergency Fund?',
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'It’s money set aside for unexpected expenses like medical emergencies, car repairs, or job loss. This app suggests saving 5% of your income toward your emergency fund.',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      StyledExpansionTile(
                        title: 'Debt & Repayment',
                        isTopLevel: true,
                        children: [
                          StyledExpansionTile(
                            title: 'Can this app help me pay off debt?',
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Yes! You can track your debts and use the Repayment Planner tool to build a payoff strategy, whether you\'re using the Snowball or Avalanche method.',
                                ),
                              ),
                            ],
                          ),
                          StyledExpansionTile(
                            title: 'How do I track my debt payments?',
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Go to the Debt section, input your balances and monthly payments. The app will automatically deduct them from your monthly income and adjust your MDI.',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      StyledExpansionTile(
                        title: 'Privacy & Data',
                        isTopLevel: true,
                        children: [
                          StyledExpansionTile(
                            title: 'Is my data secure?',
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Yes, your financial data is stored securely and never shared with third parties without your consent. You can read more in our Privacy Policy.',
                                ),
                              ),
                            ],
                          ),
                          StyledExpansionTile(
                            title: 'Can I reset my data?',
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Absolutely. Go to Settings > Reset Data to clear all saved values and start fresh.',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      Divider(color: Colors.grey),

                      Padding(padding: EdgeInsets.all(8.0)),

                      Text(
                        'External Resources',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      Padding(padding: EdgeInsets.all(8.0)),

                      Text(
                        'Government Financial Advice',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(0, 162, 233, 1),
                        ),
                      ),

                      Padding(padding: EdgeInsets.all(2.0)),

                      Text(
                        'Trusted, government-backed advice to help you budget, save, and manage debt.',
                        style: TextStyle(fontSize: 13.0, color: Colors.grey),
                      ),

                      Padding(padding: EdgeInsets.all(2.0)),

                      StyledExpansionTile(
                        title: 'United States',
                        isTopLevel: true,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextButton(
                                onPressed:
                                    () => _launchURL(
                                      'https://www.consumerfinance.gov/consumer-tools/',
                                    ),
                                child: Text('ConsumerFinance.gov'),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 14.0),
                                child: Text(
                                  'Tools and articles from the CFPB on budgeting, dealing with debt, credit building, and more.',
                                ),
                              ),
                              TextButton(
                                onPressed:
                                    () =>
                                        _launchURL('https://www.mymoney.gov/'),
                                child: Text('MyMoney.gov'),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 14.0),
                                child: Text(
                                  'U.S. government site offering personal finance tips and resources across five key principles — earn, save, protect, spend, and borrow.',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      StyledExpansionTile(
                        title: 'Canada',
                        isTopLevel: true,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextButton(
                                onPressed:
                                    () => _launchURL(
                                      'https://www.canada.ca/en/financial-consumer-agency/programs/financial-literacy.html',
                                    ),
                                child: Text('Canada.ca - Financial Literacy'),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 14.0),
                                child: Text(
                                  'Tools and guidance from the Government of Canada for budgeting, saving, and understanding credit.',
                                ),
                              ),
                              TextButton(
                                onPressed:
                                    () => _launchURL(
                                      'https://www.canada.ca/en/services/finance/tools.html',
                                    ),
                                child: Text('FCAC Tools'),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 14.0),
                                child: Text(
                                  'Interactive tools like budget planners and mortgage calculators from the Financial Consumer Agency of Canada (FCAC).',
                                ),
                              ),
                              Padding(padding: EdgeInsets.all(2.0)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 16.0)),
            ],
          ),
        ),
      ),
    );
  }
}

class ContactsWidget extends StatelessWidget {
  List<Contact> contacts = [
    new Contact("Alice", new Message("Hey, how are you?")),
    new Contact("Rob", new Message("Thank you!")),
    new Contact(
      "Scotiabank",
      new Message("Alert: New email from Scotiabank..."),
    ),
    new Contact("Smarti&e", new Message("Need some financial advice?")),
    new Contact(
      "Debra",
      new Message("Hi, would you be able to send me the report?"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MessageProvider(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(title: Text('Messages')),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final contact = contacts[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(contact.name![0]), // First letter of the name
                    ),
                    title: Text(contact.name!),
                    subtitle: Text(contact.message.text!),
                    onTap: () {
                      // navigate to messages screen on tap
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => ContactMessages(contact: contact),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DocumentWidget extends StatelessWidget {
  // List of PDF documents (URLs or asset paths)
  final List<Map<String, String>> pdfDocuments = [
    {"title": "Void Cheque", "path": "assets/files/void_cheque.pdf"},
    {"title": "Bank Statement", "path": "assets/files/account_statement.pdf"},
    {"title": "Utility Bill", "path": "assets/files/utility-bill.pdf"},
    {"title": "ID Verification", "path": "assets/files/passport.pdf"},
    {"title": "Other", "path": "assets/files/loan_statement.pdf"},
  ];

  Future<void> chooseFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      File file = File(result.files.single.path!);
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Secure Lock Box"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            tooltip: 'Add new file',
            onPressed: () async {
              // handle the press
              await chooseFile();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: pdfDocuments.length,
        itemBuilder: (context, index) {
          final pdf = pdfDocuments[index];
          return Padding(
            padding: const EdgeInsets.only(
              bottom: 14.0,
              left: 18.0,
              right: 18.0,
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => PdfViewerScreen(pdfPath: pdf["path"]!),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.picture_as_pdf,
                    size: 30.0,
                    color: const Color.fromRGBO(0, 162, 233, 1),
                  ),
                  SizedBox(width: 16.0), // Space between icon and text
                  Text(
                    pdf["title"]!,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: const Color.fromRGBO(0, 162, 233, 1),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SummaryScreenState extends State<SummaryScreen> {
  final TextEditingController _creditorController = TextEditingController();
  String? _selectedCreditor;
  String selectedValue = 'Monthly';
  int currentPageIndex = 0;
  OverlayEntry? _overlayEntry;

  void showCustomPopup(BuildContext context, String title, String message) {
    //final overlay = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder:
          (context) => Positioned(
            top: MediaQuery.of(context).size.height * 0.125,
            left: MediaQuery.of(context).size.width * 0.1,
            right: MediaQuery.of(context).size.width * 0.1,
            child: Material(
              elevation: 8.0,
              borderRadius: BorderRadius.circular(8.0),
              shadowColor: Colors.black,
              child: Container(
                padding: EdgeInsets.all(16.0),
                color: Colors.white,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Icon(Icons.check_circle),
                          Padding(padding: EdgeInsets.only(left: 10.0)),
                          Text(
                            title,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        message,
                        style: TextStyle(color: Colors.grey, fontSize: 14.0),
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          _overlayEntry?.remove();
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            214,
                            238,
                            249,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text(
                          "Dismiss",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromRGBO(0, 162, 233, 1),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );

    Overlay.of(context).insert(_overlayEntry!);

    // Remove the popup after 5 seconds if user does not dismiss
    Future.delayed(Duration(seconds: 5), () {
      _overlayEntry?.remove();
    });
  }

  final List<DataItem> summary_dataset = [
    DataItem(0.43, 'Income', Colors.pink),
    DataItem(0.15, 'Fixed', Colors.orange),
    DataItem(0.08, 'Flexible', Colors.green),
    DataItem(0.18, 'Debt', Colors.blue),
    DataItem(0.05, 'MDI', Colors.deepPurple),
    DataItem(0.05, 'Emergency Fund', Colors.deepOrange),
    DataItem(0.06, 'Savings', Colors.lime),
  ];

  List<DropdownMenuEntry<String>> entries() {
    var entries = <DropdownMenuEntry<String>>[];
    entries.add(const DropdownMenuEntry(value: "RBC", label: "RBC"));
    entries.add(const DropdownMenuEntry(value: "TD", label: "TD"));
    entries.add(
      const DropdownMenuEntry(value: "Scotiabank", label: "Scotiabank"),
    );
    entries.add(const DropdownMenuEntry(value: "BMO", label: "BMO"));
    entries.add(const DropdownMenuEntry(value: "CIBC", label: "CIBC"));
    entries.add(const DropdownMenuEntry(value: "HSBC", label: "HSBC"));
    entries.add(
      const DropdownMenuEntry(value: "Laurentian", label: "Laurentian"),
    );
    entries.add(
      const DropdownMenuEntry(
        value: "National Bank of Canada",
        label: "National Bank of Canada",
      ),
    );
    entries.add(
      const DropdownMenuEntry(value: "ATB Financial", label: "ATB Financial"),
    );
    return entries;
  }

  int income = 0;
  int fixedExp = 0;
  int flexExp = 0;
  int debt = 0;
  double mdi = 0;
  double savings = 0;
  double emergencyFund = 0;
  final rand = Random();

  bool _isChecked = false;

  final GlobalKey _bellIconKey = GlobalKey();
  OverlayEntry? _overlayEntry2;

  // test notifications
   final List<SmartieNotification> _notifications = [
    SmartieNotification(Icon(Icons.money),"You're Making Progress!", "You've just paid off \$100 — that’s one more step toward your financial freedom. Keep going, you're doing great!"),
    SmartieNotification(Icon(Icons.celebration),"We See You. We Celebrate You.", "Paying down debt takes courage. You’re building confidence, one payment at a time. You've got this."),
    SmartieNotification(Icon(Icons.rocket_launch),"Milestone Unlocked!", "You've hit your halfway mark — 50% of your goal is complete. Take a moment to be proud."),
    SmartieNotification(Icon(Icons.question_mark),"Did You Know?", "Paying off just an extra \$20/month can save you hundreds in interest. You’re making smart moves already."),
  ];

  void _showNotificationsPopup() {
    if (_overlayEntry2 != null) {
      _removeNotificationsPopup();
      return;
    }

    final RenderBox renderBox =
        _bellIconKey.currentContext!.findRenderObject() as RenderBox;
    final Offset position = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    _overlayEntry2 = OverlayEntry(
      builder:
          (context) => Positioned(
            top: position.dy + size.height,
            right: MediaQuery.of(context).size.width - position.dx - size.width,
            child: Material(
              elevation: 4.0,
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                width: 250,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 8.0, top: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(8.0),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "My Notifications",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Scrollbar(
                        trackVisibility: true,
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: _notifications.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(_notifications[index].title, maxLines: 2,),
                              leading: _notifications[index].icon,
                              onTap: () {
                                print("Clicked on: ${_notifications[index]}");
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );

    Overlay.of(context).insert(_overlayEntry2!);
  }

  void _removeNotificationsPopup() {
    _overlayEntry2?.remove();
    _overlayEntry2 = null;
  }

  @override
  void initState() {
    super.initState();
    income = 12000 + rand.nextInt(2000);
    fixedExp = 1200 + rand.nextInt(1000);
    flexExp = 300 + rand.nextInt(400);
    debt = 100 + rand.nextInt(300);
    emergencyFund = 0.05 * income;
    savings = 0.05 * (income - emergencyFund);
    mdi = income - (fixedExp + flexExp + debt + savings + emergencyFund);

    // For chart percentages
    List<double> rawValues = List.generate(7, (_) => rand.nextDouble());
    double total = rawValues.reduce((a, b) => a + b);
    List<double> normalized = rawValues.map((v) => v / total).toList();

    summary_dataset[0] = DataItem(normalized[0], 'Income', Colors.pink);
    summary_dataset[1] = DataItem(normalized[1], 'Fixed', Colors.orange);
    summary_dataset[2] = DataItem(normalized[2], 'Flexible', Colors.green);
    summary_dataset[3] = DataItem(normalized[3], 'Debt', Colors.blue);
    summary_dataset[4] = DataItem(normalized[4], 'MDI', Colors.deepPurple);
    summary_dataset[5] = DataItem(
      normalized[5],
      'Emergency Fund',
      Colors.deepOrange,
    );
    summary_dataset[6] = DataItem(normalized[6], 'Savings', Colors.lime);
  }

  void _generateRandomValues() {
    setState(() {
      income = 12000 + rand.nextInt(2000);
      fixedExp = 1000 + rand.nextInt(1000);
      flexExp = 300 + rand.nextInt(400);
      debt = 100 + rand.nextInt(500);
      emergencyFund = 0.05 * income;
      savings = 0.05 * (income - emergencyFund);
      mdi = income - (fixedExp + flexExp + debt + savings + emergencyFund);

      // For chart percentages
      List<double> rawValues = List.generate(7, (_) => rand.nextDouble());
      double total = rawValues.reduce((a, b) => a + b);
      List<double> normalized = rawValues.map((v) => v / total).toList();

      summary_dataset[0] = DataItem(normalized[0], 'Income', Colors.pink);
      summary_dataset[1] = DataItem(normalized[1], 'Fixed', Colors.orange);
      summary_dataset[2] = DataItem(normalized[2], 'Flexible', Colors.green);
      summary_dataset[3] = DataItem(normalized[3], 'Debt', Colors.blue);
      summary_dataset[4] = DataItem(normalized[4], 'MDI', Colors.deepPurple);
      summary_dataset[5] = DataItem(
        normalized[5],
        'Emergency Fund',
        Colors.deepOrange,
      );
      summary_dataset[6] = DataItem(normalized[6], 'Savings', Colors.lime);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(1, 0, 72, 1),
        leading: Padding(
          padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 20.0),
          child: Container(
            padding: EdgeInsets.all(10.0),
            width: 2,
            height: 2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Image.asset(
              'assets/images/smartie-app_icon_1024.png',
              // width: 10,
              // height: 10,
            ),
          ),
        ),
        title: RichText(
          text: TextSpan(
            style: const TextStyle(fontSize: 18.0, color: Colors.white),
            children: <TextSpan>[
              TextSpan(text: 'Morning, '),
              TextSpan(
                text: 'Michael',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: '!'),
            ],
          ),
        ),
        actions: [
          IconButton(
            key: _bellIconKey,
            onPressed: _showNotificationsPopup,
            icon: Icon(Icons.notifications_none_rounded, color: Colors.white),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: WidgetStateProperty.all(
            TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03),
          ),
        ),
        child: NavigationBar(
          destinations: [
            NavigationDestination(icon: Icon(Icons.grid_view), label: "Home"),
            NavigationDestination(
              icon: Icon(Icons.comment_outlined),
              label: "Messages",
            ),
            NavigationDestination(
              icon: Icon(Icons.sentiment_very_satisfied_outlined),
              label: "SMARTI&E",
            ),
            NavigationDestination(
              icon: Icon(Icons.task_outlined),
              label: "Document",
            ),
            NavigationDestination(
              icon: Icon(Icons.help_outline_rounded),
              label: "Support",
            ),
          ],
          selectedIndex: currentPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
            _removeNotificationsPopup();
          },
          indicatorColor: const Color.fromARGB(255, 204, 227, 246),
          backgroundColor: Colors.white,
          // labelBehavior: onlyShowSelected,
          // animationDuration: Duration(ms: 1000),
        ),
      ),
      body:
          <Widget>[
            Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.all(8.0)),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 8.0,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'My Summary',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.info_outline_rounded,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 2.0, bottom: 16.0),
                              child: DropdownMenu(
                                initialSelection: selectedValue,
                                dropdownMenuEntries:
                                    <DropdownMenuEntry<String>>[
                                      DropdownMenuEntry(
                                        value: 'Monthly',
                                        label: 'Monthly',
                                      ),
                                      DropdownMenuEntry(
                                        value: 'Quarterly',
                                        label: 'Quarterly',
                                      ),
                                      DropdownMenuEntry(
                                        value: 'Yearly',
                                        label: 'Yearly',
                                      ),
                                    ],
                                onSelected: (value) {
                                  setState(() {
                                    selectedValue =
                                        value!; // Update the state when a selection is made
                                    _generateRandomValues();
                                  });
                                },
                              ),
                            ),

                            TextButton(
                              style: TextButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.06,
                                ),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () {},
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Income',
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                          0.04,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '\$$income',
                                        style: TextStyle(
                                          fontSize:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.04,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                          decorationThickness: 2.0,
                                        ),
                                      ),
                                      Icon(
                                        Icons.chevron_right_rounded,
                                        color: Color.fromRGBO(0, 162, 233, 1),
                                        size: 24.0,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            Padding(padding: EdgeInsets.only(top: 1.0)),

                            TextButton(
                              style: TextButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.06,
                                ),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () {},
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Fixed Exp',
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                          0.04,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '\$$fixedExp',
                                        style: TextStyle(
                                          fontSize:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.04,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                          decorationThickness: 2.0,
                                        ),
                                      ),
                                      Icon(
                                        Icons.chevron_right_rounded,
                                        color: Color.fromRGBO(0, 162, 233, 1),
                                        size: 24.0,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            Padding(padding: EdgeInsets.only(top: 1.0)),

                            TextButton(
                              style: TextButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.06,
                                ),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () {},
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Flex Exp',
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                          0.04,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '\$$flexExp',
                                        style: TextStyle(
                                          fontSize:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.04,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                          decorationThickness: 2.0,
                                        ),
                                      ),
                                      Icon(
                                        Icons.chevron_right_rounded,
                                        color: Color.fromRGBO(0, 162, 233, 1),
                                        size: 24.0,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            Padding(padding: EdgeInsets.only(top: 1.0)),

                            TextButton(
                              style: TextButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.06,
                                ),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () {},
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Debt',
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                          0.04,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '\$$debt',
                                        style: TextStyle(
                                          fontSize:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.04,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                          decorationThickness: 2.0,
                                        ),
                                      ),
                                      Icon(
                                        Icons.chevron_right_rounded,
                                        color: Color.fromRGBO(0, 162, 233, 1),
                                        size: 24.0,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            Padding(padding: EdgeInsets.only(top: 1.0)),

                            TextButton(
                              style: TextButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.06,
                                ),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () {},
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'MDI',
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                          0.04,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '\$${mdi.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.04,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                          decorationThickness: 2.0,
                                        ),
                                      ),
                                      Icon(
                                        Icons.chevron_right_rounded,
                                        color: Color.fromRGBO(0, 162, 233, 1),
                                        size: 24.0,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            Padding(padding: EdgeInsets.only(top: 1.0)),

                            TextButton(
                              style: TextButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.06,
                                ),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () {},
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Savings',
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                          0.04,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '\$${savings.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.04,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                          decorationThickness: 2.0,
                                        ),
                                      ),
                                      Icon(
                                        Icons.chevron_right_rounded,
                                        color: Color.fromRGBO(0, 162, 233, 1),
                                        size: 24.0,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            Padding(padding: EdgeInsets.only(top: 1.0)),

                            TextButton(
                              style: TextButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.06,
                                ),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () {},
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Emergency Fund',
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                          0.04,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '\$${emergencyFund.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.04,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                          decorationThickness: 2.0,
                                        ),
                                      ),
                                      Icon(
                                        Icons.chevron_right_rounded,
                                        color: Color.fromRGBO(0, 162, 233, 1),
                                        size: 24.0,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            Divider(color: Colors.grey),

                            Text(
                              'SMARTI&E Summary',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            Padding(padding: EdgeInsets.only(top: 4.0)),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DonutChartWidget(summary_dataset),

                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 8.0,
                                    children: [
                                      SizedBox(
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 20.0,
                                              height: 8.0,
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  color: Colors.pink,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        4.0,
                                                      ),
                                                ),
                                              ),
                                            ),

                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 8.0,
                                              ),
                                            ),

                                            Text(
                                              'Income',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),

                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 4.0,
                                              ),
                                            ),

                                            Text(
                                              '(${(summary_dataset[0].value * 100).toInt()}%)',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 20.0,
                                              height: 8.0,
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  color: Colors.orange,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        4.0,
                                                      ),
                                                ),
                                              ),
                                            ),

                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 8.0,
                                              ),
                                            ),

                                            Text(
                                              'Fixed',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),

                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 4.0,
                                              ),
                                            ),

                                            Text(
                                              '(${(summary_dataset[1].value * 100).toInt()}%)',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 20.0,
                                              height: 8.0,
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        4.0,
                                                      ),
                                                ),
                                              ),
                                            ),

                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 8.0,
                                              ),
                                            ),

                                            Text(
                                              'Flexible',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),

                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 4.0,
                                              ),
                                            ),

                                            Text(
                                              '(${(summary_dataset[2].value * 100).toInt()}%)',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 20.0,
                                              height: 8.0,
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        4.0,
                                                      ),
                                                ),
                                              ),
                                            ),

                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 8.0,
                                              ),
                                            ),

                                            Text(
                                              'Debt',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),

                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 4.0,
                                              ),
                                            ),

                                            Text(
                                              '(${(summary_dataset[3].value * 100).toInt()}%)',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 20.0,
                                              height: 8.0,
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  color: Colors.deepPurple,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        4.0,
                                                      ),
                                                ),
                                              ),
                                            ),

                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 8.0,
                                              ),
                                            ),

                                            Text(
                                              'MDI',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),

                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 4.0,
                                              ),
                                            ),

                                            Text(
                                              '(${(summary_dataset[4].value * 100).toInt()}%)',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 20.0,
                                              height: 8.0,
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  color: Colors.deepOrange,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        4.0,
                                                      ),
                                                ),
                                              ),
                                            ),

                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 8.0,
                                              ),
                                            ),

                                            Text(
                                              'EF',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),

                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 4.0,
                                              ),
                                            ),

                                            Text(
                                              '(${(summary_dataset[4].value * 100).toInt()}%)',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 20.0,
                                              height: 8.0,
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  color: Colors.lime,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        4.0,
                                                      ),
                                                ),
                                              ),
                                            ),

                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 8.0,
                                              ),
                                            ),

                                            Text(
                                              'Savings',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),

                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 4.0,
                                              ),
                                            ),

                                            Text(
                                              '(${(summary_dataset[6].value * 100).toInt()}%)',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            Padding(padding: EdgeInsets.only(top: 4.0)),

                            Divider(color: Colors.grey),

                            Text(
                              'Share Your SMARTIE Report',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            Padding(padding: EdgeInsets.all(2.0)),

                            Text(
                              'Share the creditor you\'d like to share your SMARTIE report with. This list has been automatically populated based on your connected accounts.',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                            ),

                            Padding(padding: EdgeInsets.only(top: 2.0)),

                            DropdownMenu<String>(
                              controller: _creditorController,
                              enableFilter: true,
                              width: MediaQuery.of(context).size.width,
                              requestFocusOnTap: true,
                              label: const Text('Choose a Creditor'),
                              dropdownMenuEntries: entries(),
                              onSelected: (value) {
                                setState(() {
                                  _selectedCreditor = value;
                                  _isChecked = true;
                                });
                              },
                            ),

                            Padding(padding: EdgeInsets.all(2.0)),

                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  _selectedCreditor == null
                                      ? ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text('Select a creditor.'),
                                          backgroundColor: Colors.red,
                                        ),
                                      )
                                      : {};
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      _isChecked
                                          ? const Color.fromRGBO(0, 162, 233, 1)
                                          : Colors.grey,
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: Text(
                                  'Share SMARTIE Report',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),

                            SizedBox(
                              width: double.infinity,
                              child: FilledButton(
                                onPressed: () {},
                                style: FilledButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(
                                    255,
                                    214,
                                    238,
                                    249,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                child: Text(
                                  "Apply for Credit",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: const Color.fromRGBO(0, 162, 233, 1),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(
                              width: double.infinity,
                              child: FilledButton(
                                onPressed: () {
                                  showCustomPopup(
                                    context,
                                    "Milestone Unlocked!",
                                    "You've hit your halfway mark — 50% of your goal is complete. Take a moment to be proud.",
                                  );
                                },
                                style: FilledButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(
                                    255,
                                    214,
                                    238,
                                    249,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                child: Text(
                                  "Apply for Benefits",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: const Color.fromRGBO(0, 162, 233, 1),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(
                              width: double.infinity,
                              child: FilledButton(
                                onPressed: () {},
                                style: FilledButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(
                                    255,
                                    214,
                                    238,
                                    249,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                child: Text(
                                  "Find Debt Advice",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: const Color.fromRGBO(0, 162, 233, 1),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(
                              width: double.infinity,
                              child: FilledButton(
                                onPressed: () {},
                                style: FilledButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(
                                    255,
                                    214,
                                    238,
                                    249,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                child: Text(
                                  "Apply for LEAP, OESB, etc.",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: const Color.fromRGBO(0, 162, 233, 1),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Padding(padding: EdgeInsets.all(8.0)),
                  ],
                ),
              ),
            ),

            Center(child: ContactsWidget()),

            Center(child: MessageWidget()),

            Center(child: DocumentWidget()),

            Center(child: SupportWidget()),
          ][currentPageIndex],
    );
  }
}

class DonutChartWidget extends StatefulWidget {
  final List<DataItem> summary_dataset;
  DonutChartWidget(this.summary_dataset);

  @override
  _DonutChartWidgetState createState() => _DonutChartWidgetState();
}

class _DonutChartWidgetState extends State<DonutChartWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      // height: 150.0,
      child: CustomPaint(
        child: Container(),
        painter: DonutChartPainter(widget.summary_dataset),
      ),
    );
  }
}

class DonutChartPainter extends CustomPainter {
  final List<DataItem> dataset;
  DonutChartPainter(this.dataset);

  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2.0, size.height / 2.0);
    final radius = size.width * 0.9;
    final rect = Rect.fromCenter(center: c, width: radius, height: radius);
    var startAngle = 0.0;
    final midPaint =
        Paint()
          ..style = PaintingStyle.fill
          ..color = Colors.white;
    for (var di in dataset) {
      final sweepAngle = di.value * 360.0 * pi / 180.0;
      final paint =
          Paint()
            ..style = PaintingStyle.fill
            ..color = di.color;
      canvas.drawArc(rect, startAngle, sweepAngle, true, paint);
      startAngle += sweepAngle;
    }
    canvas.drawCircle(c, radius * 0.35, midPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
