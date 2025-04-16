import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
  List<Message> _messages = [Message("Hello! Please let me know how I can help you today.")];

  List<Message> get messages => _messages;

  void addMessage(String text) {
    _messages.add(Message(text));
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

  int installment = 200 + Random().nextInt(600);
  int totalOutstanding = 5000 + Random().nextInt(500);

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
                    Padding(
                      padding: EdgeInsets.only(top: 16.0)
                    ),
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
                              'FAQs',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            Padding(padding: EdgeInsets.all(8.0)),

                            ExpansionTile(
                              title: Text('Budgeting'),
                              children: [
                                ExpansionTile(
                                  title: Text('What is MDI?'),
                                  children: [
                                    Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('MDI stands for Monthly Disposable Income. It’s the amount left after fixed, flexible, debt, savings, and emergency fund allocations.'),
                                  )
                                  ],
                                ),
                                ExpansionTile(
                                  title: Text('What counts as fixed vs flexible expenses?'),
                                  children: [
                                    Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Fixed expenses include rent, bills, subscriptions—things that are the same each month. Flexible expenses include groceries, transport, entertainment, and other spending that varies.'),
                                  )
                                  ],
                                ),
                                ExpansionTile(
                                  title: Text('What is MDI?'),
                                  children: [
                                    Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('MDI stands for Monthly Disposable Income. It’s the amount left after fixed, flexible, debt, savings, and emergency fund allocations.'),
                                  )
                                  ],
                                )
                              ],
                            ),

                            
                            ExpansionTile(
                              title: Text('Savings'),
                              children: [
                                ExpansionTile(
                                  title: Text('How much should I save each month?'),
                                  children: [
                                    Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('A good rule of thumb is to save at least 20% of your income. This app starts by suggesting 5% for emergency savings and 5% for general savings, but you can adjust based on your goals.'),
                                  )
                                  ],
                                ),
                                ExpansionTile(
                                  title: Text('What is an Emergency Fund?'),
                                  children: [
                                    Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('It’s money set aside for unexpected expenses like medical emergencies, car repairs, or job loss. This app suggests saving 5% of your income toward your emergency fund.'),
                                  )
                                  ],
                                )
                              ],
                            ),

                            
                            ExpansionTile(
                              title: Text('Debt & Repayment'),
                              children: [
                                ExpansionTile(
                                  title: Text('Can this app help me pay off debt?'),
                                  children: [
                                    Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Yes! You can track your debts and use the Repayment Planner tool to build a payoff strategy, whether you\'re using the Snowball or Avalanche method.'),
                                  )
                                  ],
                                ),
                                ExpansionTile(
                                  title: Text('How do I track my debt payments?'),
                                  children: [
                                    Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Go to the Debt section, input your balances and monthly payments. The app will automatically deduct them from your monthly income and adjust your MDI.'),
                                  )
                                  ],
                                )
                              ],
                            ),

                            ExpansionTile(
                              title: Text('Privacy & Data'),
                              children: [
                                ExpansionTile(
                                  title: Text('Is my data secure?'),
                                  children: [
                                    Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Yes, your financial data is stored securely and never shared with third parties without your consent. You can read more in our Privacy Policy.'),
                                  )
                                  ],
                                ),
                                ExpansionTile(
                                  title: Text('Can I reset my data?'),
                                  children: [
                                    Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Absolutely. Go to Settings > Reset Data to clear all saved values and start fresh.'),
                                  )
                                  ],
                                )
                              ],
                            ),

                            Divider(color: Colors.grey),

                            Padding(padding: EdgeInsets.all(8.0)),

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
                                            '\$$totalOutstanding',
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
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            Padding(padding: EdgeInsets.all(2.0)),

                            Text(
                              'Trusted, government-backed advice to help you budget, save, and manage debt.',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                            ),

                            ExpansionTile(
                              title: Text('United States'),
                              children: [
                                    Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        TextButton(
                                        onPressed: () => _launchURL('https://www.consumerfinance.gov/consumer-tools/'),
                                        child: Text('ConsumerFinance.gov'),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 14.0),
                                        child: Text('Tools and articles from the CFPB on budgeting, dealing with debt, credit building, and more.'),
                                      ),
                                      TextButton(
                                        onPressed: () => _launchURL('https://www.mymoney.gov/'),
                                        child: Text('MyMoney.gov'),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 14.0),
                                        child: Text('U.S. government site offering personal finance tips and resources across five key principles — earn, save, protect, spend, and borrow.'),
                                      ),
                                      Padding(padding: EdgeInsets.all(2.0)),
                                    ],
                                    )
                                  )
                              ],
                            ),

                            ExpansionTile(
                              title: Text('Canada'),
                              children: [
                                    Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        TextButton(
                                        onPressed: () => _launchURL('https://www.canada.ca/en/financial-consumer-agency/programs/financial-literacy.html'),
                                        child: Text('Canada.ca - Financial Literacy'),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 14.0),
                                        child: Text('Tools and guidance from the Government of Canada for budgeting, saving, and understanding credit.'),
                                      ),
                                      TextButton(
                                        onPressed: () => _launchURL('https://www.canada.ca/en/services/finance/tools.html'),
                                        child: Text('FCAC Tools'),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 14.0),
                                        child: Text('Interactive tools like budget planners and mortgage calculators from the Financial Consumer Agency of Canada (FCAC).'),
                                      ),
                                      Padding(padding: EdgeInsets.all(2.0)),
                                    ],
                                    )
                                  )
                              ],
                            ),         
                          ],
                        )
                        )
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16.0)
                      ),
                  ],
                )
              )
            )
      );
  }
  
}

class _SummaryScreenState extends State<SummaryScreen> {
  final TextEditingController _creditorController = TextEditingController();

  String selectedValue = 'Monthly';
  int currentPageIndex = 0;

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

  @override
  void initState() {
    super.initState();
    income = 2500 + rand.nextInt(2000);
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
    summary_dataset[5] = DataItem(normalized[5], 'Emergency Fund', Colors.deepOrange);
    summary_dataset[6] = DataItem(normalized[6], 'Savings', Colors.lime);
  }

  void _generateRandomValues() {
    setState(() {
      income = 4500 + rand.nextInt(2000);
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
      summary_dataset[5] = DataItem(normalized[5], 'Emergency Fund', Colors.deepOrange);
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
              label: "SMARTIE",
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
                                          'Savings',
                                          style: TextStyle(
                                            fontSize:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
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
                                          'Emergency Fund',
                                          style: TextStyle(
                                            fontSize:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
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

                                // Padding(padding: EdgeInsets.only(left: 16.0)),

                                SizedBox(
                                  width: MediaQuery.of(
                                                      context,
                                                    ).size.width *
                                                    0.24,
                                  height: 12.0,
                                ),
                            
                                // Expanded(
                                //   child: SizedBox(
                                //     width: 200,
                                //   )
                                // ),
                              ],
                            ),

                            Divider(color: Colors.grey),

                            Text(
                              'SMARTIE Summary',
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
                            ),

                            Padding(padding: EdgeInsets.all(2.0)),

                            SizedBox(
                              width: double.infinity, 
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromRGBO(0, 162, 233, 1),
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: Text(
                                  'Share SMARTIE Report',
                                  style: TextStyle(
                                    color: Colors.white,
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

            Center(child: MessageWidget()),

            Center(child: Text("Page Coming Soon")),

            Center(child: Text("Page Coming Soon")),

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
