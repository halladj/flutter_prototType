import 'package:flutter/material.dart';
import "package:proto/theme.dart";
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';

class SelectionField extends HookWidget {
  SelectionField({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  String label;
  var value;

  @override
  Widget build(BuildContext context) {
    final _state = useState<String?>("used");

    // return Column(
    //   children: [
    //     ChoiceChip(
    //       label: Text('item index'),
    //       selected: _state.value == "new",
    //       onSelected: (bool selected) {
    //         _state.value = selected ? "new": null;
    //       },
    //     ),
    //     ChoiceChip(
    //       label: Text('item index'),
    //       selected: _state.value == "used",
    //       onSelected: (bool selected) {
    //         _state.value = selected ? "used": null;
    //       },
    //     ),
    //   ],
    // );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.only(top:14,bottom:4),
            child: Text(label,
            style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.blueGrey.withOpacity(0.8),),)),
        Wrap(
          spacing: 15.0,
          children: [
            ChoiceChip(
              //selectedColor: CustomColors.buttonHighlightColor,
              selectedColor: Theme.of(context).primaryColorLight,
              disabledColor: Theme.of(context).scaffoldBackgroundColor,
              selected: _state.value == "used",
              label: const Text("Used", style: TextStyle(color: Colors.white, fontSize: 16.0)),
              onSelected: (selected) {
                _state.value = selected ? "used" : null;
                value.value = "used";
              },
            ),
            ChoiceChip(
              //selectedColor: CustomColors.buttonHighlightColor,
              selectedColor: Theme.of(context).primaryColorLight,
              disabledColor: Theme.of(context).scaffoldBackgroundColor,
              selected: _state.value == "new",
              label: const Text("New", style: TextStyle(color: Colors.white,fontSize: 16)),
              onSelected: (bool selected) {
                _state.value = selected ? "new" : null;
                value.value = "new";
              },
            ),
          ],
        ),
      ],
    );
  }
}
