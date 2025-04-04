import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smartie/bank_login_screen.dart';

class BanksSelectionScreen extends StatefulWidget {
  const BanksSelectionScreen({super.key});
  @override
  State<BanksSelectionScreen> createState() => _BanksSelectionScreenState();
}

class _BanksSelectionScreenState extends State<BanksSelectionScreen> {
  // final TextEditingController _searchController = TextEditingController();
  final List<Map<String, String>> banks = [
    {'name': 'Royal Bank of Canada ( RBC )', 'logo': 'assets/images/bank_logos/rbc-royal-bank-logo.png'},
    {'name': '( Toronto - Dominion ) TD Bank Canada', 'logo': 'assets/images/bank_logos/td-bank-logo.png'},
    {'name': 'Canadian Imperial Bank of Commerce ( CIBC )', 'logo': 'assets/images/bank_logos/CIBC-logo.png'},  
    {'name': 'ScotiaBank', 'logo': 'assets/images/bank_logos/scotiabank-logo.png'},
    {'name': '( Bank of Montreal ) BMO Canada', 'logo': 'assets/images/bank_logos/bank_of_montreal_logo.png'},
    {'name': 'National Bank of Canada', 'logo': 'assets/images/bank_logos/National_Bank_Of_Canada_logo.png'},
    {'name': 'ATB Financial', 'logo': 'assets/images/bank_logos/atb-financial_logo.png'},
    {'name': 'Laurentian Bank of Canada', 'logo': 'assets/images/bank_logos/Laurentian_Bank_of_Canada_logo.png'},
    {'name': 'HSBC Canada', 'logo': 'assets/images/bank_logos/HSBC_Bank-logo.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          spacing: 12.0,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 72.0,
                bottom: 24.0,
                left: 28.0,
                right: 28.0,
              ),
              child: Column(
                children: [
                  // Company Icon
                  Image.asset(
                    'assets/images/smartie_logo.png',
                    width: MediaQuery.of(context).size.width * 0.7,
                  ),

                  Padding(padding: EdgeInsets.all(20.0)),

                  FractionallySizedBox(
                    alignment: Alignment.center,
                    widthFactor: 1.0, // Same width as the first text
                    // child: Text(
                    //   "bank-verbiage".tr().toString(),
                    //   style: TextStyle(
                    //     color: const Color.fromARGB(255, 132, 132, 132),
                    //     fontSize: 14.0,
                    //   ),
                    //   textAlign: TextAlign.center,
                    // ),
                    child: Text(
                      "Please select your bank. You can also search for it with the box below to help you out:",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 132, 132, 132),
                        fontSize: 14.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  // FilledButton(
                  //   onPressed: () async {
                  //     context.locale = Locale('en','US');
                  //   }, 
                  //   child: Text('English')
                  // ),

                  // FilledButton(
                  //   onPressed: () async {
                  //     context.locale = Locale('fr','FR');
                  //   }, 
                  //   child: Text('French')
                  // ),

                  Padding(padding: EdgeInsets.all(12.0)),

                  //Search Bar
                  TextField(
                    onTap: () {
                      showSearch(
                        context: context, 
                        delegate: BankSearchDelegate()
                      );
                    },
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(Icons.search, color:Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Color.fromARGB(255, 210, 210, 210)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: const Color.fromRGBO(0, 162, 233, 1)),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                    ),
                  ),

                  Padding(padding: EdgeInsets.all(16.0)),
                  
                  // List of banks
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 10.0,
                    children: banks.map((bank) {
                      return OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            side: BorderSide(color: const Color.fromARGB(255, 210, 210, 210)),
                            minimumSize: Size(MediaQuery.of(context).size.width * 0.9, MediaQuery.of(context).size.width * 0.1),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context, 
                              MaterialPageRoute(
                                builder: (context) => BankLoginScreen(imagePath: bank['logo']!)
                              )
                            );
                          }, 
                          child: Image.asset(
                            bank['logo']!, 
                            width: 160.0, 
                            height: 100.0,
                          )
                        );
                    }).toList(),
                  )                
                ],
              ),
            ),
          ],
          ),
        ),
    );
  }
}

class BankSearchDelegate extends SearchDelegate {

  final List<Map<String, String>> banks = [
    {'name': 'National Bank of Canada', 'logo': 'assets/images/bank_logos/National_Bank_Of_Canada_logo.png'},
    {'name': 'Laurentian Bank of Canada', 'logo': 'assets/images/bank_logos/Laurentian_Bank_of_Canada_logo.png'},
    {'name': 'BMO Canada', 'logo': 'assets/images/bank_logos/bank_of_montreal_logo.png'},
    {'name': 'HSBC Canada', 'logo': 'assets/images/bank_logos/HSBC_Bank-logo.png'},
    {'name': 'Canadian Imperial Bank of Commerce', 'logo': 'assets/images/bank_logos/CIBC-logo.png'},
    {'name': 'RBC', 'logo': 'assets/images/bank_logos/rbc-royal-bank-logo.png'},
    {'name': 'TD Bank Canada', 'logo': 'assets/images/bank_logos/td-bank-logo.png'},
    {'name': 'ScotiaBank', 'logo': 'assets/images/bank_logos/scotiabank-logo.png'},
    {'name': 'ATB Financial', 'logo': 'assets/images/bank_logos/atb-financial_logo.png'},
  ];
  
  @override
  // Clear the search query
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        }, 
        icon: const Icon(Icons.clear)
      )
    ];
  }

  @override
  // Return Icon Button
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      }, 
      icon: const Icon(Icons.arrow_back)
    );
  }

  @override
  // Match items to search query
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var bank in banks) {
      if (bank['name']!.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(bank['logo']!);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            side: BorderSide(color: const Color.fromARGB(255, 231, 230, 230)),
            minimumSize: Size(MediaQuery.of(context).size.width * 0.9, MediaQuery.of(context).size.width * 0.1),
          ),
          onPressed: () {
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => BankLoginScreen(imagePath: result)
              )
            );
          }, 
          child: Image.asset(
            result, 
            width: 160.0, 
            height: 100.0,
          )
        );
      }
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var bank in banks) {
      if (bank['name']!.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(bank['logo']!);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            side: BorderSide(color: const Color.fromARGB(255, 231, 230, 230)),
            minimumSize: Size(MediaQuery.of(context).size.width * 0.9, MediaQuery.of(context).size.width * 0.1),
          ),
          onPressed: () {
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => BankLoginScreen(imagePath: result)
              )
            );
          }, 
          child: Image.asset(
            result, 
            width: 160.0, 
            height: 100.0,
          )
        );
      }
    );
  }
}
