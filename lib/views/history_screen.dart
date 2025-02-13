// history_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';

import '../bloc/saving_bloc.dart';
import '../bloc/saving_state.dart';


class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Savings History',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity, // Ensures it covers the full width
        height: double.infinity, // Ensures it covers the full height
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade300, Colors.deepPurple.shade800],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded( // This ensures the ListView takes up all remaining space
              child: BlocBuilder<SavingsBloc, SavingsState>(
                builder: (context, state) {
                  if (state is SavingsLoaded && state.savings.history.isNotEmpty) {
                    return ListView.builder(
                      padding: EdgeInsets.all(10),
                      itemCount: state.savings.history.length,
                      itemBuilder: (context, index) {
                        return FadeInUp(
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            elevation: 6,
                            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                            child: ListTile(
                              leading: Icon(Icons.history, color: Colors.deepPurple),
                              title: Text(
                                state.savings.history[index],
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                              subtitle: Text(
                                'Transaction ${index + 1}',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }

                  // No history message
                  return Center( // Wrap in Center to properly align in Expanded
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.history, size: 80, color: Colors.white70),
                        SizedBox(height: 10),
                        Text(
                          "No transaction history yet!",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
                        ),
                      ],
                    ),
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
