import 'package:flutter/material.dart';
import 'package:flutter_glx_tree_list/glx_tree_list_controller.dart';
import 'package:get/get.dart';

// class GlxTreeNode {
//   GestureTapCallback? onExpansionChanged;
//   String treeId = '';
//   int level = 0;
//   int index = 0;
//   bool isExpanded = false;
//   AnimationController? animationController;
//   GlxTreeList children = GlxTreeList();
// }

// ignore: constant_identifier_names
const GLX_TREE_NODE_SPLIT = ':'; //树节点分隔符


class GlxTreeNode extends Iterable<GlxTreeNode> {

  // Widget? _expandArrow;
  // Widget? _content;
  // List<Widget>? _trailing;

  // Widget? get expandArrow => _expandArrow;
  // Widget? get content => _content;
  // List<Widget>? get trailing => _trailing;
  // int level;
  // int index;

  


  GlxTreeNode? parent;
  bool isExpanded = true;

  //动画控制器
  AnimationController? animationController;

  int? _level;

  List<GlxTreeNode> children = [];

  int get level {
    _level ??= treeId.split(GLX_TREE_NODE_SPLIT).length - 1;
    return _level!;
  }

  String get treeId {
    if (parent != null) {
      if (parent!.index == -1) {
        return index.toString();
      } else {
        return '${parent!.treeId}:$index';
      }
    } 
    return '';
  }

  int get index {
    if (parent != null) {
      return parent!.children.indexOf(this);
    }
    return -1;
  }

  @override
  Iterator<GlxTreeNode> get iterator => children.iterator;
  
  void operator []=(int index, GlxTreeNode value) {
    insertChild(index, value);
  }

  GlxTreeNode? operator [](dynamic idOrIndex) {
    if (idOrIndex is int && index < children.length) {
      return children[index];
    } else if (idOrIndex is String) {
      List<String> treeIdList = idOrIndex.split(GLX_TREE_NODE_SPLIT);
      return _getNodeByTreeId(this, treeIdList, 0);
    } else {
      return null;
    }
  }
  
  /// 通过树节点id获取节点
  GlxTreeNode? _getNodeByTreeId(GlxTreeNode? currentNode, List<String> treeIdList, int depth) {
    if (treeIdList.isEmpty || currentNode == null) {
      return null;
    }

    final index = int.tryParse(treeIdList[depth]);

    if (index == null || index >= currentNode.length) {
      return null;
    }

    if (depth == treeIdList.length - 1) {
      return currentNode[index];
    } else {
      return _getNodeByTreeId(currentNode[index], treeIdList, depth + 1);
    }
  }

  // 添加子节点
  void addChild(GlxTreeNode child,{bool isExpandChild = true}) {
    child.parent = this;
    children.add(child);
    if (GetInstance().isRegistered<GlxTreeListController>()) {
      GlxTreeListController.to.toggleExpansion(this, isExpand: isExpandChild);
      GlxTreeListController.to.addChild(child);
    }
  }

  // 插入子节点
  void insertChild(int index, GlxTreeNode child,{bool isExpandChild = true}) {
    child.parent = this;
    children.insert(index, child);
    if (GetInstance().isRegistered<GlxTreeListController>()) {
      GlxTreeListController.to.toggleExpansion(this, isExpand: isExpandChild);
      GlxTreeListController.to.addChild(child);
    }
  }

  // 刷新node
  void changeValue<T extends GlxTreeNode>(ValueChanged<T> valueChange) {
    valueChange(this as T);
    if (GetInstance().isRegistered<GlxTreeListController>()) {
      GlxTreeListController.to.treeNode.refresh();
    }
  }

  // 展开收起子节点
  void toggleExpansion() {
    if (GetInstance().isRegistered<GlxTreeListController>()) {
      GlxTreeListController.to.toggleExpansion(this,isExpand: !isExpanded);
    }
  }
  
}



// class GlxWidgetTreeNode extends GlxTreeBaseNode {
//   @override
//   final int level;
//   @override
//   final int index;

//   // 伸缩右箭头
//   final String? arrowImg;
//   double arrowSize;

//   // wieget图片和名称
//   final String widgetImg;
//   final double widgetImgSize;
//   final String widgetName;
//   final TextStyle widgetNameStyle;

//   // 是否展示的图标
//   bool isVisible = true;
//   final String showIcon;
//   final String hideIcon;
//   final double visableIconSize;
//   final Color hideColor;


//   GlxWidgetTreeNode({
//     required this.level, 
//     required this.index,
//     required this.showIcon,
//     required this.hideIcon,
//     required this.visableIconSize,
//     required this.hideColor,
//     required this.widgetImg,
//     required this.widgetName,
//     required this.widgetImgSize,
//     required this.widgetNameStyle,
//     this.arrowImg, 
//     this.arrowSize = 20, 
//   });

//   @override
//   Widget get expandArrow {
//     if (arrowImg == null) {
//       _expandArrow ??= Icon(Icons.arrow_right,size: arrowSize);
//     } else {
//       _expandArrow ??= Image.asset(arrowImg!,width: arrowSize);
//     }
//     return _expandArrow!;
//   }

//   @override
//   Widget get content {
//     _content ??= [
//       Image.asset(
//         widgetImg,
//         width: 20,
//         height: 20,
//         color: isVisible ? null : hideColor,
//       ).intoPadding(padding: const EdgeInsets.only(right: 5)),

//       Text(
//         widgetName,
//         style: widgetNameStyle.copyWith(
//           color: isVisible ? null : hideColor
//         )
//       ).intoExpanded(),
//     ]
//     .intoRow();
//     return _content!;
//   }
  
//   @override
//   List<Widget> get trailing {
//     _trailing ??= [
//       Image.asset(
//         isVisible ? showIcon : hideIcon,
//         width: visableIconSize,
//         color: isVisible ? null : hideColor,
//       )
//       .onTap(()=> trailingAction?.call(0))
//     ];
//     return _trailing!;
//   }

// }
