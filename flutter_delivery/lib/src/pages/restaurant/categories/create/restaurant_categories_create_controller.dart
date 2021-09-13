import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/utils/my_snackbar.dart';

class RestaurantCategoriesCreateController {
  BuildContext context;
  Function refresh;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
  }

  void createCategory() {
    String name = nameController.text;
    String description = descriptionController.text;

    if (name.isEmpty || description.isEmpty) {
      return MySnackbar.show(context, 'Preencha todos campos');

      return;
    }
  }
}
