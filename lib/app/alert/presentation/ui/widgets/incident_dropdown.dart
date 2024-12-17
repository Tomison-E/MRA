import 'package:mra/app/alert/data/models/incident.dart';
import 'package:mra/src/components/margin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class IncidentDropdownButton extends StatefulWidget {
  final ValueChanged<IncidentType?> onChanged;
  const IncidentDropdownButton({super.key, required this.onChanged});

  @override
  State<IncidentDropdownButton> createState() => _IncidentDropdownButtonState();
}

class _IncidentDropdownButtonState extends State<IncidentDropdownButton> {
  ValueNotifier<IncidentType?> incidentType = ValueNotifier(null);
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: ValueListenableBuilder<IncidentType?>(
          valueListenable: incidentType,
          builder: (context, type, _) {
            return DropdownButton<IncidentType>(
                value: type,
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                items: IncidentType.values
                    .map(
                      (e) => DropdownMenuItem<IncidentType>(
                        value: e,
                        child: Row(
                          children: [
                            SvgPicture.asset(e.iconPath),
                            RowSpacing(16.w),
                            Text(e.capsName)
                          ],
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (type) {
                  widget.onChanged(type);
                  incidentType.value = type;
                });
          }),
    );
  }

  @override
  void dispose() {
    incidentType.dispose();
    super.dispose();
  }
}
