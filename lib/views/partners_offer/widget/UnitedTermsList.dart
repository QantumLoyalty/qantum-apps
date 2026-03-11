import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/view_models/UnitedFuelsProvider.dart';
import '/core/navigation/AppNavigator.dart';
import 'package:url_launcher/url_launcher.dart';

class UnitedTermsList extends StatelessWidget {
  const UnitedTermsList({super.key});

  final String htmlData = """
<ul>
<li>
<p>By using this fuel discount barcode, you agree that you have read and accepted United's 
<a href="https://fueldiscountcards.unitedpetroleum.com.au/storage/card_entities/uXnrN8iKRzGciDcU.pdf">terms and conditions</a>.
</p>
</li>
<li>
<p>This barcode can only be used once a day, for up to 150 litres.</p>
</li>
<li>
<p>A new barcode is generated daily at 12.01am local time and is valid for 24 hours.</p>
</li>
<li>
<p>This barcode cannot be used at United unmanned/self-serve locations.</p>
</li>
<li>
<p>For further assistance contact 
<a href="tel:1300383587">1300 383 587</a>.
</p>
</li>
</ul>
""";

  @override
  Widget build(BuildContext context) {
    return Consumer<UnitedFuelsProvider>(builder: (context,provider,child){

      if(provider.termsAndConditions!=null)
        {
          return Html(
            data: provider.termsAndConditions,
            onLinkTap: (url, _, __) async {
              try {
                if (url == null) return;

                if (url.startsWith("tel:")) {
                  final Uri phoneUri = Uri(
                    scheme: 'tel',
                    path: url.replaceFirst("tel:", ""),
                  );

                  await launchUrl(phoneUri);
                } else {
                  final Uri uri = Uri.parse(url);
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              } catch (e) {
                print("Error launching URL: $e");
              }
            },
          );
        }

      return const SizedBox.shrink();
    });
  }
}
