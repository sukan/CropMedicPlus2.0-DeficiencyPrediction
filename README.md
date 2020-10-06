# CropMedicPlus 2.0 with Tflite
Crop Medic Plus 2.0 is aim to predit the nutrient disorder in plants (Guava, Groundnut, Citrus)

## App Structure

- '<app_root>/pubspec.yaml': Used to add packages to the app from pub.dev
- '<app_root>/lib/main.dart': Used for all the logic of the app
- '<app_root>/assets/': used for storing and using TFLite model and label for the app
- '<app_root>/android/app/src/main/AndroidManifest.xml': used for modifying app name and details
- '<app_root>/android/app/build.gradle': used for specifying TFLite model not to be compressed

