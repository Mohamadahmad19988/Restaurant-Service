# 🍽️ طعم مرسين - Taam Mersin

**تطبيق ويب شامل لطلب الطعام من مطاعم منطقة مرسين مع نظام دفع آمن وتتبع الطلبات في الوقت الفعلي**

---

## 📋 نظرة عامة

تطبيق ويب متقدم يوفر تجربة سهلة وآمنة لطلب الطعام من أفضل مطاعم مرسين. يجمع المشروع بين تقنيات حديثة وتصميم سهل الاستخدام.

### ✨ المميزات الرئيسية

#### 🛵 للعملاء
- 📍 عرض قائمة المطاعم القريبة مع المواقع والمسافات
- 🔍 البحث المتقدم حسب اسم المطعم أو نوع الطعام أو التقييم
- 📸 عرض صور الأطباق مع الأسعار والمكونات
- ⭐ تصفية حسب التقييمات والمميزات (نباتي، حار، إلخ)
- 🛒 نظام السلة سهل الاستخدام
- 💳 نظام دفع آمن (بطاقات ائتمان + كاش)
- 📍 تتبع الطلب في الوقت الفعلي
- 💬 تقييم وتقديم ملاحظات على الطلبات
- ❤️ حفظ المطاعم المفضلة
- 🏠 إدارة العن��وين المتعددة

#### 🍴 للمطاعم
- 📊 لوحة تحكم إدارية متقدمة
- 📝 إدارة القائمة والأسعار
- 📦 إدارة الطلبات الواردة
- 📈 عرض الإحصائيات والمبيعات
- ⏰ إدارة ساعات العمل والعطل
- 🗺️ إدارة المواقع وأسعار التوصيل

#### 🔐 الأمان
- ✅ مصادقة آمنة باستخدام JWT
- 🔒 تشفير كلمات المرور
- 💰 معالجة آمنة للدفع عبر Stripe
- 🛡️ حماية من الهجمات الشائعة

---

## 🛠️ التكنولوجيا المستخدمة

### Backend
- **Node.js** - بيئة التشغيل
- **Express.js** - إطار العمل
- **MongoDB** - قاعدة البيانات
- **Mongoose** - نمذجة البيانات
- **JWT** - المصادقة
- **Stripe** - نظام الدفع
- **Bcrypt** - تشفير كلمات المرور

### Frontend
- **React.js** أو **Vue.js** - واجهة المستخدم
- **Axios** - طلبات HTTP
- **Tailwind CSS** - التصميم
- **Google Maps API** - الخرائط والمواقع

---

## 📁 البنية الهيكلية للمشروع

```
Taam-Mersin/
├── models/                    # نماذج قاعدة البيانات
│   ├── User.js              # نموذج المستخدم
│   ├── Restaurant.js        # نموذج المطعم
│   ├── MenuItem.js          # نموذج عنصر القائمة
│   ├── Order.js             # نموذج الطلب
│   ├── Payment.js           # نموذج الدفع
│   └── Review.js            # نموذج التقييم
│
├── controllers/              # متحكمات المنطق
│   ├── userController.js
│   ├── restaurantController.js
│   ├── menuController.js
│   ├── orderController.js
│   └── paymentController.js
│
├── routes/                   # نقاط النهاية (Routes)
│   ├── users.js
│   ├── restaurants.js
│   ├── menu.js
│   ├── orders.js
│   └── payments.js
│
├── middleware/               # معالجات وسيطة
│   ├── auth.js             # المصادقة
│   └── errorHandler.js     # معالجة الأخطاء
│
├── config/                   # إعدادات
│   ├── database.js          # إعداد قاعدة البيانات
│   └── stripe.js            # إعداد Stripe
│
├── server.js                # الملف ال��ئيسي
├── package.json             # المكتبات المستخدمة
├── .env.example            # متغيرات البيئة (نموذج)
├── .gitignore              # ملفات تجاهلها Git
├── README.md               # التوثيق
└── LICENSE                 # الترخيص
```

---

## 🚀 البدء السريع

### المتطلبات
- **Node.js** v14+
- **MongoDB** (محلي أو قاعدة سحابية)
- **npm** أو **yarn**
- **حساب Stripe** (للدفع)

### خطوات التثبيت

1. **استنسخ المشروع**
```bash
git clone https://github.com/Mohamadahmad19988/Restaurant-Service.git
cd Restaurant-Service
```

2. **ثبت المكتبات**
```bash
npm install
```

3. **أنشئ ملف `.env`**
```bash
cp .env.example .env
```

4. **عدّل ملف `.env`** ببياناتك الخاصة
```env
PORT=5000
MONGODB_URI=mongodb://localhost:27017/taam-mersin
JWT_SECRET=your_secret_key_here
STRIPE_PUBLIC_KEY=your_stripe_public_key
STRIPE_SECRET_KEY=your_stripe_secret_key
```

5. **شغّل الخادم**
```bash
npm run dev
```

6. **افتح المتصفح**
```
http://localhost:5000/api/health
```

---

## 📡 نقاط النهاية (API Endpoints)

### �� المستخدمون
| الطريقة | المسار | الوصف |
|--------|--------|-------|
| POST | `/api/users/register` | التسجيل |
| POST | `/api/users/login` | تسجيل الدخول |
| GET | `/api/users/profile` | الحصول على الملف الشخصي |
| PUT | `/api/users/profile` | تحديث الملف الشخصي |
| POST | `/api/users/favorites/:id` | إضافة إلى المفضلة |
| DELETE | `/api/users/favorites/:id` | حذف من المفضلة |

### 🍴 المطاعم
| الطريقة | المسار | الوصف |
|--------|--------|-------|
| GET | `/api/restaurants` | جميع المطاعم |
| GET | `/api/restaurants/:id` | مطعم معين |
| GET | `/api/restaurants/search` | البحث |
| GET | `/api/restaurants/nearby` | القريبة من الموقع |
| GET | `/api/restaurants/top-rated` | الأعلى تقييماً |
| GET | `/api/restaurants/district/:district` | حسب المنطقة |
| POST | `/api/restaurants` | إنشاء (admin) |
| PUT | `/api/restaurants/:id` | تحديث (admin) |

### 🍽️ القوائم
| الطريقة | المسار | الوصف |
|--------|--------|-------|
| GET | `/api/menu/restaurant/:id` | قائمة المطعم |
| GET | `/api/menu/restaurant/:id/category/:cat` | حسب الفئة |
| GET | `/api/menu/search` | البحث |
| GET | `/api/menu/recommended/:id` | الموصى به |
| POST | `/api/menu` | إضافة عنصر (admin) |
| PUT | `/api/menu/:id` | تحديث عنصر (admin) |

### 📦 الطلبات
| الطريقة | المسار | الوصف |
|--------|--------|-------|
| POST | `/api/orders` | إنشاء طلب |
| GET | `/api/orders/:id` | تفاصيل الطلب |
| GET | `/api/orders/user/orders` | طلبات المستخدم |
| PUT | `/api/orders/:id/status` | تحديث الحالة |
| PUT | `/api/orders/:id/cancel` | إلغاء الطلب |
| POST | `/api/orders/:id/rate` | تقييم الطلب |

### 💳 الدفع
| الطريقة | المسار | الوصف |
|--------|--------|-------|
| POST | `/api/payments/create-intent` | إنشاء عملية دفع |
| POST | `/api/payments/cash-payment` | دفع كاش |
| GET | `/api/payments/status/:id` | حالة الدفع |
| POST | `/api/payments/webhook` | رد اتصال Stripe |

---

## 🔑 مثال على الطلب (Request)

### التسجيل
```bash
curl -X POST http://localhost:5000/api/users/register \
  -H "Content-Type: application/json" \
  -d '{
    "name": "أحمد محمد",
    "email": "ahmed@example.com",
    "password": "password123",
    "phone": "905001234567",
    "address": {
      "street": "شارع العروبة",
      "district": "يني شهر",
      "postalCode": "33000"
    }
  }'
```

### البحث عن المطاعم
```bash
curl http://localhost:5000/api/restaurants/search?query=pizza&minRating=4
```

### إنشاء طلب
```bash
curl -X POST http://localhost:5000/api/orders \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "restaurant": "RESTAURANT_ID",
    "items": [
      {
        "menuItem": "ITEM_ID",
        "quantity": 2,
        "specialRequests": "بدون بصل"
      }
    ],
    "deliveryAddress": {
      "street": "شارع البحر",
      "district": "القديمة",
      "coordinates": {
        "latitude": 36.7738,
        "longitude": 34.6325
      }
    },
    "paymentMethod": "credit_card"
  }'
```

---

## 🛡️ متغيرات البيئة

أنشئ ملف `.env` بالمتغيرات التالية:

```env
# الخادم
PORT=5000
NODE_ENV=development
APP_NAME=Taam Mersin
APP_URL=http://localhost:3000

# قاعدة البيانات
MONGODB_URI=mongodb://localhost:27017/taam-mersin

# المصادقة
JWT_SECRET=your_super_secret_jwt_key_change_this_in_production

# الدفع (Stripe)
STRIPE_PUBLIC_KEY=pk_test_your_public_key
STRIPE_SECRET_KEY=sk_test_your_secret_key
STRIPE_WEBHOOK_SECRET=whsec_your_webhook_secret
```

---

## 📊 حالات الطلب (Order Status)

```
┌─────────┐
│ pending │  ← الطلب الأولي
└────┬────┘
     │
     ▼
┌──────────┐
│confirmed │  ← تم تأكيد الطلب
└────┬─────┘
     │
     ▼
┌──────────┐
│ preparing│  ← الطعام قيد التحضير
└────┬─────┘
     │
     ▼
┌───────┐
│ ready │  ← الطعام جاهز
└────┬──┘
     │
     ▼
┌─────────────────┐
│ out_for_delivery│  ← التوصيل في الطريق
└────┬────────────┘
     │
     ▼
┌───────────┐
│ delivered │  ← تم التسليم ✓
└───────────┘
```

---

## 🧪 الاختبار

### اختبار التطبيق محلياً
```bash
npm run dev
```

### أدوات الاختبار الموصى بها
- **Postman** - لاختبار الـ API
- **MongoDB Compass** - لإدارة قاعدة البيانات
- **Stripe Dashboard** - لاختبار الدفع

---

## 📦 المكتبات المستخدمة

```json
{
  "dependencies": {
    "express": "^4.18.2",
    "mongoose": "^7.0.0",
    "dotenv": "^16.0.3",
    "cors": "^2.8.5",
    "bcryptjs": "^2.4.3",
    "jsonwebtoken": "^9.0.0",
    "stripe": "^11.1.0"
  }
}
```

---

## 🤝 المساهمة

نرحب بمساهماتك! يرجى:

1. Fork المشروع
2. أنشئ فرع للميزة الجديدة (`git checkout -b feature/AmazingFeature`)
3. Commit التغييرات (`git commit -m 'Add some AmazingFeature'`)
4. Push إلى الفرع (`git push origin feature/AmazingFeature`)
5. افتح Pull Request

---

## 📄 الترخيص

هذا المشروع مرخص تحت رخصة MIT - انظر ملف [LICENSE](LICENSE) للتفاصيل.

---

## 👨‍💻 المطور

**محمد أحمد**
- GitHub: [@Mohamadahmad19988](https://github.com/Mohamadahmad19988)

---

## 📧 التواصل والدعم

للأسئلة والاستفسارات والدعم الفني:
- 📧 البريد الإلكتروني: contact@taammersin.com
- 📱 رقم الهاتف: +90 312 XXX XXXX
- 💬 GitHub Issues: https://github.com/Mohamadahmad19988/Restaurant-Service/issues

---

## 🎯 خارطة الطريق المستقبلية

- [ ] تطبيق الجوال (React Native)
- [ ] نظام التوصيل بالمراقبة الحية
- [ ] نظام البرنامج الحالي للعملاء
- [ ] التكامل مع خدمات الدفع المحلية (Iyzico, PayTR)
- [ ] نظام إدارة المحفظة الرقمية
- [ ] AI للتوصيات الشخصية
- [ ] دعم متعدد اللغات
- [ ] تطبيق سطح المكتب للمطاعم

---

## 📸 لقطات الشاشة

*قريباً...*

---

<div align="center">

### تم بناؤه بـ ❤️ في مرسين 🇹🇷

⭐ إذا أعجبك المشروع، لا تنسَ إعطاؤه نجمة!

</div>
