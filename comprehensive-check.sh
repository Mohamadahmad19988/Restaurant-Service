#!/bin/bash

# 🔍 فحص شامل لمشروع Taam Mersin

clear
echo "╔════════════════════════════════════════════════════════╗"
echo "║        🔍 فحص شامل - Taam Mersin                      ║"
echo "╚════════════════════════════════════════════════════════╝"
echo ""
echo "بدء الفحص في: $(date +%Y-%m-%d\ %H:%M:%S)"
echo ""

# متغيرات الإحصائيات
PASSED=0
FAILED=0
WARNING=0

# ==================== الفحص 1: الموقع ====================
echo "════════════════════════════════════════════════════════"
echo "✅ الفحص 1: الموقع والمسار"
echo "════════════════════════════════════════════════════════"
echo ""

echo "📍 المسار الحالي:"
PWD=$(pwd)
echo "   $PWD"
echo ""

echo "📁 اسم المجلد:"
FOLDER=$(basename $(pwd))
echo "   $FOLDER"
if [ "$FOLDER" = "Restaurant-Service" ]; then
  echo "   ✅ صحيح"
  ((PASSED++))
else
  echo "   ⚠️ يجب أن تكون في مجلد Restaurant-Service"
  ((WARNING++))
fi
echo ""

# ==================== الفحص 2: الملفات الأساسية ====================
echo "════════════════════════════════════════════════════════"
echo "✅ الفحص 2: الملفات الأساسية"
echo "════════════════════════════════════════════════════════"
echo ""

FILES=("server.js" "package.json" ".env" ".gitignore" "seed.js")

for file in "${FILES[@]}"; do
  if [ -f "$file" ]; then
    echo "✅ $file"
    ((PASSED++))
  else
    echo "❌ $file - مفقود!"
    ((FAILED++))
  fi
done
echo ""

# ==================== الفحص 3: المجلدات ====================
echo "════════════════════════════════════════════════════════"
echo "✅ الفحص 3: المجلدات الضرورية"
echo "════════════════════════════════════════════════════════"
echo ""

DIRECTORIES=("models" "controllers" "routes" "middleware" "config" "frontend")

for dir in "${DIRECTORIES[@]}"; do
  if [ -d "$dir" ]; then
    COUNT=$(ls -1 $dir/*.js 2>/dev/null | wc -l)
    echo "✅ $dir/ ($COUNT ملفات)"
    ((PASSED++))
  else
    echo "❌ $dir/ - مفقود!"
    ((FAILED++))
  fi
done
echo ""

# ==================== الفحص 4: المكتبات ====================
echo "════════════════════════════════════════════════════════"
echo "✅ الفحص 4: المكتبات المثبتة"
echo "════════════════════════════════════════════════════════"
echo ""

if [ -d "node_modules" ]; then
  echo "✅ node_modules موجود"
  MODULES_COUNT=$(ls -1 node_modules | wc -l)
  echo "   عدد المكتبات: $MODULES_COUNT"
  ((PASSED++))
  echo ""
  
  # التحقق من المكتبات المهمة
  echo "📦 المكتبات الرئيسية:"
  LIBS=("express" "mongoose" "jsonwebtoken" "bcryptjs" "cors" "dotenv" "stripe")
  
  for lib in "${LIBS[@]}"; do
    if [ -d "node_modules/$lib" ]; then
      VERSION=$(cat node_modules/$lib/package.json 2>/dev/null | grep '"version"' | head -1 | cut -d'"' -f4)
      echo "   ✅ $lib ($VERSION)"
      ((PASSED++))
    else
      echo "   ⚠️ $lib - غير مثبت"
      ((WARNING++))
    fi
  done
else
  echo "❌ node_modules غير موجود - شغّل: npm install"
  ((FAILED++))
fi
echo ""

# ==================== الفحص 5: ملف .env ====================
echo "════════════════════════════════════════════════════════"
echo "✅ الفحص 5: متغيرات البيئة (.env)"
echo "════════════════════════════════════════════════════════"
echo ""

if [ -f ".env" ]; then
  echo "✅ ملف .env موجود"
  ((PASSED++))
  echo ""
  echo "المتغيرات المكتشفة:"
  
  VARS=("PORT" "MONGODB_URI" "JWT_SECRET" "NODE_ENV" "APP_NAME")
  
  while IFS= read -r line; do
    if [ ! -z "$line" ] && [[ ! "$line" =~ ^# ]]; then
      VAR_NAME=$(echo $line | cut -d'=' -f1)
      VAR_VALUE=$(echo $line | cut -d'=' -f2-)
      
      # إخفاء القيم الحساسة
      if [[ "$VAR_NAME" == *"SECRET"* ]] || [[ "$VAR_NAME" == *"PASSWORD"* ]] || [[ "$VAR_NAME" == *"KEY"* ]]; then
        VAR_VALUE="***hidden***"
      fi
      
      echo "   ✅ $VAR_NAME = $VAR_VALUE"
    fi
  done < .env
  
else
  echo "⚠️ ملف .env غير موجود"
  echo "   شغّل: cp .env.example .env"
  ((WARNING++))
fi
echo ""

# ==================== الفحص 6: ملفات JavaScript ====================
echo "════════════════════════════════════════════════════════"
echo "✅ الفحص 6: صيغة ملفات JavaScript"
echo "════════════════════════════════════════════════════════"
echo ""

echo "🔍 فحص server.js..."
if node -c server.js 2>/dev/null; then
  echo "✅ server.js - بدون أخطاء"
  ((PASSED++))
else
  echo "❌ server.js - يحتوي على أخطاء!"
  node -c server.js
  ((FAILED++))
fi
echo ""

# ==================== الفحص 7: الخادم ====================
echo "════════════════════════════════════════════════════════"
echo "✅ الفحص 7: حالة الخادم"
echo "════════════════════════════════════════════════════════"
echo ""

echo "🌐 اختبار الاتصال بـ http://localhost:8000/api/health..."
echo ""

if curl -s http://localhost:8000/api/health > /dev/null 2>&1; then
  RESPONSE=$(curl -s http://localhost:8000/api/health)
  echo "✅ الخادم يعمل!"
  echo "   الرد: $RESPONSE"
  ((PASSED++))
else
  echo "❌ الخادم غير متاح"
  echo "   شغّل: PORT=8000 npm run dev"
  ((FAILED++))
fi
echo ""

# ==================== الفحص 8: قاعدة البيانات ====================
echo "════════════════════════════════════════════════════════"
echo "✅ الفحص 8: قاعدة البيانات (MongoDB)"
echo "════════════════════════════════════════════════════════"
echo ""

echo "🗄️ اختبار الاتصال بـ MongoDB..."
echo ""

if mongosh --eval "db.adminCommand('ping')" 2>/dev/null | grep -q "ok"; then
  echo "✅ MongoDB متصل"
  ((PASSED++))
  
  # عرض عدد قواعد البيانات
  DATABASES=$(mongosh --eval "print(db.getMongo().getDBNames().length)" 2>/dev/null)
  echo "   عدد قواعد البيانات: $DATABASES"
  
else
  echo "⚠️ MongoDB غير متصل"
  echo "   لتشغيل MongoDB: mongod"
  ((WARNING++))
fi
echo ""

# ==================== الفحص 9: Expo ====================
echo "════════════════════════════════════════════════════════"
echo "✅ الفحص 9: تطبيق Expo (Frontend)"
echo "════════════════════════════════════════════════════════"
echo ""

if [ -d "frontend" ]; then
  echo "✅ مجلد frontend موجود"
  ((PASSED++))
  
  if [ -f "frontend/package.json" ]; then
    echo "✅ frontend/package.json موجود"
    ((PASSED++))
  else
    echo "❌ frontend/package.json مفقود"
    ((FAILED++))
  fi
  
  if [ -d "frontend/node_modules" ]; then
    echo "✅ frontend/node_modules موجود"
    ((PASSED++))
  else
    echo "⚠️ frontend/node_modules غير موجود"
    echo "   شغّل: cd frontend && npm install"
    ((WARNING++))
  fi
else
  echo "❌ مجلد frontend غير موجود"
  ((FAILED++))
fi
echo ""

# ==================== الفحص 10: API Endpoints ====================
echo "════════════════════════════════════════════════════════"
echo "✅ الفحص 10: نقاط النهاية (API Endpoints)"
echo "════════════════════════════════════════════════════════"
echo ""

if curl -s http://localhost:8000/api/restaurants > /dev/null 2>&1; then
  RESTAURANTS=$(curl -s http://localhost:8000/api/restaurants | grep -o '"name"' | wc -l)
  echo "✅ GET /api/restaurants (عدد المطاعم: $RESTAURANTS)"
  ((PASSED++))
else
  echo "❌ GET /api/restaurants غير متاح"
  ((FAILED++))
fi
echo ""

# ==================== الملخص النهائي ====================
echo "════════════════════════════════════════════════════════"
echo "📊 ملخص النتائج"
echo "════════════════════════════════════════════════════════"
echo ""

TOTAL=$((PASSED + FAILED + WARNING))
PERCENTAGE=$((PASSED * 100 / TOTAL))

echo "✅ نجح: $PASSED"
echo "❌ فشل: $FAILED"
echo "⚠️  تحذير: $WARNING"
echo "📊 الإجمالي: $TOTAL"
echo ""
echo "📈 نسبة النجاح: $PERCENTAGE%"
echo ""

# النتيجة النهائية
if [ $FAILED -eq 0 ] && [ $WARNING -eq 0 ]; then
  echo "════════════════════════════════════════════════════════"
  echo "🎉 ممتاز! التطبيق جاهز تماماً للاستخدام!"
  echo "════════════════════════════════════════════════════════"
elif [ $FAILED -eq 0 ]; then
  echo "════════════════════════════════════════════════════════"
  echo "✅ التطبيق يعمل بشكل جيد - مع بعض التحذيرات"
  echo "═══════════��════════════════════════════════════════════"
else
  echo "════════════════════════════════════════════════════════"
  echo "⚠️  يوجد مشاكل تحتاج لحل"
  echo "════════════════════════════════════════════════════════"
fi

echo ""
echo "⏱️ انتهى الفحص في: $(date +%Y-%m-%d\ %H:%M:%S)"
echo ""
