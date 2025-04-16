import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartie/summary_screen.dart';

class RepaymentPlan extends StatefulWidget {
  const RepaymentPlan({super.key});
  @override
  State<RepaymentPlan> createState() => _RepaymentPlanState();
}

class DataItem {
  final double value;
  final String label;
  final Color color;
  DataItem(this.value, this.label, this.color);
}

class _RepaymentPlanState extends State<RepaymentPlan> {
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
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.center,
          child: Container(
            margin: EdgeInsets.only(top: 100),
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
                          Text(formattedDate, style: TextStyle(fontSize: 16.0)),

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

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(123, 123, 123, 1),
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text(
                        'Return to Summary',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
