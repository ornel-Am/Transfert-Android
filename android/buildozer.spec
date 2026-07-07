[app]
title = Transfert TCP
package.name = transfertapp
package.domain = org.transfert
version = 1.0.9
requirements = python3,kivy
source.dir = .
source.main = main.py
android.api = 31
android.arch = arm64-v8a
android.permissions = INTERNET,READ_EXTERNAL_STORAGE,WRITE_EXTERNAL_STORAGE
android.debuggable = True
android.minapi = 21
android.targetapi = 31

[buildozer]
log_level = 2
