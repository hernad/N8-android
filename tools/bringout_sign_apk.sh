#!/bin/bash

SIGNING_NAME="bring.out doo Sarajevo"
BUILD_TOOLS_VER=25.0.2
VALID_DAYS=20000
build_dir=$(pwd)


outputs/apk/N8-android-modified-release-unsigned.apk

APK_DIR=outputs/apk
APK=N8-android-modified-release-unsigned.apk

APK_SIGNED=N8.apk

cd $APK_DIR

if [ ! -f bringout-android.keystore ]
then
   echo generating keystore
   keytool -genkey -v -keystore bringout-android.keystore -alias \
            "$SIGNING_NAME" -keyalg RSA -keysize 2048 --validity $VALID_DAYS 

fi

jarsigner -verbose -keystore bringout-android.keystore \
      $APK "$SIGNING_NAME"


[ -f $APK_SIGNED ] && rm $APK_SIGNED


$ANDROID_HOME/build-tools/$BUILD_TOOLS_VER/zipalign 4 \
   $APK  $APK_SIGNED


cp $APK_SIGNED $build_dir

cd $build_dir
 
ls -lh $APK_SIGNED

