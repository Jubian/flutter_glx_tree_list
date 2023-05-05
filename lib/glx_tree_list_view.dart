
import 'package:flutter/material.dart';
import 'package:flutter_glx_tree_list/glx_tree_node.dart';
import 'package:flutter_glx_utils/widget_chain/widget_chain.dart';
import 'package:get/get.dart';
import 'glx_tree_list_controller.dart';

class GlxTreeListView<T extends GlxTreeNode> extends GetView<GlxTreeListController> {

  final Widget Function(T node) itemBuilder;

  GlxTreeListView({super.key,required this.itemBuilder,required T tileNode, int aniMilliseconds = 100}) {
    Get.put(GlxTreeListController());
    controller.aniMilliseconds = aniMilliseconds;
    controller.init(tileNode);
  }

  Widget _buildChildren(GlxTreeNode node) {
    if (node.isEmpty) {
      return Container();
    } else {
     
        var list = <Widget>[];
        for (var element in node) {
          list.add(itemBuilder(element as T));
          if (element.isNotEmpty) {
            var childrenWidget = _buildChildren(element);
            if (element.animationController != null) {
              childrenWidget = childrenWidget.intoSizeTransiton(
                sizeFactor: element.animationController!,
              );
            }
            list.add(childrenWidget);
          }
        }
        return list
        .intoColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min
        );
    
    }
  }

  @override
  Widget build(BuildContext context) {

    return Obx(() => _buildChildren(controller.treeNode.value).intoSingleChildScrollView());
  }
}