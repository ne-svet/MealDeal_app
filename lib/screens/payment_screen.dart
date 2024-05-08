import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:provider/provider.dart';

import '../provider/menu_item_provider.dart';
import '../widgets/green_stripe.dart';
import '../widgets/my_Drawer.dart';
import '../widgets/my_appBar.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  // for credit card form
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //for credit card
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  //pay method
  void userPayment() {
    if (formKey.currentState!.validate()) {
      //диалог показывается, если форма валидирована
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Confirm payment"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text("Card number: ${cardNumber}"),
                Text("Expiry Date: ${expiryDate}"),
                Text("Card Holder Name: ${cardHolderName}"),
                Text("CVV: ${cvvCode}"),
              ],
            ),
          ),
          actions: [
            //отмена
            TextButton(
                onPressed: () => Navigator.pop(context), child: Text("Cancel")),
            //удалить
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/confirmation').then((_) {
                    // Вызываем метод очистки корзины и обновляем состояние виджета
                    Provider.of<MenuItemProvider>(context, listen: false).clearCart();
                    // Можно добавить setState(), если виджет не обновляется автоматически
                  });
                },
                child: Text("Yes")),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GreenStripe(
              screenName: "Checkout",
              screenIcon: null,
              onPressedScreenIcon: null,
            ),
            //-------------------------------------------------
            //credit card
            CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
                onCreditCardWidgetChange: (p0) {}),
            //-------------------------------------------------
            //credit card form
            CreditCardForm(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                onCreditCardModelChange: (data) {
                  setState(() {
                    cardNumber = data.cardNumber;
                    expiryDate = data.expiryDate;
                    cardHolderName = data.cardHolderName;
                    cvvCode = data.cvvCode;
                  });
                },
                formKey: formKey),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Color(0xFF62BD5C),
                ),
                onPressed: userPayment,
                child: const Text(
                  "Pay now",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}
