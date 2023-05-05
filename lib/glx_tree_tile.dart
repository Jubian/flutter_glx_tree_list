
import 'package:flutter/material.dart';
import 'package:flutter_glx_utils/extension/list_util.dart';
import 'package:flutter_glx_utils/widget/glx_simple_widget.dart';
import 'package:flutter_glx_utils/widget_chain/widget_chain.dart';
import 'glx_tree_node.dart';

// abstract class GlxTreeTile extends StatelessWidget {
//   const GlxTreeTile({super.key});

//   GlxTreeNode? get treeNode;
 
// }

// class GlxWidgetTreeTile extends GlxTreeTile {

//   @override
//   final GlxTreeNode treeNode;

//   const GlxWidgetTreeTile({super.key,required this.treeNode});

//     Widget expandArrow {
    
//       _expandArrow ??= Image.asset(arrowImg!,width: arrowSize);
//     }
//     return _expandArrow!;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return [
//       glx_sb_w(22.5 * treeNode.level),
//       treeNode.expandArrow
//         .intoPadding(padding: const EdgeInsets.only(right: 5))
//         .intoOpacity(opacity: ListUtil.isNotEmpty(treeNode.children) ? 0.0 : 1.0)
//         .onTap(ListUtil.isNotEmpty(treeNode.children)? null : treeNode.onExpansionChanged),
//       treeNode.content,
//       ...treeNode.trailing
//     ]
//     .intoRow()
//     .intoContainer(
//       color: Colors.transparent,
//       padding: const EdgeInsets.symmetric(horizontal: 5),
//       height: 35,
//       margin: const EdgeInsets.symmetric(horizontal: 10),
//     )
//     .intoGestureDetector(
//       onTap: treeNode.onSelect,
//       onSecondaryTapDown: treeNode.onSecondaryTapDown
//     );
//   }
// }