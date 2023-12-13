import 'package:flutter/material.dart';

awaitPush(BuildContext context, Widget page) async {
  // Objeto? objeto = await Util.awaitPush(
  //                                   context,
  //                                   AddressScreen(
  //                                     customer: widget.customer,
  //                                   ));
  return await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

back(BuildContext context, Widget? page, data) async {
  if (Navigator.canPop(context) || page == null) {
    Navigator.pop(context, data);
  } else {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}

push(BuildContext context, Widget page) async {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

to(BuildContext context, Widget page) async {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context) => page),
  );
}
