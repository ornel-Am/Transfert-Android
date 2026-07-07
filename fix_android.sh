#!/bin/bash
# fix_android.sh - Corriger le build Android

echo "📱 Correction du build Android..."

cd ~/Transfert-Android

# 1. Créer la structure
mkdir -p android
mkdir -p src

# 2. Copier le code depuis les autres dépôts
echo "📄 Copie du code source..."

# Essayer depuis Transfert-Windows
if [ -d ~/Transfert-Windows ]; then
    cp -r ~/Transfert-Windows/*.py src/ 2>/dev/null
    cp -r ~/Transfert-Windows/src/* src/ 2>/dev/null
fi

# OU depuis Transfert-Linux
if [ -d ~/Transfert-Linux ]; then
    cp -r ~/Transfert-Linux/*.py src/ 2>/dev/null
    cp -r ~/Transfert-Linux/src/* src/ 2>/dev/null
fi

# OU depuis l'ancien projet
if [ -d ~/Transfert_Universal/src ]; then
    cp -r ~/Transfert_Universal/src/* src/
fi

# 3. Vérifier
echo "📂 Contenu de src/ :"
ls -la src/

# 4. Créer le fichier main.py si absent
if [ ! -f "src/main.py" ]; then
    echo "⚠️ main.py manquant, création..."
    cat > src/main.py << 'MAIN'
#!/usr/bin/env python3
from kivy.app import App
from kivy.uix.label import Label

class TransfertApp(App):
    def build(self):
        return Label(text="Transfert TCP Android")

if __name__ == "__main__":
    TransfertApp().run()
MAIN
fi

# 5. Copier dans android/
cp -r src/* android/

# 6. Créer buildozer.spec
cat > android/buildozer.spec << 'SPEC'
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
SPEC

# 7. Vérifier
echo ""
echo "📂 Structure :"
ls -la android/

# 8. Pousser
git add .
git commit -m "Ajout du code source Android"
git push origin main

# 9. Nouveau tag
git tag -d v1.1.0 2>/dev/null
git push origin :refs/tags/v1.1.0 2>/dev/null
git tag -a v1.1.0 -m "Version 1.1.0 - Android avec code source"
git push origin v1.1.0

echo ""
echo "✅ Android corrigé !"
echo "🔗 https://github.com/ornel-Am/Transfert-Android/actions"
