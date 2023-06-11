import 'dart:math';

import 'package:arfriendv2/utils/app_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WebPagination extends StatefulWidget {
  final int currentPage;
  final int totalPage;
  final ValueChanged<int> onPageChanged;
  final int displayItemCount;
  const WebPagination({
    Key? key,
    required this.onPageChanged,
    required this.currentPage,
    required this.totalPage,
    this.displayItemCount = 11,
  }) : super(key: key);

  @override
  _WebPaginationState createState() => _WebPaginationState();
}

class _WebPaginationState extends State<WebPagination> {
  late int currentPage = widget.currentPage;
  late int totalPage = widget.totalPage;
  late int displayItemCount = widget.displayItemCount;
  late TextEditingController controller = TextEditingController();

  @override
  void didUpdateWidget(covariant WebPagination oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.currentPage != widget.currentPage ||
        oldWidget.totalPage != widget.totalPage) {
      setState(() {
        currentPage = widget.currentPage;
        totalPage = widget.totalPage;
      });
    }
  }

  void _updatePage(int page) {
    setState(() {
      currentPage = page;
    });
    widget.onPageChanged(page);
  }

  List<Widget> _buildPageItemList() {
    List<Widget> widgetList = [];
    widgetList.add(_PageControlButton(
      enable: currentPage > 1,
      title: '«',
      onTap: () {
        _updatePage(currentPage - 1);
      },
    ));

    var leftPageItemCount = (displayItemCount / 2).floor();

    var rightPageItemCount = max(0, displayItemCount - leftPageItemCount - 1);

    int startPage = max(
        1,
        currentPage -
            max(leftPageItemCount,
                (displayItemCount - totalPage + currentPage - 1)));

    for (; startPage <= currentPage; startPage++) {
      widgetList.add(_PageItem(
        page: startPage,
        isChecked: startPage == currentPage,
        onTap: (page) {
          _updatePage(page);
        },
      ));
    }

    int endPage =
        min(totalPage, max(displayItemCount, currentPage + rightPageItemCount));

    for (; startPage <= endPage; startPage++) {
      widgetList.add(_PageItem(
        page: startPage,
        isChecked: startPage == currentPage,
        onTap: (page) {
          _updatePage(page);
        },
      ));
    }

    widgetList.add(_PageControlButton(
      enable: currentPage < totalPage,
      title: '»',
      onTap: () {
        _updatePage(currentPage + 1);
      },
    ));
    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          alignment: Alignment.center,
          height: 35,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade300,
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: AppText.labelW500(
            currentPage.toString(),
            14,
            Colors.black,
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        AppText.labelW500(
          "dari",
          14,
          Colors.black,
        ),
        const SizedBox(
          width: 8,
        ),
        AppText.labelW500(
          totalPage.toString(),
          14,
          Colors.black,
        ),
        const SizedBox(
          width: 8,
        ),
        InkWell(
          onTap: currentPage <= 1
              ? null
              : () {
                  _updatePage(currentPage - 1);
                },
          child: Container(
            alignment: Alignment.center,
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: currentPage > 1
                  ? const Color(0xFFE5E6E9)
                  : const Color(0xFFF1F2F4),
            ),
            child: Text(
              '«',
              style: GoogleFonts.sourceSansPro(
                fontSize: 18,
                color: currentPage > 1 ? Colors.black : Colors.grey.shade400,
              ),
            ),
          ),
        ),
        InkWell(
          onTap: currentPage >= totalPage
              ? null
              : () {
                  _updatePage(currentPage + 1);
                },
          child: Container(
            alignment: Alignment.center,
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: currentPage < totalPage
                  ? const Color(0xFFE5E6E9)
                  : const Color(0xFFF1F2F4),
            ),
            child: Text(
              '»',
              style: GoogleFonts.sourceSansPro(
                fontSize: 18,
                color: currentPage < totalPage
                    ? Colors.black
                    : Colors.grey.shade400,
              ),
            ),
          ),
        ),
        // ..._buildPageItemList(),
      ],
    );
  }
}

class _PageControlButton extends StatefulWidget {
  final bool enable;
  final String title;
  final VoidCallback onTap;
  const _PageControlButton(
      {Key? key,
      required this.enable,
      required this.title,
      required this.onTap})
      : super(key: key);

  @override
  _PageControlButtonState createState() => _PageControlButtonState();
}

class _PageControlButtonState extends State<_PageControlButton> {
  Color normalTextColor = const Color(0xFF0175C2);
  late Color textColor = widget.enable ? normalTextColor : Colors.grey.shade600;

  @override
  void didUpdateWidget(_PageControlButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.enable != widget.enable) {
      setState(() {
        textColor = widget.enable ? normalTextColor : Colors.grey.shade600;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: widget.enable ? widget.onTap : null,
        onHover: (b) {
          if (!widget.enable) return;
          setState(() {
            textColor = b ? normalTextColor.withAlpha(200) : normalTextColor;
          });
        },
        child: _ItemContainer(
            backgroundColor: Colors.white70,
            child: Text(
              widget.title,
              style: TextStyle(color: textColor, fontSize: 14),
            )));
  }
}

class _PageItem extends StatefulWidget {
  final int page;
  final bool isChecked;
  final ValueChanged<int> onTap;
  const _PageItem(
      {Key? key,
      required this.page,
      required this.isChecked,
      required this.onTap})
      : super(key: key);

  @override
  __PageItemState createState() => __PageItemState();
}

class __PageItemState extends State<_PageItem> {
  Color normalBackgroundColor = const Color(0xFFF3F3F3);
  Color normalHighlightColor = const Color(0xFF0175C2);

  late Color backgroundColor = normalBackgroundColor;
  late Color highlightColor = normalHighlightColor;

  @override
  void didUpdateWidget(covariant _PageItem oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isChecked != widget.isChecked) {
      if (!widget.isChecked) {
        setState(() {
          backgroundColor = normalBackgroundColor;
          highlightColor = normalHighlightColor;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onHover: (b) {
          if (widget.isChecked) return;
          setState(() {
            backgroundColor =
                b ? const Color(0xFFEAEAEA) : normalBackgroundColor;
            highlightColor = b ? const Color(0xFF077BC6) : normalHighlightColor;
          });
        },
        onTap: () {
          widget.onTap(widget.page);
        },
        child: _ItemContainer(
          backgroundColor: widget.isChecked ? highlightColor : backgroundColor,
          child: Text(
            widget.page.toString(),
            style: TextStyle(
                color: widget.isChecked ? Colors.white : highlightColor,
                fontWeight: FontWeight.w600,
                fontSize: 14),
          ),
        ));
  }
}

class _ItemContainer extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  const _ItemContainer(
      {Key? key, required this.child, required this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(4)),
      child: child,
    );
  }
}
