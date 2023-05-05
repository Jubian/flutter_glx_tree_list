import 'package:flutter/material.dart';
import 'package:flutter_glx_tree_list/glx_tree_list_view.dart';
import 'package:flutter_glx_utils/widget/glx_simple_widget.dart';
import 'package:flutter_glx_utils/widget_chain/widget_chain.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body:
      GlxTreeListView<GlxDemoNode>(
        aniMilliseconds: 200,
        itemBuilder: (node) => 
          [
            Container(color: node.color,width: 50,)
            .onTap(() {node.toggleExpansion();}),
            glx_sb_w(20),
            Text('Node ${node.level} ${node.index}')
            .intoExpanded(),
            IconButton(onPressed: ()=> controller.insertChild(node), icon: const Icon(Icons.add))
          ]
          .intoRow(mainAxisSize: MainAxisSize.min)
          .intoContainer(
            margin: EdgeInsets.only(left: 20 * node.level.toDouble() + 1),
            alignment: Alignment.centerLeft,
            color: node.isSelect ? Colors.blue : Colors.grey,
            height: 40,
            width: 200
          )
          .onTap(() { 
            controller.selectIndex(node);
          }),
        tileNode: controller.treeNode,
        )
      );
  }
}
