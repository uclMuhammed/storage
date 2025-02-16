// ignore_for_file: deprecated_member_use, duplicate_ignore

part of 'dashboard_view.dart';

class DashboardBody {
  final DashboardViewModel viewModel;
  DashboardBody() : viewModel = DashboardViewModel()..init();

  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<ProductMovement>>(
      valueListenable: viewModel.productMovements,
      builder: (context, productMovements, child) {
        return Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  filterWidget(context, productMovements),
                  timeFilterWidget(context),
                  lineGraphWidget(context),
                  SizedBox(height: context.smallPadding),
                  totalBarChartWidget(context),
                ],
              ),
            ),
            SizedBox(width: context.smallPadding),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  pieChartWidget(context),
                  SizedBox(height: context.smallPadding),
                  totalColumnChartWidget(context),
                ],
              ),
            ),
          ],
        ).paddingAll(context.smallPadding);
      },
    );
  }

  //toplam işlem hareketleri grafiği
  Widget totalBarChartWidget(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(
          bottom: context.smallPadding / 2,
          right: context.smallPadding / 2,
          top: context.smallPadding / 2,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(context.smallBorderRadius),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                context.myText(text: 'Toplam İşlem Hareketleri'),
              ],
            ).paddingOnly(
              left: context.smallPadding,
              bottom: context.smallPadding,
            ),
            Expanded(
              child: context.myBarChart(
                context,
                maxY: 100,
                barChartGroupData: [
                  BarChartGroupData(x: 0, barRods: [rodData(50, context)]),
                  BarChartGroupData(x: 1, barRods: [rodData(20, context)]),
                  BarChartGroupData(x: 2, barRods: [rodData(40, context)]),
                  BarChartGroupData(x: 3, barRods: [rodData(30, context)]),
                  BarChartGroupData(x: 4, barRods: [rodData(60, context)]),
                  BarChartGroupData(x: 5, barRods: [rodData(70, context)]),
                  BarChartGroupData(x: 6, barRods: [rodData(30, context)]),
                  BarChartGroupData(x: 7, barRods: [rodData(80, context)]),
                  BarChartGroupData(x: 8, barRods: [rodData(30, context)]),
                  BarChartGroupData(x: 9, barRods: [rodData(70, context)]),
                  BarChartGroupData(x: 10, barRods: [rodData(20, context)]),
                  BarChartGroupData(x: 11, barRods: [rodData(40, context)]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // işlem hareketleri grafiği
  Widget barChartWidget(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(
          bottom: context.smallPadding / 2,
          right: context.smallPadding / 2,
          top: context.smallPadding / 2,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(context.smallBorderRadius),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                context.myText(text: 'İşlem Hareketleri'),
              ],
            ).paddingOnly(
              left: context.smallPadding,
              bottom: context.smallPadding,
            ),
            Expanded(
              child: context.myBarChart(
                context,
                maxY: 100,
                barChartGroupData: [
                  BarChartGroupData(x: 0, barRods: [rodData(20, context)]),
                  BarChartGroupData(x: 1, barRods: [rodData(40, context)]),
                  BarChartGroupData(x: 2, barRods: [rodData(30, context)]),
                  BarChartGroupData(x: 3, barRods: [rodData(20, context)]),
                  BarChartGroupData(x: 4, barRods: [rodData(50, context)]),
                  BarChartGroupData(x: 5, barRods: [rodData(60, context)]),
                  BarChartGroupData(x: 6, barRods: [rodData(70, context)]),
                  BarChartGroupData(x: 7, barRods: [rodData(50, context)]),
                  BarChartGroupData(x: 8, barRods: [rodData(30, context)]),
                  BarChartGroupData(x: 9, barRods: [rodData(70, context)]),
                  BarChartGroupData(x: 10, barRods: [rodData(20, context)]),
                  BarChartGroupData(x: 11, barRods: [rodData(40, context)]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartRodData rodData(double y, BuildContext context) {
    return BarChartRodData(
      toY: y,
      color: Colors.blueAccent,
      width: 14,
      borderRadius: BorderRadius.all(Radius.circular(context.smallPadding / 4)),
      backDrawRodData: BackgroundBarChartRodData(
        show: false,
        color: Colors.blueAccent,
      ),
    );
  }
  //----------------------------------------------------------------------------

  //LİNE GRAPH WİDGET ------------------------------------------------------------
  Widget lineGraphWidget(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(
          bottom: context.smallPadding / 2,
          right: context.smallPadding / 2,
          top: context.smallPadding / 2,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(context.smallBorderRadius),
        ),
        child: Column(
          children: [
            Row(
              children: [
                context.myText(text: 'İşlem Hareketleri'),
              ],
            ).paddingOnly(
              left: context.smallPadding,
              bottom: context.smallPadding,
            ),
            Expanded(
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        const FlSpot(0, 24),
                        const FlSpot(1, 24),
                        const FlSpot(2, 40),
                        const FlSpot(3, 84),
                        const FlSpot(4, 100),
                        const FlSpot(5, 80),
                        const FlSpot(6, 64),
                        const FlSpot(7, 86),
                        const FlSpot(8, 108),
                        const FlSpot(9, 105),
                        const FlSpot(10, 105),
                        const FlSpot(11, 124),
                      ],
                      dotData: const FlDotData(show: false),
                      color: Colors.blue,
                      isCurved: true,
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.blueAccent.withOpacity(0.3),
                            Colors.blueAccent.withOpacity(0),
                          ],
                        ),
                      ),
                    ),
                  ],
                  titlesData: FlTitlesData(
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          switch (value.toInt()) {
                            case 0:
                              return context.mySmallText(text: 'Jan');
                            case 1:
                              return context.mySmallText(text: 'Feb');
                            case 2:
                              return context.mySmallText(text: 'Mar');
                            case 3:
                              return context.mySmallText(text: 'Apr');
                            case 4:
                              return context.mySmallText(text: 'May');
                            case 5:
                              return context.mySmallText(text: 'Jun');
                            case 6:
                              return context.mySmallText(text: 'Jul');
                            case 7:
                              return context.mySmallText(text: 'Aug');
                            case 8:
                              return context.mySmallText(text: 'Sep');
                            case 9:
                              return context.mySmallText(text: 'Oct');
                            case 10:
                              return context.mySmallText(text: 'Nov');
                            case 11:
                              return context.mySmallText(text: 'Dec');
                            default:
                              return context.mySmallText(text: 'not supported');
                          }
                        },
                      ),
                    ),
                  ),
                  maxY: 140,
                  minY: 0,
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  //----------------------------------------------------------------------------

  // işlem tipi, ürün seçimi, depo seçimi
  Widget filterWidget(
      BuildContext context, List<ProductMovement> productMovements) {
    return Row(
      children: [
        Expanded(
          child: context.myDropdownButtonFormField(
            labelText: 'İşlem Tipi',
            items: [
              DropdownMenuItem(
                value: TransactionType.all,
                child: context.mySmallText(text: TransactionType.all.label),
              ),
              DropdownMenuItem(
                value: TransactionType.purchase,
                child:
                    context.mySmallText(text: TransactionType.purchase.label),
              ),
              DropdownMenuItem(
                value: TransactionType.sale,
                child: context.mySmallText(text: TransactionType.sale.label),
              ),
            ],
            onChanged: (value) {
              viewModel.selectedProductMovement.value =
                  productMovements.firstWhere((e) => e == value);
            },
          ),
        ),
        SizedBox(width: context.smallPadding),
        Expanded(
          child: context.myDropdownButtonFormField(
            labelText: 'Ürün Seçiniz',
            items: productMovements
                .map(
                  (e) => DropdownMenuItem(
                    value: e.productId,
                    child: context.mySmallText(text: e.productId.toString()),
                  ),
                )
                .toList(),
            onChanged: (value) {
              viewModel.selectedProductMovement.value =
                  productMovements.firstWhere(
                (e) => e.productId == value,
              );
            },
          ),
        ),
        SizedBox(width: context.smallPadding),
        Expanded(
          child: context.myDropdownButtonFormField(
            labelText: 'Depo Seçiniz',
            items: productMovements
                .map(
                  (e) => DropdownMenuItem(
                    value: e.warehouseId,
                    child: context.mySmallText(text: e.warehouseName),
                  ),
                )
                .toList(),
            onChanged: (value) {
              viewModel.selectedProductMovement.value =
                  productMovements.firstWhere((e) => e.warehouseId == value);
            },
          ),
        ),
      ],
    );
  }
  //----------------------------------------------------------------------------

  // zaman aralığı seçimi
  Widget timeFilterWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: TimeFilterData.timeFiltersData
          .expand(
            (filter) => [
              timeFilterButtonWidget(context, filter),
              if (filter != TimeFilterData.timeFiltersData.last)
                SizedBox(width: context.smallPadding),
            ],
          )
          .toList(),
    ).paddingVertical(context.smallPadding);
  }

  Widget timeFilterButtonWidget(
      BuildContext context, TimeFilterModel timeFilter) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(context.smallBorderRadius),
        ),
        child: InkWell(
          onTap: () {},
          child: Center(
            child: context
                .mySmallText(
                    text: timeFilter.text,
                    overflow: TextOverflow.fade,
                    maxLines: 1)
                .paddingAll(
                  context.smallPadding / 2,
                ),
          ),
        ),
      ),
    );
  }
  //----------------------------------------------------------------------------

  //pasta grafiği ____ Ticari oranlar ------------------------------------------
  Widget pieChartWidget(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(context.smallBorderRadius),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  context.myText(text: 'Ticaret Oranı').paddingOnly(
                      left: context.smallPadding,
                      top: context.smallPadding / 2),
                  Expanded(
                    child: ValueListenableBuilder<int?>(
                      valueListenable: viewModel.touchedIndex,
                      builder: (context, touchedIndex, child) {
                        return PieChart(
                          key: viewModel.pieChartKey,
                          swapAnimationDuration:
                              const Duration(milliseconds: 250),
                          duration: const Duration(milliseconds: 250),
                          swapAnimationCurve: Curves.easeInOut,
                          curve: Curves.easeInOut,
                          PieChartData(
                            sectionsSpace: context.smallPadding / 2,
                            sections: MyPieChartData.pieChartData
                                .asMap()
                                .map(
                                  (index, e) => MapEntry(
                                    index,
                                    PieChartSectionData(
                                      titleStyle: context.smallTextStyle,
                                      radius:
                                          viewModel.touchedIndex.value == index
                                              ? 40
                                              : 30,
                                      value: e.value,
                                      color: e.color,
                                    ),
                                  ),
                                )
                                .values
                                .toList(),
                            pieTouchData: PieTouchData(
                              enabled: true,
                              mouseCursorResolver: (event, response) =>
                                  SystemMouseCursors.click,
                              touchCallback: (event, response) {
                                if (response?.touchedSection != null) {
                                  viewModel.touchedIndex.value = response
                                      ?.touchedSection?.touchedSectionIndex;
                                } else {
                                  viewModel.touchedIndex.value = null;
                                }
                              },
                            ),
                          ),
                        ).paddingAll(context.smallPadding);
                      },
                    ),
                  ),
                  valueContainerWidget(
                    context,
                    MyPieChartData.pieChartData
                        .map((e) => PieChartSectionData(
                              title: e.text,
                              titleStyle: context.smallTextStyle,
                              value: e.value,
                              color: e.color,
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget valueContainerWidget(
      BuildContext context, List<PieChartSectionData> p) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < p.length; i += 2)
          Expanded(
            child: Column(
              children: [
                for (int j = i; j < i + 2 && j < p.length; j++)
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(context.smallPadding / 2),
                        decoration: BoxDecoration(
                          color: p[j].color,
                          borderRadius:
                              BorderRadius.circular(context.smallBorderRadius),
                        ),
                      ),
                      SizedBox(width: context.smallPadding / 2),
                      context.mySmallText(text: p[j].title),
                    ],
                  ),
              ],
            ),
          ),
      ],
    ).paddingOnly(
      left: context.smallPadding / 2,
      right: context.smallPadding / 2,
      bottom: context.smallPadding / 2,
    );
  }
  //----------------------------------------------------------------------------

  //ilem hacmi _ sütun grafiği -------------------------------------------------
  Widget totalColumnChartWidget(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(context.smallBorderRadius),
        ),
        child: Column(
          children: [
            context.myText(text: 'İşlem Hacmi').paddingOnly(
                left: context.smallPadding, top: context.smallPadding / 2),
            Expanded(
              child: context.myBarChart(
                context,
                maxY: 200,
                barChartGroupData: [
                  BarChartGroupData(x: 0, barRods: [rodData(190, context)]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  //----------------------------------------------------------------------------
}
