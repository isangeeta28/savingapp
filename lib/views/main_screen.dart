import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:savingapp/views/saving_entry_screen.dart';
import '../bloc/saving_bloc.dart';
import '../bloc/saving_state.dart';
import 'withdrawal_screen.dart';
import 'history_screen.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Savings Overview',
            style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: SizedBox.expand(  // This ensures the Container takes full screen height
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple.shade300, Colors.deepPurple.shade800],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: BlocBuilder<SavingsBloc, SavingsState>(
            builder: (context, state) {
              if (state is SavingsLoaded) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      FadeInUp(
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Total Savings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.grey[700])),
                                SizedBox(height: 10),
                                Text(
                                  '₹${state.savings.compA + state.savings.compB}',
                                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                                ),
                                Divider(height: 30, thickness: 1),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _buildSavingsInfo('Comp A', state.savings.compA),
                                    _buildSavingsInfo('Comp B', state.savings.compB),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      _buildActionButton(
                        context,
                        icon: Icons.add_circle_outline,
                        label: 'Add Savings',
                        color: Colors.greenAccent.shade700,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SavingsEntryScreen())),
                      ),
                      _buildActionButton(
                        context,
                        icon: Icons.remove_circle_outline,
                        label: 'Withdraw',
                        color: Colors.redAccent,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => WithdrawalScreen())),
                      ),
                      _buildActionButton(
                        context,
                        icon: Icons.history,
                        label: 'View History',
                        color: Colors.blueAccent,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => HistoryScreen())),
                      ),
                    ],
                  ),
                );
              }
              return Center(child: CircularProgressIndicator(color: Colors.white));
            },
          ),
        ),
      ),
    );

  }

  Widget _buildSavingsInfo(String title, int amount) {
    return Column(
      children: [
        Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey[600])),
        SizedBox(height: 5),
        Text(
          '₹$amount',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, {required IconData icon, required String label, required Color color, required VoidCallback onTap}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: BounceInDown(
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          ),
          icon: Icon(icon, size: 28, color: Colors.white),
          label: Text(label, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
          onPressed: onTap,
        ),
      ),
    );
  }
}
