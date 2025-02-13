// withdrawal_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/saving_bloc.dart';
import '../bloc/saving_event.dart';

class WithdrawalScreen extends StatefulWidget {
  @override
  _WithdrawalScreenState createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends State<WithdrawalScreen> {
  final TextEditingController _controller = TextEditingController();
  bool fromCompA = true; // Default selection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        title: Text(
          'Withdraw Amount',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade300, Colors.deepPurple.shade800],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SizedBox(height: 20),

                // Dropdown Selector
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<bool>(
                      value: fromCompA,
                      items: [
                        DropdownMenuItem(value: true, child: Text('CompA')),
                        DropdownMenuItem(value: false, child: Text('CompB')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          fromCompA = value ?? true;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Input Field
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      hintText: 'Enter Amount',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    ),
                  ),
                ),
                SizedBox(height: 30),

                // Withdraw Button
                ElevatedButton(
                  onPressed: () {
                    final amount = int.tryParse(_controller.text) ?? 0;
                    if (amount > 0) {
                      context.read<SavingsBloc>().add(WithdrawEvent(amount, fromCompA));
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please enter a valid amount')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    backgroundColor: Colors.redAccent,
                  ),
                  child: Text(
                    'Withdraw',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
