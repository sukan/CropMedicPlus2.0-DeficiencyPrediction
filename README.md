# CropMedicPlus 2.0 flutter app with Tflite
Crop Medic Plus 2.0 is aim to predit the nutrient disorder in plants (Guava, Groundnut, Citrus). Here i have converted my model(.h5) file into tfile and Load that into the flutter mobile app.


## App Structure

- '<app_root>/pubspec.yaml': Used to add packages to the app from pub.dev
- '<app_root>/lib/main.dart': Used for all the logic of the app
- '<app_root>/lib/Predictio.dart': It has all the code for the prediction
- '<app_root>/assets/': used for storing and using TFLite model and label for the app
- '<app_root>/android/app/src/main/AndroidManifest.xml': used for modifying app name and details
- '<app_root>/android/app/build.gradle': used for specifying TFLite model not to be compressed


## How to run the project

1. Clone the repository
2. Run the command -----> flutter pub get
3. then run -----> flutter run 

Firebase db has used for the authentication and storage.

