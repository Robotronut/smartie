import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        appBar: AppBar(title: Text('Messages')),
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
                          child: ListTile(
                            title: Text(messageProvider.messages[index].text),
                            textColor: Colors.white,
                            tileColor: Colors.green,
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
                          child: ListTile(
                            title: Text(messageProvider.messages[index].text),
                            textColor: Colors.white,
                            tileColor: Colors.blue,
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ),
            Padding(
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

class _SummaryScreenState extends State<SummaryScreen> {
  final TextEditingController _creditorController = TextEditingController();

  String? _selectedCreditor;
  String selectedValue = 'Monthly';
  int currentPageIndex = 0;

  final List<DataItem> summary_dataset = [
    DataItem(0.43, 'Income', Colors.pink),
    DataItem(0.15, 'Fixed', Colors.orange),
    DataItem(0.08, 'Flexible', Colors.green),
    DataItem(0.18, 'Debt', Colors.blue),
    DataItem(0.16, 'MDI', Colors.deepPurple),
  ];

  DateTime now = DateTime.now();
  String get formattedDate {
    DateTime now = DateTime.now();
    return '${now.day.toString().padLeft(2, '0')}/'
        '${now.month.toString().padLeft(2, '0')}/'
        '${now.year}';
  }

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
  int mdi = 0;
  int installment = 0;
  int total_outstanding = 0;
  final rand = Random();

  @override
  void initState() {
    super.initState();
    income = 2500 + rand.nextInt(2000);
    fixedExp = 1200 + rand.nextInt(1000);
    flexExp = 300 + rand.nextInt(400);
    debt = 100 + rand.nextInt(300);
    mdi = 200 + rand.nextInt(600);
    installment = 200 + rand.nextInt(600);
    total_outstanding = 5000 + rand.nextInt(500);

    // For chart percentages
    List<double> rawValues = List.generate(5, (_) => rand.nextDouble());
    double total = rawValues.reduce((a, b) => a + b);
    List<double> normalized = rawValues.map((v) => v / total).toList();

    summary_dataset[0] = DataItem(normalized[0], 'Income', Colors.pink);
    summary_dataset[1] = DataItem(normalized[1], 'Fixed', Colors.orange);
    summary_dataset[2] = DataItem(normalized[2], 'Flexible', Colors.green);
    summary_dataset[3] = DataItem(normalized[3], 'Debt', Colors.blue);
    summary_dataset[4] = DataItem(normalized[4], 'MDI', Colors.deepPurple);
  }

  void _generateRandomValues() {
    setState(() {
      income = 2500 + rand.nextInt(2000);
      fixedExp = 1000 + rand.nextInt(1000);
      flexExp = 300 + rand.nextInt(400);
      debt = 100 + rand.nextInt(500);
      mdi = 200 + rand.nextInt(600);

      // For chart percentages
      List<double> rawValues = List.generate(5, (_) => rand.nextDouble());
      double total = rawValues.reduce((a, b) => a + b);
      List<double> normalized = rawValues.map((v) => v / total).toList();

      summary_dataset[0] = DataItem(normalized[0], 'Income', Colors.pink);
      summary_dataset[1] = DataItem(normalized[1], 'Fixed', Colors.orange);
      summary_dataset[2] = DataItem(normalized[2], 'Flexible', Colors.green);
      summary_dataset[3] = DataItem(normalized[3], 'Debt', Colors.blue);
      summary_dataset[4] = DataItem(normalized[4], 'MDI', Colors.deepPurple);
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
            onPressed: () {},
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

                            Row(
                              children: [
                                Expanded(
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      minimumSize: Size.zero,
                                      padding: EdgeInsets.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    onPressed: () {},
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Income',
                                          style: TextStyle(
                                            fontSize:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                0.035,
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
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationThickness: 2.0,
                                              ),
                                            ),
                                            Icon(
                                              Icons.chevron_right_rounded,
                                              color: Color.fromRGBO(
                                                0,
                                                162,
                                                233,
                                                1,
                                              ),
                                              size: 24.0,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                Padding(padding: EdgeInsets.only(left: 20.0)),

                                Expanded(
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      minimumSize: Size.zero,
                                      padding: EdgeInsets.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    onPressed: () {},
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Fixed Exp',
                                          style: TextStyle(
                                            fontSize:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                0.035,
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
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationThickness: 2.0,
                                              ),
                                            ),
                                            Icon(
                                              Icons.chevron_right_rounded,
                                              color: Color.fromRGBO(
                                                0,
                                                162,
                                                233,
                                                1,
                                              ),
                                              size: 24.0,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            Padding(padding: EdgeInsets.only(top: 8.0)),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      minimumSize: Size.zero,
                                      padding: EdgeInsets.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    onPressed: () {},
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Flex Exp',
                                          style: TextStyle(
                                            fontSize:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                0.035,
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
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationThickness: 2.0,
                                              ),
                                            ),
                                            Icon(
                                              Icons.chevron_right_rounded,
                                              color: Color.fromRGBO(
                                                0,
                                                162,
                                                233,
                                                1,
                                              ),
                                              size: 24.0,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                Padding(padding: EdgeInsets.only(left: 16.0)),

                                Expanded(
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      minimumSize: Size.zero,
                                      padding: EdgeInsets.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    onPressed: () {},
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Debt',
                                          style: TextStyle(
                                            fontSize:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                0.035,
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
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationThickness: 2.0,
                                              ),
                                            ),
                                            Icon(
                                              Icons.chevron_right_rounded,
                                              color: Color.fromRGBO(
                                                0,
                                                162,
                                                233,
                                                1,
                                              ),
                                              size: 24.0,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            Padding(padding: EdgeInsets.only(top: 8.0)),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      minimumSize: Size.zero,
                                      padding: EdgeInsets.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    onPressed: () {},
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'MDI',
                                          style: TextStyle(
                                            fontSize:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                0.035,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '\$$mdi',
                                              style: TextStyle(
                                                fontSize:
                                                    MediaQuery.of(
                                                      context,
                                                    ).size.width *
                                                    0.04,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationThickness: 2.0,
                                              ),
                                            ),
                                            Icon(
                                              Icons.chevron_right_rounded,
                                              color: Color.fromRGBO(
                                                0,
                                                162,
                                                233,
                                                1,
                                              ),
                                              size: 24.0,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                Padding(padding: EdgeInsets.only(left: 16.0)),

                                Expanded(
                                  child: FractionallySizedBox(
                                    widthFactor:
                                        MediaQuery.of(context).size.width * 0.5,
                                  ),
                                ),
                              ],
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
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            Padding(padding: EdgeInsets.only(top: 4.0)),

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
                                  "Explore Benefit Wayfinder",
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
                                      '\$$installment',
                                      style: TextStyle(
                                        color: const Color.fromRGBO(
                                          0,
                                          162,
                                          233,
                                          1,
                                        ),
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
                                      color: const Color.fromARGB(
                                        255,
                                        239,
                                        237,
                                        237,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        12.0,
                                      ), // Rounded corners
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                      color: const Color.fromARGB(
                                        255,
                                        239,
                                        237,
                                        237,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        12.0,
                                      ), // Rounded corners
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Monthly*",
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
                                      color: const Color.fromARGB(
                                        255,
                                        239,
                                        237,
                                        237,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        12.0,
                                      ), // Rounded corners
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '\$$total_outstanding',
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
                                      color: const Color.fromARGB(
                                        255,
                                        239,
                                        237,
                                        237,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        12.0,
                                      ), // Rounded corners
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                              'Share Your SMARTI&E Report',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            Padding(padding: EdgeInsets.all(8.0)),

                            Text(
                              'Share the creditor you\'d like to share your SMARTI&E report with. This list has been automatically populated based on your connected accounts.',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                            ),

                            Padding(padding: EdgeInsets.only(top: 24.0)),

                            DropdownMenu<String>(
                              controller: _creditorController,
                              enableFilter: true,
                              width: MediaQuery.of(context).size.width,
                              requestFocusOnTap: true,
                              label: const Text('Choose a Creditor'),
                              dropdownMenuEntries: entries(),
                            ),

                            Padding(padding: EdgeInsets.all(10.0)),

                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromRGBO(
                                    0,
                                    162,
                                    233,
                                    1,
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: Text(
                                  'Share SMARTI&E Report',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Padding(padding: EdgeInsets.all(10.0)),
                  ],
                ),
              ),
            ),

            Center(child: Text("Page Coming Soon.")),

            Center(child: MessageWidget()),

            Center(child: Text("Page Coming Soon")),

            Center(child: Text("Page Coming Soon")),

            Center(child: Text("Page Coming Soon")),
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
