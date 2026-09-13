#!/bin/bash

# 🚀 أمر بدء سريع آمن

clear
echo "╔════════════════════════════════════════════════════════╗"
echo "║        🚀 بدء Taam Mersin - الإصدار الآمن            ║"
echo "╚════════════════════════════════════════════════════════╝"
echo ""

# فحص أولي
echo "🔍 فحص أولي..."
echo ""

if [ ! -f "server.js" ]; then
  echo "❌ خطأ: أنت لا تملك في مجلد Restaurant-Service"
  echo "شغّل: cd ~/Restaurant-Service"
  exit 1
fi

if [ ! -f ".env" ]; then
  echo "⚠️ تحذير: ملف .env غير موجود"
  echo "إنشاء .env من .env.example..."
  if [ -f ".env.example" ]; then
    cp .env.example .env
    echo "✅ تم إنشاء .env"
  else
    echo "❌ خطأ: ملف .env.example غير موجود"
    exit 1
  fi
fi

if [ ! -d "node_modules" ]; then
  echo "📦 تثبيت المكتبات..."
  npm install
fi

echo ""
echo "════════════════════════════════════════════════════════"
echo "🎯 الخيارات:"
echo "════════════════════════════════════════════════════════"
echo ""
echo "1️⃣  بدء الخادم فقط (PORT 8000)"
echo "2️⃣  بدء الخادم + إضافة بيانات الاختبار"
echo "3️⃣  فحص شامل للنظام"
echo "4️⃣  بدء Expo (Frontend)"
echo "5️⃣  اختبار API"
echo "6️⃣  حذف جميع البيانات وإعادة تحميلها"
echo "0️⃣  إلغاء"
echo ""
echo "════════════════════════════════════════════════════════"
echo ""
read -p "اختر رقماً (0-6): " choice

case $choice in
  1)
    echo ""
    echo "🚀 بدء الخادم على PORT 8000..."
    echo ""
    PORT=8000 npm run dev
    ;;
  2)
    echo ""
    echo "🚀 بدء الخادم + إضافة البيانات..."
    echo ""
    PORT=8000 npm run dev &
    sleep 5
    echo ""
    echo "📝 إضافة بيانات الاختبار..."
    node seed.js
    wait
    ;;
  3)
    echo ""
    bash comprehensive-check.sh
    ;;
  4)
    echo ""
    echo "🚀 بدء Expo..."
    cd frontend
    npm start
    ;;
  5)
    echo ""
    echo "🧪 اختبار API..."
    bash test-api.sh
    ;;
  6)
    echo ""
    read -p "⚠️ هذا سيحذف جميع البيانات. متأكد؟ (y/n): " confirm
    if [ "$confirm" = "y" ]; then
      echo "🗑️ حذف البيانات..."
      mongosh taam-mersin --eval "db.dropDatabase()"
      echo ""
      echo "📝 إعادة تحميل البيانات..."
      node seed.js
    else
      echo "❌ تم الإلغاء"
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
