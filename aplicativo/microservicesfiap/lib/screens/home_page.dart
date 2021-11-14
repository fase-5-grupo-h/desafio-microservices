import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:microservicesfiap/screens/app_bar.dart';
import 'package:microservicesfiap/screens/quick_list_view.dart';
import 'package:microservicesfiap/screens/schedule_payment_widget.dart';

import 'card_widget_home.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: HomeAppBar(),
      ),
      body: Container(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                QuickListView(),
                CardWidgetHome(),
                SchedulePaymentWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
