import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetrek/constants/text_styles.dart';
import 'package:wetrek/repositories/authentication_repository.dart';
import 'package:wetrek/screens/map_screen.dart';
import 'package:wetrek/widgets/widgets.dart';

class TermsScreen extends StatefulWidget {
  static MaterialPageRoute route() {
    return MaterialPageRoute(
      builder: (context) => TermsScreen(),
    );
  }

  @override
  _TermsScreenState createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Terms of Use',
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'These terms of service constitute an agreement (the “Agreement”) between you and WeTrek. (“WeTrek”, “we,” “us” or “our”) governing your use of the WeTrek application, website.',
                style: TextStyles.darkNormal,
              ),
              Text('Accepting Terms of Use', style: TextStyles.darkLarge),
              SizedBox(height: 21),
              Text(
                'IMPORTANT: BY USING THIS SERVICE, YOU AGREE THAT YOU HAVE READ, UNDERSTOOD, ACCEPTED AND AGREED WITH THESE TERMS AND CONDITIONS. YOU FURTHER AGREE TO THE REPRESENTATIONS MADE BY YOURSELF BELOW. IF YOU DO NOT AGREE TO OR FALL WITHIN THE TERMS OF USE OF THE SERVICE (AS DEFINED BELOW) AND WISH TO DISCONTINUE USING THE SERVICE, PLEASE DO NOT CONTINUE USING THIS APPLICATION OR SERVICE.',
                style: TextStyles.darkNormal,
              ),
              SizedBox(height: 23),
              Text(
                'The terms and conditions stated herein (collectively, the “Terms of Use” or this “Agreement”) constitute a legal agreement between you and WeTrek and its subsidiaries and affiliates (“WeTrek”). In order to use the Service (each as defined below) you must agree to the Terms of Use that are set out below. By using the mobile applications and websites supplied to you by WeTrek (the  “Application”), and downloading, installing or using any associated software supplied by WeTrek (the “Software”) which overall purpose is to enable persons seeking tourism/trekking services to certain destinations to be matched together, you hereby expressly acknowledge and agree to be bound by the Terms of Use, and any future amendments and additions to this Terms of Use as published from time to time through the Application.',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),
              Text(
                ' WeTrek reserves the right to modify, vary and change the Terms of Use or its policies relating to the Service at any time as it deems fit. Such modifications, variations and or changes to the Terms of Use or its policies relating to the Service shall be effective upon the posting of an updated version at the Application. You agree that it shall be your responsibility to review the Terms of Use regularly and also the Terms of Use applicable to any country where you use the Service whereupon the continued use of the Service after any such changes, whether or not reviewed by you, shall constitute your consent and acceptance to such changes. You further agree that usage of the Service in the Alternate Country shall be subject to the Terms of Use prevailing for the Alternate Country which can be found at Application.',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),
              Text(
                'Each adventure service provided by both parties (trekkers) shall constitute a separate agreement between such persons. WeTrek is a tourism innovative company that does not provide tourism services directly. The service of the company is to link you with trekkers who share the same level of interests. The company is not responsible nor liable for the acts and/or omissions of any third party service provider and/or any services provided to you.',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),
              Text('Eligibility', style: TextStyles.darkNormal),
              SizedBox(height: 21),
              Text(
                'By using the Service, you expressly represent and warrant that you are legally entitled to accept and agree to the Terms of Use and that you are at least eighteen (18) years old. Without limiting the generality of the foregoing, the Service is not available to persons under the age of eighteen (18) or such persons that are forbidden for any reason whatsoever to enter into a contractual relationship. By using the Service, you further represent and warrant that you have the right, authority and capacity to use the Service and to abide by the Terms of Use. You further confirm that all the information which you provide shall be true and accurate. Your use of the Service is for your own sole, personal use. You undertake not to authorize others to use your identity or user status, and you may not assign or otherwise transfer your user account to any other person or entity. When using the Service you agree to comply with all applicable laws whether in your home nation or otherwise in the country, state and city in which you are present while using the Service.',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),
              Text(
                'You may only access the Service using authorized means. It is your responsibility to check and ensure that you have downloaded the correct Software for your device. WeTrek is not liable if you do not have a compatible device or if you have downloaded the wrong version of the Software to your device. WeTrek reserves the right not to permit you to use the Service should you use the Application and/or the Software with an incompatible or unauthorized device or for purposes other than which the Software and/or the Application is intended to be used.',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),
              Text(
                'License Grant and Restrictions',
                style: TextStyles.darkNormal,
              ),
              SizedBox(height: 16),
              Text(
                'WeTrek and its licensors, where applicable, hereby grants you a revocable, non-exclusive, non- transferable, non-assignable, personal, limited license to use the Application and/or the Software, solely for your own personal, non-commercial purposes, subject to the Terms of Use herein. All rights not expressly granted to you are reserved by WeTrek and its licensors.',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),
              Text(
                'You shall not (I) license, sublicense, sell, resell, transfer, assign, distribute or otherwise commercially exploit or make available to any third party the Application and/or the Software in any way; (II) modify or make derivative works based on the Application and/or the Software; (III) create internet “links” to the Application or “frame” or “mirror” any Software on any other server or wireless or internet-based device; (IV) reverse engineer or access the Software in order to (a) build a competitive product or service, (b) build a product using similar ideas, features, functions or graphics of the Application and/or the Software, or (c) copy any ideas, features, functions or graphics of the Application and/or the Software, (v) launch an automated program or script, including, but not limited to, web spiders, web crawlers, web robots, web ants, web indexers, bots, viruses or worms, or any program which may make multiple server requests per second, or unduly burdens or hinders the operation and/or performance of the Application and/or the Software, (V) use any robot, spider, site search/retrieval application, or other manual or automatic device or process to retrieve, index, “data mine”, or in any way reproduce or bypass the navigational structure or presentation of the Services or its contents; (VI) post, distribute or reproduce in any way any copyrighted material, trademarks, or other proprietary information without obtaining the prior consent of the owner of such proprietary rights, (VII) remove any copyright, trademark or other proprietary rights notices contained in the Service.',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),
              Text(
                'You may use the Software and/or the Application only for your personal purpose and shall not use the Software and/or the Application to: (i) send spam or otherwise duplicative or unsolicited messages; (ii) send or store infringing, obscene, threatening, libelous, or otherwise unlawful or tortious material, including but not limited to materials harmful to children or violative of third party privacy rights; (iii) send material containing software viruses, worms, trojan horses or other harmful computer code, files, scripts, agents or programs; (iv) interfere with or disrupt the integrity or performance of the Software and/or the Application or the data contained therein; (v) attempt to gain unauthorized access to the Software and/or the Application or its related systems or networks; or (vi) impersonate any person or entity or otherwise misrepresent your affiliation with a person or entity (vii) to abstain from any conduct that could possibly damage the Company’s reputation or amount to being disreputable.',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),
              Text(
                'Intellectual Property Ownership',
                style: TextStyles.darkNormal,
              ),
              SizedBox(height: 16),
              Text(
                'THE SERVICE CONTAINS CONTENT (SUCH AS DESIGN, IMAGES, SOUNDS, TEXTS, DATABASES, COMPUTER CODES, REGISTERED AND UNREGISTERED TRADEMARKS AND OTHER SIMILAR OBJECTS) OWNED OR LICENSED BY WETREK, WHICH IS PROTECTED BY COPYRIGHT, TRADEMARK, PATENT, TRADE SECRET AND OTHER LAWS. WETREK AND ITS LICENSORS, WHERE APPLICABLE, SHALL OWN ALL RIGHTS, TITLE AND INTEREST, INCLUDING ALL RELATED INTELLECTUAL PROPERTY RIGHTS, IN AND TO THE SOFTWARE AND/OR THE APPLICATION AND BY EXTENSION, THE SERVICE AND ANY SUGGESTIONS, IDEAS, ENHANCEMENT REQUESTS, FEEDBACK, RECOMMENDATIONS OR OTHER INFORMATION PROVIDED BY YOU OR ANY OTHER PARTY RELATING TO THE SERVICE. THE TERMS OF USE DO NOT CONSTITUTE A SALE AGREEMENT AND DO NOT CONVEY TO YOU ANY RIGHTS OF OWNERSHIP IN OR RELATED TO THE SERVICE, SOFTWARE AND/OR THE APPLICATION, OR ANY INTELLECTUAL PROPERTY RIGHTS OWNED BY WETREK AND/OR ITS LICENSORS. WETREK NAME, LOGO, THE SERVICE, THE SOFTWARE AND/OR THE APPLICATION AND THE PRODUCT NAMES ASSOCIATED WITH THE SOFTWARE AND/OR THE APPLICATION ARE TRADEMARKS OF WETREK OR THIRD PARTIES, AND NO RIGHT OR LICENSE IS GRANTED TO USE THEM. FOR THE AVOIDANCE OF DOUBT, THE TERM SOFTWARE AND APPLICATION HEREIN SHALL INCLUDE ITS RESPECTIVE COMPONENTS, PROCESSES AND DESIGN IN ITS ENTIRETY.',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),
              Text(
                'Restricted Activities',
                style: TextStyles.darkNormal,
              ),
              SizedBox(height: 16),
              Text(
                'With respect to your use of WeTrek and your participation in the Services, you agree that you will not:',
                style: TextStyles.terms,
              ),
//              SizedBox(height: 16),

              SizedBox(height: 16),
              ListItem(
                bullet: Text('a'),
                text: 'impersonate any person or entity;',
              ),
              SizedBox(height: 16),
              ListItem(
                bullet: Text('b'),
                text:
                    'stalk, threaten, or otherwise harass any person, or carry any weapons;',
              ),
              SizedBox(height: 16),
              ListItem(
                bullet: Text('c'),
                text: 'violate any law, statute, ordinance or regulation;',
              ),
              SizedBox(height: 16),
              ListItem(
                bullet: Text('d'),
                text:
                    'interfere with or disrupt the Services or the servers or networks connected to WeTrek;',
              ),
              SizedBox(height: 16),
              ListItem(
                bullet: Text('e'),
                text:
                    'post Information or interact on Wetrek App or Services in a manner which is false, inaccurate, misleading (directly or by omission or failure to update information), defamatory, libelous, abusive, obscene, profane, offensive, sexually oriented, threatening, harassing, or illegal;',
              ),
              SizedBox(height: 16),
              ListItem(
                bullet: Text('f'),
                text:
                    'use WeTrek in any way that infringes any third party’s rights, including but not limited to: intellectual property rights, copyright, patent, trademark, trade secret or other proprietary rights or rights of publicity or privacy;',
              ),
              SizedBox(height: 16),
              ListItem(
                bullet: Text('g'),
                text:
                    'post, email or otherwise transmit any malicious code, files or programs designed to interrupt, damage, destroy or limit the functionality of any computer software or hardware or telecommunications equipment or surreptitiously intercept or expropriate any system, data or personal information;',
              ),
              SizedBox(height: 16),
              ListItem(
                bullet: Text('h'),
                text:
                    'forge headers or otherwise manipulate identifiers in order to disguise the origin of any information transmitted through the WeTrek;',
              ),
              SizedBox(height: 16),
              ListItem(
                bullet: Text('i'),
                text:
                    'modify, adapt, translate, reverse engineer, decipher, decompile or otherwise disassemble any portion of Software or any software used on or for WeTrek;',
              ),
              SizedBox(height: 16),
              ListItem(
                bullet: Text('j'),
                text:
                    'rent, lease, lend, sell, redistribute, license or sublicense inDriver App and the Site or access to any portion of WeTrek;',
              ),
              SizedBox(height: 16),
              ListItem(
                bullet: Text('k'),
                text:
                    'use any robot, spider, site search/retrieval application, or other manual or automatic device or process to retrieve, index, scrape, “data mine”, or in any way reproduce or bypass the navigational structure or presentation of WeTrek or its contents;',
              ),
              SizedBox(height: 16),
              ListItem(
                bullet: Text('l'),
                text:
                    'create liability for us or cause us to become subject to regulation as a company or provider of tourism service;',
              ),
              SizedBox(height: 16),
              ListItem(
                bullet: Text('m'),
                text: 'link directly or indirectly to any other web sites;',
              ),
              SizedBox(height: 16),
              ListItem(
                bullet: Text('n'),
                text:
                    'transfer or sell your User account, password and/or identification to any other party; or',
              ),
              SizedBox(height: 16),
              ListItem(
                bullet: Text('o'),
                text:
                    'cause any third party to engage in the restricted activities above.',
              ),
              SizedBox(height: 16),
              Text(
                'Confidentiality',
                style: TextStyles.darkNormal,
              ),
              SizedBox(height: 16),
              Text(
                'You shall maintain in confidence all information and data relating to WeTrek, its services, products, business affairs, marketing and promotion plans or other operations and its associated companies which are disclosed to you by or on behalf of WeTrek (whether orally or in writing and whether before, on or after the date of this Agreement) or which are otherwise directly or indirectly acquired by you from WeTrek, or any of its affiliated companies, or created in the course of this Agreement. You shall further ensure that its officers, employees and agents only use such confidential information in order to perform the Services, and shall not without the WeTrek’s prior written consent, disclose such information to any third-party nor use it for any other purpose. You shall only disclose such information to such officers, employees and agents as need to know it to fulfil its obligations under this Agreement. ',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),
              Text(
                'You agree to take all reasonable measures to protect the secrecy of and avoid disclosure or use of Confidential Information of WeTrek in order to prevent it from falling into the public domain. Notwithstanding the above, you shall not have liability to WeTrek with regard to any Confidential Information which you can prove: was in the public domain at the time it was disclosed by WeTrek or has entered the public domain through no fault of yours; was known to you, without restriction, at the time of disclosure, as demonstrated by files in existence at the time of disclosure; is disclosed with the prior written approval of WeTrek; becomes known to you, without restriction, from a source other than WeTrek without breach of this Agreement by you and otherwise not in violation of WeTrek’s rights; or is disclosed pursuant to the order or requirement of a court, administrative agency, or other governmental body; provided, however, that you shall provide prompt notice of such court order or requirement to WeTrek to enable WeTrek to seek a protective order or otherwise prevent or restrict such disclosure.',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),
              Text(
                'Personal Data Protection',
                style: TextStyles.darkNormal,
              ),
              SizedBox(height: 16),
              Text(
                'You agree and consent to WeTrek using and processing your Personal Data for the Purposes and in the manner as identified hereunder.',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),
              Text(
                'For the purposes of this Agreement, “Personal Data” means information about you, from which you are identifiable, including but not limited to your name, identification card number, address, telephone number, credit or debit card details, gender, date of birth, email address, any information about you which you have provided to WeTrek in registration forms, application forms or any other similar forms and/or any information about you that has been or may be collected, stored, used and processed by WeTrek from time to time and includes sensitive personal data.',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),
              Text(
                'The provision of your Personal Data is voluntary. However, if you do not provide WeTrek with your Personal Data, your access to the Application may be incomplete and WeTrek will not be able to process your Personal Data for the Purposes outlined below and may cause WeTrek to be unable to allow you to use the Service.',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),
              Text(
                'You agree that WeTrek may send you push notifications and e-mails, contact you by telephone or text messages (including by an automatic telephone dialing system) at any of the phone numbers provided by you or on your behalf in connection with an WeTrek account, including for marketing purposes. You understand that you are not required to provide this consent as a condition of purchasing any property, goods or services.',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),
              Text(
                'Collection and use of Personal Data in connection with the Services is described in WeTrek Privacy Policy',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),
              Text(
                'Compensation',
                style: TextStyles.darkNormal,
              ),
              SizedBox(height: 16),
              Text(
                'By agreeing to the Terms of Use upon using the Service, you agree that you shall defend, compensate and hold WeTrek, its officers, directors, members, employees, attorneys and agents harmless from and against any and all claims, costs, damages, losses, liabilities and expenses (including attorneys’ fees and costs) arising out of or in connection with: (a) your use of the Service, Software and/or the Application, third party providers, partners, advertisers and/or sponsors, or (b) your violation or breach of any of the Terms of Use or any applicable law or regulation, whether or not referenced herein or (c) your violation of any rights of any third party, or (d) your use or misuse of the Service, Software and/or the Application',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),
              Text(
                'Disclaimer of Warranties',
                style: TextStyles.darkNormal,
              ),
              SizedBox(height: 16),
              Text(
                'WETREK MAKES NO REPRESENTATION, WARRANTY, OR GUARANTEE AS TO THE RELIABILITY, TIMELINESS, QUALITY, SUITABILITY, AVAILABILITY, ACCURACY OR COMPLETENESS OF THE SERVICES, APPLICATION AND/OR THE SOFTWARE. WETREK DOES NOT REPRESENT OR WARRANT THAT (A) THE USE OF THE SERVICE, APPLICATION AND/OR THE SOFTWARE WILL BE SECURE, TIMELY, UNINTERRUPTED OR ERROR-FREE OR OPERATE IN COMBINATION WITH ANY OTHER HARDWARE, SOFTWARE, SYSTEM OR DATA, (B) THE SERVICE WILL MEET YOUR REQUIREMENTS OR EXPECTATIONS, (C) ANY STORED DATA WILL BE ACCURATE OR RELIABLE, (D) THE QUALITY OF ANY PRODUCTS, SERVICES, INFORMATION, OR OTHER MATERIALS PURCHASED OR OBTAINED BY YOU THROUGH THE APPLICATION WILL MEET YOUR REQUIREMENTS OR EXPECTATIONS, (E) ERRORS OR DEFECTS IN THE APPLICATION AND/OR THE SOFTWARE WILL BE CORRECTED, OR (F) THE APPLICATION OR THE SERVER(S) THAT MAKE THE APPLICATION AVAILABLE ARE FREE OF VIRUSES OR OTHER HARMFUL COMPONENTS. THE SERVICE IS PROVIDED TO YOU STRICTLY ON AN “AS IS” BASIS. All conditions, representations and warranties, whether express, implied, statutory or otherwise, including, without limitation, any implied warranty of merchantability, fitness for a particular purpose, or non-infringement of third party rights, are hereby excluded and disclaimed to the highest and maximum extent. The company makes no representation, warranty, or guarantee as to the reliability, safety, timeliness, quality, suitability or availability of any services.  You acknowledge and agree that the entire risk arising out of your use of the service, and any third party services, remains solely and absolutely with you and you shall have no recourse whatsoever to the company.',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),
              Text(
                'including the device used by you or the third party service provider being faulty, not connected, out of range, switched off or not functioning. The company is not responsible for any delays, delivery failures, damages or losses resulting from such problems.',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),
              Text(
                'Limitation of Liability',
                style: TextStyles.darkNormal,
              ),
              SizedBox(height: 16),
              Text(
                'Any claims against WeTrek by you shall in any event be limited to the aggregate amount of all amounts actually paid by and/or due from you in utilising the service during the event giving rise to such claims. IN NO EVENT SHALL THE COMPANY AND/OR ITS LICENSORS BE LIABLE TO YOU OR ALNYONE FOR ANY DIRECT, INDIRECT, PUNITIVE, ECONOMIC, FUTURE SPECIAL, EXEMPLARY, INCIDENTAL, CONSEQUENTIAL OR OTHER DAMAGES OR LOSSES OF ANY TYPE OR KIND (INCLUDING PERSONAL INJURY, EMOTIONAL DISTRESS AND LOSS OF DATA, GOODS, REVENUE, PROFITS, USE OR OTHER ECONOMIC ADVANTAGE). WETREK AND/OR ITS LICENSORS SHALL NOT BE LIABLE FOR ANY LOSS, DAMAGE OR INJURY WHICH MAY BE INCURRED BY OR CAUSED TO YOU OR TO ANY PERSON FOR WHOM YOU HAVE BOOKED THE SERVICE FOR, INCLUDING BUT NOT LIMITED TO LOSS, DAMAGE OR INJURY ARISING OUT OF, OR IN ANY WAY CONNECTED WITH THE SERVICE, APPLICATION AND/OR THE SOFTWARE, INCLUDING BUT NOT LIMITED TO THE USE OR INABILITY TO USE THE SERVICE, APPLICATION AND/OR THE SOFTWARE, ANY RELIANCE PLACED BY YOU ON THE COMPLETENESS, ACCURACY OR EXISTENCE OF ANY ADVERTISING, OR AS A RESULT OF ANY RELATIONSHIP OR TRANSACTION BETWEEN YOU AND ANY THIRD PARTY PROVIDER, ADVERTISER OR SPONSOR WHOSE ADVERTISING APPEARS ON THE WEBSITE OR IS REFERRED TO BY THE SERVICE, APPLICATION AND/OR THE SOFTWARE, EVEN IF THE COMPANY AND/OR ITS LICENSORS HAVE BEEN PREVIOUSLY ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. The company does not and will not assess nor monitor the suitability, legality, ability, movement or location of any third party providers, advertisers and/or sponsors and you expressly relinquish and release the company from any and all liability, claims or damages arising from or in any way related to the third party providers, advertisers and/or sponsors. WeTrek will not be a party to disputes, negotiations of disputes between you and such third party providers, advertisers and/or sponsors. We cannot and will not play any role in managing payments between you and the third party providers, advertisers and/or sponsors. Responsibility for the decisions you make regarding services and products offered via the service, software and/or the application (with all its implications) rests solely with and on you. You expressly relinquish and release the company from any and all liability, claims, causes of action, or damages arising from your use of the service, software and/or the application, or in any way related to the third parties, advertisers and/or sponsors introduced to you by the service, software and/or the application.',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),
              Text(
                'The quality of the third party services scheduled through the use of the service is entirely the responsibility of the third party service provider who ultimately provides such services to you. You understand, therefore, that by using the service, you may be exposed to services that is potentially dangerous, offensive, harmful to minors, unsafe or otherwise objectionable, and that you use the service at your own risk.',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),
              Text(
                'User Provided Content',
                style: TextStyles.darkNormal,
              ),
              SizedBox(height: 16),
              Text(
                'WeTrek may allow from time to time users to post their own content ("User Provided Content") that may be accessed by other users of the Service. WeTrek has no obligation to monitor the User Provided Content or the use of the Service, or to retain the content of any user posted in User Provided Content sections of the Service. You may not provide defamatory, libelous, hateful, violent, obscene, pornographic, unlawful, or otherwise offensive, as determined by WeTrek in its sole discretion, whether or not such material may be protected by law, User Provided Content. ',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),
              Text(
                'WeTrek does not claim ownership of any User Provided Content. By submitting, posting or displaying the User Provided Content, you hereby grant WeTrek a perpetual, irrevocable, worldwide, royalty-free, and non-exclusive license to reproduce, adapt, modify, translate, publish, publicly perform, publicly display and distribute any User Provided Content which you submit, post or display on or through, the website. This license is for the sole purpose of enabling WeTrek to display, publicly perform, distribute and promote the User Provided Content and the website.',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),
              Text(
                'WeTrek reserves the right, in its sole and absolute discretion, to modify or delete any information, stored or posted to the website.',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),
              Text(
                'WeTrek does not assume any responsibility for the contents of the User Provided Content.',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),
              Text(
                'Governing Law',
                style: TextStyles.darkNormal,
              ),
              SizedBox(height: 16),
              Text(
                'These Agreement, your rights and the rights of WeTrek within this Agreement shall be governed by and interpreted in accordance with the law of the Defendant\'s country of residence.',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),
              Text(
                'Notice',
                style: TextStyles.darkNormal,
              ),
              SizedBox(height: 16),
              Text(
                'WeTrek may give notice by means of a general notice on the Application, electronic mail to your email address in the records of WeTrek, or by written communication sent by Registered mail or pre-paid post to your address in the record of WeTrek. Such notice shall be deemed to have been given upon the expiration of 48 hours after mailing or posting (if sent by Registered mail or pre-paid post) or 1 hour after sending (if sent by email). You may give notice to WeTrek (such notice shall be deemed given when received by WeTrek) by letter sent by courier or registered mail to WeTrek using the contact details as provided in the Application.',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),
              Text(
                'Assignment',
                style: TextStyles.darkNormal,
              ),
              SizedBox(height: 16),
              Text(
                'The agreement as constituted by the Terms of Use as modified from time to time may not be assigned by you without the prior written approval of WeTrek but may be assigned without your consent by WeTrek. Any purported assignment by you in violation of this section shall be void.',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),
              Text(
                'General Provisions',
                style: TextStyles.darkNormal,
              ),
              SizedBox(height: 16),
              Text(
                'The agreement as constituted by the Terms of Use as modified from time to time may not be assigned by you without the prior written approval of WeTrek but may be assigned without your consent by WeTrek. Any purported assignment by you in violation of this section shall be void.',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),
              Text(
                'We may give notice to you by email, a posting on the Site, or other reasonable means. You must give notice to us in writing via email or as otherwise expressly provided.',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),
              Text(
                'Class Action Waiver',
                style: TextStyles.darkNormal,
              ),
              SizedBox(height: 16),
              Text(
                'By voluntarily accepting this Agreement, you agree that in its entirety as provided by the applicable law, a lawsuit or arbitration proceedings related to this Agreement are carried out exclusively on a case-by-case basis, and no disputes arising from collective claims or representative actions on behalf of third parties shall be considered.',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),
              Text(
                'Disputes cannot be consolidated without the written consent of all parties. No decision or determination of a court or an arbitrator will have a prejudicial force over the issues or claims regarding any disputes with persons who are not the declared parties to such arbitration proceedings.',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),
              Text(
                'This means the following:',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),
              ListItem(
                bullet: Text('1'),
                text:
                    'You agree that you cannot make a claim as a plaintiff or a participant in a class action, a consolidated action or a representative action.',
              ),
              SizedBox(height: 16),
              ListItem(
                bullet: Text('2'),
                text:
                    'The parties agree that an arbitrator or a court shall not consolidate the claims of more than one person into a single lawsuit, and shall not conduct arbitration or action proceedings of a consolidated, collective or representative nature (unless all parties agree to change this provision). ',
              ),
              SizedBox(height: 16),
              ListItem(
                bullet: Text('3'),
                text:
                    'The parties agree that the decision or determination of an arbitrator or a court in the event of a single person claim can only affect the person who filed this lawsuit, but not other persons, and cannot be used to resolve other disputes with other plaintiffs.',
              ),
              SizedBox(height: 16),
              Text(
                'By visiting our website, downloading and using application WeTrek, you agree that the laws of your country of residence, without violating the principles of conflict of laws, are legally binding with respect to this Agreement and any disputes of any kind that may arise between us.',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),

              Text(
                'Privacy policy',
                style: TextStyles.darkNormal,
              ),
              SizedBox(height: 16),
              Text(
                'This privacy policy ("Policy") describes how the personally identifiable information ("Personal Information") you may provide in the "WeTrek" mobile application ("Mobile Application" or "Service") and any of its related products and services (collectively, "Services") is collected, protected and used. It also describes the choices available to you regarding our use of your Personal Information and how you can access and update this information. This Policy is a legally binding agreement between you ("User", "you" or "your") and this Mobile Application developer ("Operator", "we", "us" or "our"). By accessing and using the Mobile Application and Services, you acknowledge that you have read, understood, and agree to be bound by the terms of this Agreement. This Policy does not apply to the practices of companies that we do not own or control, or to individuals that we do not employ or manage.',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),

              Text(
                'Automatic collection of information',
                style: TextStyles.darkNormal,
              ),
              SizedBox(height: 16),
              Text(
                'Our top priority is customer data security and, as such, we may process only minimal user data, only as much as it is absolutely necessary to maintain the Mobile Application and Services. Information collected automatically is used only to identify potential cases of abuse and establish statistical information regarding the usage of the Mobile Application and Services. This statistical information is not otherwise aggregated in such a way that would identify any particular user of the system.',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),

              Text(
                'Collection of personal information',
                style: TextStyles.darkNormal,
              ),
              SizedBox(height: 16),
              Text(
                'You can access and use the Mobile Application and Services without telling us who you are or revealing any information by which someone could identify you as a specific, identifiable individual. If, however, you wish to use some of the features in the Mobile Application, you may be asked to provide certain Personal Information (for example, your name and e-mail address). We receive and store any information you knowingly provide to us when you create an account, publish content, or fill any online forms in the Mobile Application. When required, this information may include the following:',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),
              ListItem(
                  text:
                      'Personal details such as name, country of residence, etc.'),
              ListItem(
                  text:
                      'Contact information such as email address, address, etc'),
              ListItem(
                  text: 'Geolocation data such as latitude and longitude.'),
              Text(
                'Some of the information we collect is directly from you via the Mobile Application and Services. However, we may also collect Personal Information about you from other sources such as public databases and our joint marketing partners. You can choose not to provide us with your Personal Information, but then you may not be able to take advantage of some of the features in the Mobile Application. Users who are uncertain about what information is mandatory are welcome to contact us.',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),

              Text(
                'Use and processing of collected information',
                style: TextStyles.darkNormal,
              ),
              SizedBox(height: 16),
              Text(
                'In order to make the Mobile Application and Services available to you, or to meet a legal obligation, we need to collect and use certain Personal Information. If you do not provide the information that we request, we may not be able to provide you with the requested products or services. Any of the information we collect from you may be used for the following purposes:',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),
              ListItem(text: 'Improve user experience'),
              ListItem(text: 'Protect from abuse and malicious users'),
              ListItem(text: 'Respond to legal requests and prevent harm'),
              ListItem(
                  text: 'Run and operate the Mobile Application and Services'),
              Text(
                'Processing your Personal Information depends on how you interact with the Mobile Application and Services, where you are located in the world and if one of the following applies: (i) you have given your consent for one or more specific purposes; this, however, does not apply, whenever the processing of Personal Information is subject to California Consumer Privacy Act or European data protection law; (ii) provision of information is necessary for the performance of an agreement with you and/or for any pre-contractual obligations thereof; (iii) processing is necessary for compliance with a legal obligation to which you are subject; (iv) processing is related to a task that is carried out in the public interest or in the exercise of official authority vested in us; (v) processing is necessary for the purposes of the legitimate interests pursued by us or by a third party.',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),
              Text(
                'Note that under some legislations we may be allowed to process information until you object to such processing (by opting out), without having to rely on consent or any other of the following legal bases below. In any case, we will be happy to clarify the specific legal basis that applies to the processing, and in particular whether the provision of Personal Information is a statutory or contractual requirement, or a requirement necessary to enter into a contract.',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),

              Text(
                'Managing information',
                style: TextStyles.darkNormal,
              ),
              SizedBox(height: 16),
              Text(
                'You are able to delete certain Personal Information we have about you. The Personal Information you can delete may change as the Mobile Application and Services change. When you delete Personal Information, however, we may maintain a copy of the unrevised Personal Information in our records for the duration necessary to comply with our obligations to our affiliates and partners, and for the purposes described below. If you would like to delete your Personal Information or permanently delete your account, you can do so on the settings page of your account in the Mobile Application.',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),
              Text(
                'Disclosure of information',
                style: TextStyles.darkNormal,
              ),
              SizedBox(height: 16),
              Text(
                'Depending on the requested Services or as necessary to complete any transaction or provide any service you have requested, we may share your information with your consent with our trusted third parties that work with us, any other affiliates and subsidiaries we rely upon to assist in the operation of the Mobile Application and Services available to you. We do not share Personal Information with unaffiliated third parties. These service providers are not authorized to use or disclose your information except as necessary to perform services on our behalf or comply with legal requirements. We may share your Personal Information for these purposes only with third parties whose privacy policies are consistent with ours or who agree to abide by our policies with respect to Personal Information. These third parties are given Personal Information they need only in order to perform their designated functions, and we do not authorize them to use or disclose Personal Information for their own marketing or other purposes.',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),

              Text(
                'Retention of information',
                style: TextStyles.darkNormal,
              ),
              SizedBox(height: 16),
              Text(
                'We will retain and use your Personal Information for the period necessary to comply with our legal obligations, resolve disputes, and enforce our agreements unless a longer retention period is required or permitted by law. We may use any aggregated data derived from or incorporating your Personal Information after you update or delete it, but not in a manner that would identify you personally. Once the retention period expires, Personal Information shall be deleted. Therefore, the right to access, the right to erasure, the right to rectification and the right to data portability cannot be enforced after the expiration of the retention period.',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),

              Text(
                'Transfer of information',
                style: TextStyles.darkNormal,
              ),
              SizedBox(height: 16),
              Text(
                'Depending on your location, data transfers may involve transferring and storing your information in a country other than your own. You are entitled to learn about the legal basis of information transfers to a country outside the European Union or to any international organization governed by public international law or set up by two or more countries, such as the UN, and about the security measures taken by us to safeguard your information. If any such transfer takes place, you can find out more by checking the relevant sections of this Policy or inquire with us using the information provided in the contact section.',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),

              Text(
                'The rights of users',
                style: TextStyles.darkNormal,
              ),
              SizedBox(height: 16),
              Text(
                'You may exercise certain rights regarding your information processed by us. In particular, you have the right to do the following:',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),
              ListItem(
                  text:
                      'You have the right to request access to your Personal Information that we store and have the ability to access your Personal Information.'),
              SizedBox(height: 16),
              ListItem(
                  text:
                      'You have the right to request that we correct any Personal Information you believe is inaccurate. You also have the right to request us to complete the Personal Information you believe is incomplete.'),
              SizedBox(height: 16),
              ListItem(
                  text:
                      'You have the right to request the erase your Personal Information under certain conditions of this Policy.'),
              SizedBox(height: 16),
              ListItem(
                  text:
                      'You have the right to object to our processing of your Personal Information.'),
              SizedBox(height: 16),
              ListItem(
                  text:
                      'You have the right to seek restrictions on the processing of your Personal Information. When you restrict the processing of your Personal Information, we may store it but will not process it further.'),
              SizedBox(height: 16),
              ListItem(
                  text:
                      'You have the right to be provided with a copy of the information we have on you in a structured, machine-readable and commonly used format.'),
              SizedBox(height: 16),
              ListItem(
                  text:
                      'You also have the right to withdraw your consent at any time where the Operator relied on your consent to process your Personal Information.'),
              SizedBox(height: 16),
              Text(
                'For more information, please contact your local data protection authority in the European Economic Area (EEA).',
                style: TextStyles.terms,
              ),

              SizedBox(height: 16),
              Text(
                'The right to object to processing',
                style: TextStyles.darkNormal,
              ),
              SizedBox(height: 16),
              Text(
                'Where Personal Information is processed for the public interest, in the exercise of an official authority vested in us or for the purposes of the legitimate interests pursued by us, you may object to such processing by providing a ground related to your particular situation to justify the objection.',
                style: TextStyles.terms,
              ),

              SizedBox(height: 16),
              Text(
                'Data protection rights under GDPR',
                style: TextStyles.darkNormal,
              ),
              SizedBox(height: 16),
              Text(
                'If you are a resident of the European Economic Area (EEA), you have certain data protection rights and the Operator aims to take reasonable steps to allow you to correct, amend, delete, or limit the use of your Personal Information. If you wish to be informed what Personal Information we hold about you and if you want it to be removed from our systems, please contact us. In certain circumstances, you have the following data protection rights:',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),
              ListItem(
                  text:
                      'You have the right to request access to your Personal Information that we store and have the ability to access your Personal Information.'),
              SizedBox(height: 16),
              ListItem(
                  text:
                      'You have the right to request that we correct any Personal Information you believe is inaccurate. You also have the right to request us to complete the Personal Information you believe is incomplete.'),
              SizedBox(height: 16),
              ListItem(
                  text:
                      'You have the right to request the erase your Personal Information under certain conditions of this Policy.'),
              SizedBox(height: 16),
              ListItem(
                  text:
                      'You have the right to object to our processing of your Personal Information.'),
              SizedBox(height: 16),
              ListItem(
                  text:
                      'You have the right to seek restrictions on the processing of your Personal Information. When you restrict the processing of your Personal Information, we may store it but will not process it further.'),
              SizedBox(height: 16),
              ListItem(
                  text:
                      'You have the right to be provided with a copy of the information we have on you in a structured, machine-readable and commonly used format.'),
              SizedBox(height: 16),
              ListItem(
                  text:
                      'You also have the right to withdraw your consent at any time where the Operator relied on your consent to process your Personal Information.'),
              Text(
                'For more information, please contact your local data protection authority in the European Economic Area (EEA).',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),
              Text(
                'California privacy rights',
                style: TextStyles.darkNormal,
              ),
              SizedBox(height: 16),
              Text(
                'In addition to the rights as explained in this Policy, California residents who provide Personal Information (as defined in the statute) to obtain products or services for personal, family, or household use are entitled to request and obtain from us, once a calendar year, information about the Personal Information we shared, if any, with other businesses for marketing uses. If applicable, this information would include the categories of Personal Information and the names and addresses of those businesses with which we shared such personal information for the immediately prior calendar year (e.g., requests made in the current year will receive information about the prior year). To obtain this information please contact us.',
                style: TextStyles.terms,
              ),

              SizedBox(height: 16),
              Text(
                'How to exercise these rights',
                style: TextStyles.darkNormal,
              ),
              SizedBox(height: 16),
              Text(
                'Any requests to exercise your rights can be directed to the Operator through the contact details provided in this document. Please note that we may ask you to verify your identity before responding to such requests. Your request must provide sufficient information that allows us to verify that you are the person you are claiming to be or that you are the authorized representative of such person. You must include sufficient details to allow us to properly understand the request and respond to it. We cannot respond to your request or provide you with Personal Information unless we first verify your identity or authority to make such a request and confirm that the Personal Information relates to you.',
                style: TextStyles.terms,
              ),

              SizedBox(height: 16),
              Text(
                'Privacy of children',
                style: TextStyles.darkNormal,
              ),
              SizedBox(height: 16),
              Text(
                'We do not knowingly collect any Personal Information from children under the age of 18. If you are under the age of 18, please do not submit any Personal Information through the Mobile Application and Services. We encourage parents and legal guardians to monitor their children\'s Internet usage and to help enforce this Policy by instructing their children never to provide Personal Information through the Mobile Application and Services without their permission. If you have reason to believe that a child under the age of 18 has provided Personal Information to us through the Mobile Application and Services, please contact us. You must also be at least 16 years of age to consent to the processing of your Personal Information in your country (in some countries we may allow your parent or guardian to do so on your behalf).',
                style: TextStyles.terms,
              ),

              SizedBox(height: 16),
              Text(
                'Email marketing',
                style: TextStyles.darkNormal,
              ),
              SizedBox(height: 16),
              Text(
                'We offer electronic newsletters to which you may voluntarily subscribe at any time. We are committed to keeping your e-mail address confidential and will not disclose your email address to any third parties except as allowed in the information use and processing section or for the purposes of utilizing a third party provider to send such emails. We will maintain the information sent via e-mail in accordance with applicable laws and regulations.',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),
              Text(
                'In compliance with the CAN-SPAM Act, all e-mails sent from us will clearly state who the e-mail is from and provide clear information on how to contact the sender. You may choose to stop receiving our newsletter or marketing emails by following the unsubscribe instructions included in these emails or by contacting us. However, you will continue to receive essential transactional emails.',
                style: TextStyles.terms,
              ),
              SizedBox(height: 16),
              Text(
                'Links to other resources',
                style: TextStyles.darkNormal,
              ),
              SizedBox(height: 16),
              Text(
                'The Mobile Application and Services contain links to other resources that are not owned or controlled by us. Please be aware that we are not responsible for the privacy practices of such other resources or third parties. We encourage you to be aware when you leave the Mobile Application and Services and to read the privacy statements of each and every resource that may collect Personal Information.',
                style: TextStyles.terms,
              ),

              SizedBox(height: 16),
              Text(
                'Information security',
                style: TextStyles.darkNormal,
              ),
              SizedBox(height: 16),
              Text(
                'We secure information you provide on computer servers in a controlled, secure environment, protected from unauthorized access, use, or disclosure. We maintain reasonable administrative, technical, and physical safeguards in an effort to protect against unauthorized access, use, modification, and disclosure of Personal Information in its control and custody. However, no data transmission over the Internet or wireless network can be guaranteed. Therefore, while we strive to protect your Personal Information, you acknowledge that (i) there are security and privacy limitations of the Internet which are beyond our control; (ii) the security, integrity, and privacy of any and all information and data exchanged between you and the Mobile Application and Services cannot be guaranteed; and (iii) any such information and data may be viewed or tampered with in transit by a third party, despite best efforts.',
                style: TextStyles.terms,
              ),

              SizedBox(height: 16),
              Text(
                'Data breach',
                style: TextStyles.darkNormal,
              ),
              SizedBox(height: 16),
              Text(
                'In the event we become aware that the security of the Mobile Application and Services has been compromised or users Personal Information has been disclosed to unrelated third parties as a result of external activity, including, but not limited to, security attacks or fraud, we reserve the right to take reasonably appropriate measures, including, but not limited to, investigation and reporting, as well as notification to and cooperation with law enforcement authorities. In the event of a data breach, we will make reasonable efforts to notify affected individuals if we believe that there is a reasonable risk of harm to the user as a result of the breach or if notice is otherwise required by law. When we do, we will post a notice in the Mobile Application.',
                style: TextStyles.terms,
              ),

              SizedBox(height: 16),
              Text(
                'Changes and amendments',
                style: TextStyles.darkNormal,
              ),
              SizedBox(height: 16),
              Text(
                'We reserve the right to modify this Policy or its terms relating to the Mobile Application and Services from time to time in our discretion and will notify you of any material changes to the way in which we treat Personal Information. When we do, we will send you an email to notify you. We may also provide notice to you in other ways in our discretion, such as through contact information you have provided. Any updated version of this Policy will be effective immediately upon the posting of the revised Policy unless otherwise specified. Your continued use of the Mobile Application and Services after the effective date of the revised Policy (or such other act specified at that time) will constitute your consent to those changes. However, we will not, without your consent, use your Personal Information in a manner materially different than what was stated at the time your Personal Information was collected. ',
                style: TextStyles.terms,
              ),

              SizedBox(height: 16),
              Text(
                'Acceptance of this policy',
                style: TextStyles.darkNormal,
              ),
              SizedBox(height: 16),
              Text(
                'You acknowledge that you have read this Policy and agree to all its terms and conditions. By accessing and using the Mobile Application and Services you agree to be bound by this Policy. If you do not agree to abide by the terms of this Policy, you are not authorized to access or use the Mobile Application and Services.',
                style: TextStyles.terms,
              ),

              SizedBox(height: 16),
              Text(
                'Contacting us',
                style: TextStyles.darkNormal,
              ),
              SizedBox(height: 16),
              Text(
                'If you would like to contact us to understand more about this Policy or wish to contact us concerning any matter relating to individual rights and your Personal Information, you may send an email to Support@wetrek.com',
                style: TextStyles.terms,
              ),
              Text(
                'Last updated: April 23rd, 2021',
                style: TextStyles.darkNormal,
              ),
              SizedBox(height: 21),
              MyButton(
                'CONTINUE & AGREE',
                color: Color(0xff3ACCE1),
                onTap: () async {
                  AuthenticationRepository rep =
                      RepositoryProvider.of<AuthenticationRepository>(context);
                  await rep.saveCookie('privacy_policy');
                  Future.delayed(Duration.zero, () {
                    Navigator.push(context, MapScreen.route());
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
