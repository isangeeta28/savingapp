# savingapp

Here's a quick overview of how the project is organized:

/lib
│── bloc/                  # BLoC files (state management)
│   ├── saving_bloc.dart    # Handles logic for savings
│   ├── saving_event.dart   # Defines all possible events
│   ├── saving_state.dart   # Defines states for savings
│
│── models/                 # Data models
│   ├── saving_model.dart   # Model for savings data
│
│── views/                # UI screens
│   ├── main_screen.dart     # Overview of savings
│   ├── savings_entry.dart   # Screen for adding savings
│   ├── withdrawal_screen.dart  # Screen for withdrawing funds
│   ├── history_screen.dart  # Displays transaction history
│
│── services/               # Business logic services
│   ├── storage_services.dart # Handles saving and loading data

Why BLoC for State Management?

We chose BLoC because:

✅ Scalability – As the app grows, BLoC keeps the logic clean and modular.

✅ Separation of Concerns – UI and business logic stay independent.

✅ Predictability – Every state transition happens explicitly, making debugging easier.

✅ Testability – Makes unit testing much more manageable.

Features

✔️ View your total savings (split into two components: CompA & CompB)
✔️ Add savings and automatically split it between the two components
✔️ Withdraw money from either component
✔️ View a history of all transactions
✔️ Smooth animations and an intuitive UI


#   s a v i n g a p p 
 
 
