# flutter_base_project

base_project

## Getting Started


SETUP
1. Copy semua library, asset setup, dan font setup yang ada di pubspec.yaml lalu pub get
2. Pasang plugin Flutter Provider untuk memudahkan pembuatan file view dan provider
3. Copy permission permission di AndroidManifest.xml dan info.plist
4. Setup gradle untuk menyesuaikan target dan min sdk nya serta menambahkan multidex
5. Copy semua folder folder nya semua biar memudahkan setup nya

Provider State Management
1. Konsepnya terdapat 2 file, yaitu file view dan provider. File view isinya ya view saja, dibuat stateless widget juga gapapa. File provider isinya semua variabel variabel dan fungsi fungsi. Jadi apabila view butuh variabel tinggal ngambil dari providernya. Apabila variabel pada provider mau diupdate ke view tinggal panggil notifyListeners() untuk mereload semua widget yang ada di consumer.
2. Untuk mempermudah membuat file nya pake plugin Flutter Provider aja, tinggal klik kanan -> New -> Flutter Provider -> Default dan Use Prefix
3. Pada file view pastikan widget nya dibungkus Consumer dan dibungkus lagi oleh ChangeNotifierProvider. ChangeNotifierProvider gunanya untuk mengcreate provider nya, consumer gunaya untuk mengakses provider yang sudah dibuat tadi. Variabel provider di consumer ini yang akan digunakan untuk mengakses variabel dan fungsi yang ada di file provider.

NOTE
1. Penamaan model bisa diakhiri dengan Model (misalnya GameModel, UserModel)
2. Pembuatan file model bisa menggunakan https://javiercbk.github.io/json_to_dart/ untuk mengconvert JSON ke Dart Class atau menggunakan JsonSerializable dan BuildRunner, tutorialnya bisa liat di https://medium.com/nusanet/flutter-json-serializable-generator-fc689b82cc4e
3. Penamaan Activity / Halaman diakhiri dengan Page (misalnya DetalGamePage, HomePage)
4. Agar responsive pakenya library screen_utils 

CARA SETUP FIREBASE
Check https://firebase.google.com/docs/flutter/setup
TLDR : 
1. Install Firebase CLI jika belum
2. firebase login / firebase logout untuk masuk ke akun firebasenya
3. flutterfire configure
4. check main.dart untuk initialisasinya

CARA BUILD RELEASE
1. Untuk membuat build release buat file key.properties pada folder android yang berisi data key releasenya
2. Pada android -> app -> build.gradle isi dilengkapi dengan keystore properties yang tadi sudah dibuat
3. pada terminal flutter build apk --release atau flutter build apk --split-per-abi agar build per abi agar file nya tidak terlalu besar