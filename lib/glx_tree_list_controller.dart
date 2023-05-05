import 'package:flutter/material.dart';
import 'package:flutter_glx_tree_list/glx_tree_node.dart';
import 'package:get/get.dart';

class GlxTreeListController extends GetxController with GetTickerProviderStateMixin {

  static GlxTreeListController get to => Get.find();

  final treeNode = GlxTreeNode().obs;

  var aniMilliseconds = 100;

  init(GlxTreeNode nodes) {
    _applyAnimationToChildren(nodes);
    treeNode.value = nodes;
  }

  addChild(GlxTreeNode child) {
    _addChildAnimation(child);
    treeNode.refresh();
  }

  toggleExpansion(GlxTreeNode node,{bool isExpand = true}) {
    if (node.isEmpty) {
      return;
    }
    node.isExpanded = isExpand;
    if (isExpand) {
      node.animationController!.forward();
    } else {
      node.animationController!.reverse();
    }
  }

  _addChildAnimation(GlxTreeNode node) {
    node.animationController = AnimationController(vsync: this, duration: Duration(milliseconds: aniMilliseconds));

    if (node.isExpanded) {
      node.animationController!.forward();
    }
  }

  _applyAnimationToChildren(GlxTreeNode nodes) {
    for (var node in nodes) {
      _addChildAnimation(node);
      _applyAnimationToChildren(node);
    }
  }

}