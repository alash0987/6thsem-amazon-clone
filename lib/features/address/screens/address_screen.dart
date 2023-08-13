import 'package:amazonclone/common/widgets/custom_button.dart';
import 'package:amazonclone/common/widgets/custom_textfield.dart';
import 'package:amazonclone/constants/global_variable.dart';
import 'package:amazonclone/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatelessWidget {
  static const String routeName = '/address-screen';
  AddressScreen({super.key});
  final TextEditingController _flatBuildingController = TextEditingController();
  final TextEditingController _areaStreetController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();
  final TextEditingController _townCityController = TextEditingController();
  final _addressKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariable.appBarGradient),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'OR',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              Form(
                key: _addressKey,
                child: Column(
                  children: [
                    CustomTextField(
                        hintText:
                            ' Flat, House no., Building, Company, Apartment',
                        title: 'Address Line 1',
                        controller: _flatBuildingController),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      hintText: 'Area ,  Street',
                      title: 'Email',
                      controller: _areaStreetController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      hintText: 'Pin Code',
                      title: 'Password',
                      controller: _pinCodeController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      hintText: 'Town / City',
                      title: 'Password',
                      controller: _townCityController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
