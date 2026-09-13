#!/bin/bash

# 🔧 أداة إصلاح مشاكل Taam Mersin

clear
echo "╔════════════════════════════════════════════════════════╗"
echo "║         🔧 أداة الإصلاح - Taam Mersin                 ║"
echo "╚════════════════════════════════════════════════════════╝"
echo ""
echo "اختر المشكلة:"
echo ""
echo "1️⃣  الخادم لا يشتغل (Error: listen EADDRINUSE)"
echo "2️⃣  npm لا يعمل (Command not found)"
echo "3️⃣  MongoDB غير متصل"
echo "4️⃣  Expo لا يعمل"
echo "5️⃣  حذف وإعادة تثبيت كل شيء"
echo "6️⃣  فحص الأخطاء في الملفات"
echo "7️⃣  عرض سجل الأخطاء"
echo "0️⃣  إلغاء"
echo ""
read -p "اختر رقماً (0-7): " choice

case $choice in
  1)
    echo ""
    echo "🔍 البحث عن العمليات التي تستخدم البورت 8000..."
    echo ""
    if lsof -i :8000 > /dev/null 2>&1; then
      echo "⚠️ وجدت عمليات على البورت 8000:"
      lsof -i :8000
      echo ""
      read -p "هل تريد قتلها؟ (y/n): " kill_choice
      if [ "$kill_choice" = "y" ]; then
        pkill -f "npm run dev"
        killall node 2>/dev/null
        echo "✅ تم قتل العمليات"
        echo ""
        echo "🚀 بدء الخادم من جديد..."
        PORT=8000 npm run dev
      fi
    else
      echo "✅ لا توجد عمليات على البورت 8000"
      echo ""
      echo "المشكلة قد تكون أخرى. جرّب:"
      echo "npm install"
      echo "PORT=8000 npm run dev"
    fi
    ;;
  2)
    echo ""
    echo "🔍 فحص npm..."
    if command -v npm &> /dev/null; then
      echo "✅ npm مثبت: $(npm --version)"
    else
      echo "❌ npm غير مثبت!"
      echo "ثبّت Node.js من: https://nodejs.org"
    fi
    ;;
  3)
    echo ""
    echo "🔍 فحص MongoDB..."
    if command -v mongosh &> /dev/null; then
      echo "✅ mongosh مثبت: $(mongosh --version)"
      echo ""
      echo "بدء MongoDB..."
      mongod --dbpath /data/db 2>/dev/null || echo "⚠️ لم أتمكن من بدء MongoDB"
    else
      echo "❌ MongoDB غير مثبت!"
      echo "ثبّت من: https://www.mongodb.com/try/download/community"
    fi
    ;;
  4)
    echo ""
    echo "🔧 إصلاح Expo..."
    echo ""
    cd frontend
    echo "🗑️ حذف node_modules..."
    rm -rf node_modules package-lock.json
    echo "📦 إعادة تثبيت المكتبات..."
    npm install
    echo "✅ انتهى الإصلاح"
    echo ""
    echo "🚀 بدء Expo..."
    npm start
    ;;
  5)
    echo ""
    echo "⚠️ هذا سيحذف كل شيء وإعادة تثبيت!"
    read -p "متأكد؟ (y/n): " confirm
    if [ "$confirm" = "y" ]; then
      echo ""
      echo "🗑️ حذف المكتبات..."
      rm -rf node_modules package-lock.json
      rm -rf frontend/node_modules frontend/package-lock.json
      npm cache clean --force
      
      echo "📦 إعادة تثبيت Backend..."
      npm install
      
      echo "📦 إعادة تثبيت Frontend..."
      cd frontend
      npm install
      cd ..
      
      echo "✅ انتهى الإصلاح!"
    else
      echo "❌ تم الإلغاء"
    fi
    ;;
  6)
    echo ""
    echo "🔍 فحص صيغة الملفات..."
    echo ""
    for file in server.js models/*.js controllers/*.js routes/*.js; do
      if [ -f "$file" ]; then
        if node -c "$file" 2>/dev/null; then
          echo "✅ $file"
        else
          echo "❌ $file - يحتوي على أخطاء!"
          node -c "$file"
        fi
      fi
    done
    ;;
  7)
    echo ""
    echo "📋 عرض السجلات الأخيرة..."
    echo ""
    if [ -f "error.log" ]; then
      tail -50 error.log
    else
      echo "لا توجد سجلات أخطاء"
    fi
    ;;
  0)
    echo "👋 وداعاً!"
    exit 0
    ;;
  *)
    echo "❌ اختيار غير صحيح"
    exit 1
    ;;
esac
