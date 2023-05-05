import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_glx_tree_list/flutter_glx_tree_list.dart';

class GlxDemoNode extends GlxTreeNode {
 
  final Color? color;
  bool isSelect;

  GlxDemoNode({
    this.color,
    this.isSelect = false
  });
  
}

class HomeController extends GetxController {

  late GlxDemoNode treeNode;
  final backColors = Colors.blue.obs;

  @override
  void onInit() {
    super.onInit();
    treeNode = GlxDemoNode();
    for (var i = 0; i < 3; i++) {
      treeNode.addChild(_generateTreeNodes(i, 0, treeNode));
    }
  }

  Color getRandomColor() {
    final Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256), // Red
      random.nextInt(256), // Green
      random.nextInt(256), // Blue
      1, // Opacity
    );
  }

  GlxDemoNode _generateTreeNodes(int index, int level,GlxDemoNode? parent) {
    final node = GlxDemoNode(
      color: getRandomColor()
    );
    if (level < 2) {
      for (var i = 0; i < 3; i++) {
      node.addChild(_generateTreeNodes(i, level + 1,node));
    }
    }
    return node;
  }

  selectIndex(GlxDemoNode node) {
    debugPrint('treeid:${node.treeId},level:${node.level},index:${node.index}');
    node.changeValue<GlxDemoNode>((value) {
      value.isSelect = !value.isSelect;
    });
  }

  insertChild(GlxDemoNode parent) {
    parent.insertChild(0,GlxDemoNode(color: getRandomColor()));
  }
  
}
