import 'package:applaluz/screens/chat_screen/main_chat.dart';
import 'package:applaluz/screens/laboratory_confirmation_screen/laboratory_confirmation_screen.dart';
import 'package:applaluz/screens/laboratory_dni_screen/laboratory_dni_screen.dart';
import 'package:applaluz/screens/laboratory_screen/laboratory_screen.dart';
import 'package:applaluz/screens/laboratory_success_screen/laboratory_success_screen.dart';
import 'package:applaluz/screens/laboratory_ticket_screen/laboratory_ticket_screen.dart';
import 'package:applaluz/screens/payment_chat_screen/payment_screen.dart';
import 'package:flutter/widgets.dart';

import 'package:applaluz/screens/asistente/asistente.dart';
import 'package:applaluz/screens/medic_screen/medic_screen.dart';
import 'package:applaluz/screens/teleconsultation_info/teleconsultation_info_screen.dart';
import 'package:applaluz/screens/menu_screen/menu_screen.dart';
import 'package:applaluz/screens/forgot_password/forgot_password_screen.dart';
import 'package:applaluz/screens/sign_in/sign_in_screen.dart';
import 'package:applaluz/screens/splash/splash_screen.dart';
import 'package:applaluz/screens/complete_profile/complete_profile_screen.dart';
import 'package:applaluz/screens/payment_screen/payment_screen.dart';
import 'package:applaluz/screens/payment_screen/confirm_payment.dart';
import 'package:applaluz/screens/medic_menu/medic_menu_screen.dart';
import 'package:applaluz/screens/medic_menu/list_medic_screen.dart';
import 'screens/sign_up/sign_up_screen.dart';
import 'package:applaluz/screens/pending_teleconsultation/pending_teleconsultation_screen.dart';
import 'package:applaluz/screens/history_screen/history_screen.dart';
import 'package:applaluz/screens/history_screen/history_laboratory.dart';
import 'package:applaluz/screens/history_screen/history_teleconsultation.dart';
import 'package:applaluz/screens/medic_screen/commentary_screen.dart';
import 'package:applaluz/screens/suggestion_screen/suggestion_screen.dart';

final String noLoggedInitialRoute = SplashScreen.routeName;
final String loggedInitialRoute = MenuScreen.routeName;

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  MenuScreen.routeName: (context) => MenuScreen(),
  PaymentScreen.routeName: (context) => PaymentScreen(),
  ConfirmPayment.routeName: (context) => ConfirmPayment(),
  AsistantScreen.routeName: (context) => AsistantScreen(),
  MedicMenuScreen.routeName: (context) => MedicMenuScreen(),
  ListMedicScreen.routeName: (context) => ListMedicScreen(),
  PendingTeleconsultationScreen.routeName: (context) =>
      PendingTeleconsultationScreen(),
  MedicScreen.routeName: (context) => MedicScreen(),
  TeleconsultationInfoScreen.routeName: (context) =>
      TeleconsultationInfoScreen(),
  HistoryScreen.routeName: (context) => HistoryScreen(),
  HistoryLaboratory.routeName: (context) => HistoryLaboratory(),
  HistoryTeleconsultation.routeName: (context) => HistoryTeleconsultation(),
  SuggestionScreen.routeName: (context) => SuggestionScreen(),
  CommentaryScreen.routeName: (context) => CommentaryScreen(),
  LaboratoryScreen.routeName: (context) => LaboratoryScreen(),
  ConfirmationLaboratoryScreen.routeName: (context) =>
      ConfirmationLaboratoryScreen(),
  LaboratorySuccessScreen.routeName: (context) => LaboratorySuccessScreen(),
  LaboratoryTicketScreen.routeName: (context) => LaboratoryTicketScreen(),
  DNILaboratoryScreen.routeName: (context) => DNILaboratoryScreen(),
  MainChat.routeName:(context)=> MainChat(),
  PaymentScreenChat.routeName:(context)=> PaymentScreenChat(),
};
