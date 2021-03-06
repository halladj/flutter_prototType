import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:proto/components/secondary_app_bar.dart';
import 'package:proto/home/home_cubit.dart';
import 'package:proto/prediction_form/model/pc.model.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:proto/components/components.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SeconedForm extends HookWidget {
  var formKey = GlobalKey<FormState>();

  var ssdController = TextEditingController();
  var hddController = TextEditingController();
  var screenSizeController = TextEditingController();
  var screenRefreshRateController = TextEditingController();
  var screenResolutionController = TextEditingController();
  var ramFrequencyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _ssd = useState<int>(0);
    final _hdd = useState<int>(0);
    final _screenSize = useState<double>(0);
    final _screenRefreshRate = useState<int>(0);
    final _screenResolution = useState<String>("");
    final _touchScreen = useState<int>(0);
    final _state = useState<int>(0);
    final _ramFrequency = useState<double>(0);

    return Scaffold(
        //appBar: SecondaryAppBar(title: "Prediction Form(2/2)"),
        body: SingleChildScrollView(
            //insert the column here so we can put that logo
            child: Container(
                margin: const EdgeInsets.fromLTRB(21, 30, 21, 0),
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 20.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.1),
                    width: 2.0,
                  ),
                ),
                child: Form(
                    key: formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CustomTextField(
                              label: "RAM Frequency",
                              hint: "2999, 3213",
                              controller: ramFrequencyController,
                              onChanged: (value) =>
                                  _ramFrequency.value = double.parse(value),
                              keyboardInputType: TextInputType.number,
                              autoFocus: false),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                    label: "SSD Storage",
                                    hint: "128, 256 ...",
                                    controller: ssdController,
                                    onChanged: (value) =>
                                        _ssd.value = int.parse(value),
                                    keyboardInputType: TextInputType.number,
                                    autoFocus: false),
                              ),
                              const SizedBox(width: 24),
                              Expanded(
                                child: CustomTextField(
                                    label: "HDD Storage",
                                    hint: "500, 1000 ....",
                                    controller: hddController,
                                    onChanged: (value) =>
                                        _hdd.value = int.parse(value),
                                    keyboardInputType: TextInputType.number,
                                    autoFocus: false),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: CustomTextField(
                                    label: "Screen Size",
                                    hint: "13.3, 15.6 ...",
                                    controller: screenSizeController,
                                    onChanged: (value) =>
                                        _screenSize.value = double.parse(value),
                                    keyboardInputType: TextInputType.number,
                                    autoFocus: false),
                              ),
                              const SizedBox(width: 24),
                              Expanded(
                                child: CustomTextField(
                                    label: "Screen RefreshRate",
                                    hint: "60, 144 Hz....",
                                    controller: screenRefreshRateController,
                                    onChanged: (value) => _screenRefreshRate
                                        .value = int.parse(value),
                                    keyboardInputType: TextInputType.number,
                                    autoFocus: false),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 2.0),
                                child: Text(
                                  "Screen Resolution",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.blueGrey.withOpacity(0.8),
                                  ),
                                ),
                              ),
                              TypeAheadFormField<String>(
                                textFieldConfiguration: TextFieldConfiguration(
                                  controller: screenResolutionController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    hintText: "Full HD",
                                    hintStyle: TextStyle(
                                        fontSize: 16,
                                        color: HexColor("#b4b8bc")),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(0.1),
                                          width: 2),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Color(0xff35e0d2), width: 2),
                                    ),
                                  ),
                                ),
                                onSuggestionSelected: (String? suggestion) {
                                  final screenResolution = suggestion!;

                                  _screenResolution.value = suggestion;
                                  screenResolutionController.text =
                                      screenResolution;
                                },
                                validator: (value) {
                                  var newValue = value!;
                                  if (newValue.isEmpty) {
                                    return 'Screen Resolution cant be Empty';
                                  }
                                },
                                itemBuilder: (context, String? suggestion) {
                                  final screenResolution = suggestion!;
                                  return ListTile(
                                    title: Text(screenResolution),
                                  );
                                },
                                suggestionsCallback: Api2.getScreenResolution,
                                noItemsFoundBuilder: (context) =>
                                    const SizedBox(
                                  height: 100,
                                  child: Center(
                                    child: Text(
                                      "No Screen Resolution was found.",
                                      style: TextStyle(
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          CustomSlider(
                              label: "Touch screen",
                              max: 1,
                              min: 0,
                              divisions: 2,
                              seconedLabel: _touchScreen.value == 1
                                  ? "Has touch screen"
                                  : "Does Not Have touch screen",
                              value: _touchScreen),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SelectionField(label: "State", value: _state),
                              //TODO TOGGLE SWITCH INSTED OF THE SILDER AND
                              //selection fields
                              Container(
                                width: 120,
                                height: 48,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                                  gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        Theme.of(context).primaryColorDark,
                                        Theme.of(context).primaryColorLight,
                                      ]),
                                ),
                                child: TextButton(
                                  //TODO FLIP THE BUTON AND THE CONTAINER
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.transparent),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ))),
                                  child: const Text(
                                    'Predict',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      context
                                          .flow<PcInfo>()
                                          .complete((info) => info.copyWith(
                                                ramFrequency:
                                                    _ramFrequency.value,
                                                ssd: _ssd.value,
                                                hdd: _hdd.value,
                                                screenSize: _screenSize.value,
                                                screenRefreshRate:
                                                    _screenRefreshRate.value,
                                                screenResolution:
                                                    _screenResolution.value,
                                                state: _state.value,
                                              ));
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ])))));
  }
}

class Api2 {
  static Future<List<String>> getScreenResolution(String query) async {
    return await ["fhd", "hd", "qhd", "4k", "2k"];
  }
}
