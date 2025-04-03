import 'dart:math';

import 'package:flutter/material.dart';

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

class _SummaryScreenState extends State<SummaryScreen> {
  String selectedValue = 'Monthly';

  final List<DataItem> summary_dataset = [
    DataItem(0.43, 'Income', Colors.pink),
    DataItem(0.15, 'Fixed', Colors.orange),
    DataItem(0.08, 'Flexible', Colors.green),
    DataItem(0.18, 'Debt', Colors.blue),
    DataItem(0.16, 'MDI', Colors.deepPurple),
  ];

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
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.white
            ),
            children: <TextSpan>[
              TextSpan(text: 'Morning, '),
              TextSpan(text: 'Michael', style: const TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: '!'),
            ]
          )
        ),
        actions: [IconButton(
              onPressed: () {}, 
              icon: Icon(
                Icons.notifications_none_rounded,
                color: Colors.white,
                )
            )],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
          children: [
            Padding(padding: EdgeInsets.all(8.0)),

            Container(
              height: 680.0,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: Colors.white
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
                        )
                        ),
                        IconButton(
                          onPressed: () {}, 
                          icon: Icon(
                            Icons.info_outline_rounded,
                            color: Colors.grey,
                            )
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 2.0, bottom: 16.0),
                      child: DropdownMenu(
                        initialSelection: selectedValue,
                        dropdownMenuEntries: <DropdownMenuEntry<String>>[
                          DropdownMenuEntry(value: 'Monthly', label: 'Monthly'),
                          DropdownMenuEntry(value: 'Quarterly', label: 'Quarterly'),
                          DropdownMenuEntry(value: 'Yearly', label: 'Yearly'),
                        ],
                        onSelected: (value) {
                          setState(() {
                            selectedValue = value!; // Update the state when a selection is made
                          });
                        },
                      ),
                    ),
                    Wrap(
                      spacing: 4.0,
                      children: [
                        SizedBox(
                          width: 160.0,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () {}, 
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Income',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w800,
                                  )
                                ),
                                Padding(padding: EdgeInsets.only(left: 24.0)),
                                Text(
                                  '\$3,000',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 2.0,
                                  )
                                  ),
                                Icon(
                                  Icons.chevron_right_rounded,
                                  color: Color.fromRGBO(0, 162, 233, 1),
                                  size: 24.0,
                                  )
                              ],
                            )
                          ),
                        ),
                        
                        SizedBox(
                          width: 164.0,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () {}, 
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Fixed Exp',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w800,
                                  )
                                ),
                                Padding(padding: EdgeInsets.only(left: 20.0)),
                                Text(
                                  '\$1,750',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 2.0,
                                  )
                                  ),
                                Icon(
                                  Icons.chevron_right_rounded,
                                  color: Color.fromRGBO(0, 162, 233, 1),
                                  size: 24.0,
                                  )
                              ],
                            )
                          ),
                        ),
                        SizedBox(
                          width: 162.0,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () {}, 
                            child: Padding(
                              padding: EdgeInsets.only(top: 16.0),
                              child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Flex Exp',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w800,
                                  )
                                ),
                                Padding(padding: EdgeInsets.only(left: 30.0)),
                                Text(
                                  '\$500',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 2.0,
                                  )
                                  ),
                                Icon(
                                  Icons.chevron_right_rounded,
                                  color: Color.fromRGBO(0, 162, 233, 1),
                                  size: 24.0,
                                  )
                              ],
                            )
                            )
                          ),
                        ),
                        SizedBox(
                          width: 162.0,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () {}, 
                            child: Padding(
                              padding: EdgeInsets.only(top: 16.0),
                              child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Debt',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w800,
                                  )
                                ),
                                Padding(padding: EdgeInsets.only(left: 60.0)),
                                Text(
                                  '\$250',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 2.0,
                                  )
                                  ),
                                Icon(
                                  Icons.chevron_right_rounded,
                                  color: Color.fromRGBO(0, 162, 233, 1),
                                  size: 24.0,
                                  )
                              ],
                            )
                            )
                          ),
                        ),
                        SizedBox(
                          width: 162.0,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () {}, 
                            child: Padding(
                              padding: EdgeInsets.only(top: 16.0),
                              child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'MDI',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w800,
                                  )
                                ),
                                Padding(padding: EdgeInsets.only(left: 62.0)),
                                Text(
                                  '\$500',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 2.0,
                                  )
                                  ),
                                Icon(
                                  Icons.chevron_right_rounded,
                                  color: Color.fromRGBO(0, 162, 233, 1),
                                  size: 24.0,
                                  )
                              ],
                            ),
                            )
                          ),
                        ),
                      ],
                    ),

                    Divider(
                      color: Colors.grey,
                    ),

                    Text(
                        'SMARTIE Summary',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        )
                    ),

                    Padding(padding: EdgeInsets.only(top: 4.0)),

                    Row(
                      children: [
                        DonutChartWidget(summary_dataset),

                        Padding(padding: EdgeInsets.only(left: 16.0)),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                        borderRadius: BorderRadius.circular(4.0)
                                      )
                                      ),
                                  ),

                                  Padding(padding: EdgeInsets.only(left: 8.0)),

                                  Text(
                                    'Income',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w800,
                                    )
                                  ),

                                  Padding(padding: EdgeInsets.only(left: 4.0)),

                                  Text(
                                    '(43%)',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w800,
                                    )
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
                                        borderRadius: BorderRadius.circular(4.0)
                                      )
                                      ),
                                  ),

                                  Padding(padding: EdgeInsets.only(left: 8.0)),

                                  Text(
                                    'Fixed',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w800,
                                    )
                                  ),

                                  Padding(padding: EdgeInsets.only(left: 4.0)),

                                  Text(
                                    '(15%)',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w800,
                                    )
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
                                        borderRadius: BorderRadius.circular(4.0)
                                      )
                                      ),
                                  ),

                                  Padding(padding: EdgeInsets.only(left: 8.0)),

                                  Text(
                                    'Flexible',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w800,
                                    )
                                  ),

                                  Padding(padding: EdgeInsets.only(left: 4.0)),

                                  Text(
                                    '(8%)',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w800,
                                    )
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
                                        borderRadius: BorderRadius.circular(4.0)
                                      )
                                      ),
                                  ),

                                  Padding(padding: EdgeInsets.only(left: 8.0)),

                                  Text(
                                    'Debt',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w800,
                                    )
                                  ),

                                  Padding(padding: EdgeInsets.only(left: 4.0)),

                                  Text(
                                    '(18%)',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w800,
                                    )
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
                                        borderRadius: BorderRadius.circular(4.0)
                                      )
                                      ),
                                  ),

                                  Padding(padding: EdgeInsets.only(left: 8.0)),

                                  Text(
                                    'MDI',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w800,
                                    )
                                  ),

                                  Padding(padding: EdgeInsets.only(left: 4.0)),

                                  Text(
                                    '(16%)',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w800,
                                    )
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ), 

                    Padding(padding: EdgeInsets.only(top: 4.0)),

                    SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 214, 238, 249),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: Text(
                        "Explore Benefit Wayfinder",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: const Color.fromRGBO(0, 162, 233, 1)
                          ),
                      ),
                    ),
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 214, 238, 249),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: Text(
                        "Find Debt Advice",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: const Color.fromRGBO(0, 162, 233, 1)
                          ),
                      ),
                    ),
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 214, 238, 249),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: Text(
                        "Apply for LEAP, OESB, etc.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: const Color.fromRGBO(0, 162, 233, 1)
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
              height: 680.0,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: Colors.white
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
                      )
                    ),
                    
                    Padding(padding: EdgeInsets.all(8.0)),

                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '\$416.66',
                              style: TextStyle(
                                color: const Color.fromRGBO(0, 162, 233, 1),
                                fontWeight: FontWeight.w600,
                                fontSize: 36.0,
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(left: 4.0),
                              child: Text(
                                'Instalment',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            
                          ],
                        )
                      ],
                    )

                  ],
                )
                )
              ),
          ],
        )
      ),
      )
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
      width: 150.0,
      height: 150.0, 
      child: CustomPaint(
        child: Container(),
        painter: DonutChartPainter(widget.summary_dataset),
      ),
    );
  }
}

class DonutChartPainter extends CustomPainter{
  final List<DataItem> dataset;
  DonutChartPainter(this.dataset);

  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2.0, size.height / 2.0);
    final radius = size.width * 0.9;
    final rect = Rect.fromCenter(center: c, width: radius, height: radius);
    var startAngle = 0.0;
    final midPaint = Paint()
        ..style = PaintingStyle.fill
        ..color = Colors.white;
    for (var di in dataset) {
      final sweepAngle = di.value * 360.0 * pi / 180.0;
      final paint = Paint()
        ..style = PaintingStyle.fill
        ..color = di.color;
      canvas.drawArc(rect, startAngle, sweepAngle, true, paint);
      startAngle += sweepAngle;
    }
    canvas.drawCircle(c, radius*0.35, midPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
