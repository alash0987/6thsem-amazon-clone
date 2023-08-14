import 'package:amazonclone/features/admin/model/sales_model.dart';
import 'package:amazonclone/features/admin/services/admin_services.dart';
// import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earnings;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  getEarnings() async {
    var earningData = await adminServices.getEarnings(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              Text(
                'You have made a total sales of \n\n \$$totalSales \n \n \n \n Chart will be displayed here later on',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff0C0B52),
                ),
              ),
              const SizedBox(
                height: 250,
              ),
            ],
          );
  }
}
