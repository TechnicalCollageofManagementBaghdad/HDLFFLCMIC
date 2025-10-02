# Project Title
(Hybrid Deep Learning and Feature Fusion for Low-Contrast Medical Image Classification)


---

## Logo
(أضف صورة أو شعار للمشروع إن وجد)

---

## Introduction
يهدف هذا المشروع إلى تطوير إطار عمل متكامل لتصنيف الصور الطبية منخفضة التباين، وهي مشكلة جوهرية في مجال التصوير الطبي حيث يؤدي انخفاض التباين إلى اخفاء التفاصيل البنيوية الدقيقة وانعكاس ذلك سلبًا على جودة التشخيص. يعتمد النهج المقترح على بناء نموذج تعلم عميق هجين (CNN+DNN) و (ResNet-50, VGG-16) من أجل تعزيز استخلاص السمات التمييزية. يتم تحسين السمات المستخرجة باستخدام تحليل المكونات الرئيسية (PCA) ثم دمجها وفق آلية الدمج المرجّح للسمات (Weighted Feature Fusion). كما يتم توظيف آلة المتجهات الداعمة (SVM) كخوارزمية تصنيف أساسية، مع تطبيق آليات التصويت بالأغلبية والتصويت المرجّح لزيادة دقة وموثوقية نتائج التصنيف. يساهم هذا الإطار في تحسين التمثيل الدلالي للصور الطبية منخفضة التباين، وتقليل التعقيد الحسابي، ورفع كفاءة التصنيف بما يدعم الاستخدامات السريرية في التشخيص الطبي.---

## Publication
عنوان الرسالة(توظيف تقنيات الذكاء الاصطناعي في بناء نموذج تحليل الصور الطبية منخفضة التغاير)
حيث تتضمن الرسالة حل لمشكلة الصور المنخفضة التباين التي لاتظهر تفاصيل الدقيقة في صورة والتي تؤثر على دقة التشخيص الطبي ,حيث ثمثلت عملية المعالجة بتحسين الصور الطبية بطرق التحسين الهستوغرامية ودمجها مع مرشحات التصفية ومن ثم الحصول علة صورة معالجية عالية الوضوح حيث تم استخدام تقنيات الذكاء الاصطناعي التي جمعت بين التعلم العميق والتعلم الالي واعطت دقة تصنيف عالية مقارنة بطرق فردية تم تجربتها وقد استخدمت قواعد بيانات محلية وعالمية  حيث محلية تم جمعها من مدينة الطب ل2 انواع من الصور والعالمية ل3 انواع من الصور وهذا نموذج الذكي ساعد في تشخيص الطبي وفي تقليل الاخطاء تشخيص السريري.
----البحوث المنشورة
البحث الاول( Evaluation of the effects of combining histogram equalization techniques with Butterworth filter to improve the sharpness of Brain images)
البحث الثاني(Review of Alzheimer's disease prediction techniques using Generative Adversarial Networks)
البحث الثالث(Classification of low-contrast medical images based on Deep learning and Feature Fusion Techniques)
## Requirements
لتشغيل المشروع، تحتاج إلى:
- لغة البرمجة: ( MATLAB / ...)
- بيئة التطوير: (: MATLAB R2024b )
- المكتبات / الحزم:
  - مثال: deeplearning, OpenCV  


---

## Installation
تثبيت بيئة MATLAB

الإصدار الموصى به: MATLAB R2021b أو أحدث.

تأكد من تثبيت الـ Toolboxes التالية:

Deep Learning Toolbox

Computer Vision Toolbox

Image Processing Toolbox

Statistics and Machine Learning Toolbox

تثبيت الشبكات المدربة مسبقًا

من خلال MATLAB Add-On Explorer، قم بتنزيل:

Deep Learning Toolbox Model for ResNet-50 Network

Deep Learning Toolbox Model for VGG-16 Network

أو تنفيذ الأوامر التالية في MATLAB:

% تحميل ResNet-50
net1 = resnet50;

% تحميل VGG-16
net2 = vgg16;


إعداد بيانات المشروع

ضع صور التدريب في المسار:

C:\Users\NS\Desktop\cnn\LowContrastImages1OUTBUT


ضع صور الاختبار في المسار:

C:\Users\NS\Desktop\cnn\LowContrastImages4output


(يمكنك تعديل المسارات في الكود إذا كانت مختلفة عندك).

تشغيل الكود

افتح ملف المشروع في MATLAB.

شغّل الكود الرئيسي مباشرة:

run('Q.m')


سيبدأ التدريب على البيانات، ثم يتم استخراج الميزات من الشبكات المختلفة ودمجها، وأخيرًا عرض دقة التصنيف  (Confusion Matrix) ونتائج الاختبار بالصور
# تثبيت المتطلبات 
بيئة البرمجة

MATLAB (الإصدار الموصى به: R2024b أو أحدث)

المكتبات / الصناديق (Toolboxes) الضرورية:

Deep Learning Toolbox

Computer Vision Toolbox

Image Processing Toolbox

Statistics and Machine Learning Toolbox

النماذج المدربة مسبقًا (Pre-trained Models):

ResNet-50

VGG-16

