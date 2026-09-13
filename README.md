# تطبيق خدمة المطاعم - Restaurant Service

## نظرة عامة
تطبيق ويب شامل لطلب الطعام من مطاعم منطقة مرسين مع نظام دفع متكامل وتتبع الطلبات.

## الميزات الرئيسية

### 🍽️ للعملاء
- عرض قائمة المطاعم في مرسين مع المواقع
- البحث والتصفية حسب نوع الطعام والتقييم والسعر
- عرض قوائم الطعام لكل مطعم مع الأسعار والصور
- نظام السلة والدفع الآمن
- تتبع الطلب في الوقت الفعلي
- الدفع عبر الإنترنت والدفع عند الاستلام
- تقييم المطاعم والطعام
- حفظ المفضلة

### 👨‍💼 للمطاعم
- لوحة تحكم لإدارة القائمة
- إدارة الطلبات
- تتبع الإحصائيات والمبيعات
- إدارة المواقع والساعات

### 🔐 الأمان
- المصادقة بـ JWT
- تشفير كلمات المرور
- معالجة آمنة للدفع

## التكنولوجيا المستخدمة

### Backend
- **Node.js** و **Express.js**
- **MongoDB** قاعدة البيانات
- **JWT** للمصادقة
- **Stripe** للدفع

### Frontend
- **React.js** أو **Vue.js**
- **Axios** للطلبات HTTP
- **Tailwind CSS** للتصميم
- **Google Maps API** لعرض المواقع

## البنية الهيكلية

```
Restaurant-Service/
├── server.js
├── package.json
├── .env.example
├── routes/
│   ├── restaurants.js
│   ├── menu.js
│   ├── orders.js
│   ├── users.js
│   └── payments.js
├── models/
│   ├── Restaurant.js
│   ├── MenuItem.js
│   ├── Order.js
│   ├── User.js
│   └── Payment.js
├── controllers/
│   ├── restaurantController.js
│   ├── menuController.js
│   ├── orderController.js
│   ├── userController.js
│   └── paymentController.js
├── middleware/
│   ├── auth.js
│   └── errorHandler.js
├── config/
│   ├── database.js
│   └── stripe.js
├── public/
│   ├── css/
│   ├── js/
│   └── images/
└── frontend/
    ├── src/
    ├── public/
    └── package.json
```

## التثبيت والتشغيل

### المتطلبات
- Node.js (v14+)
- MongoDB
- npm أو yarn

### خطوات التثبيت

1. **استنساخ المستودع**
```bash
git clone https://github.com/Mohamadahmad19988/Restaurant-Service.git
cd Restaurant-Service
```

2. **تثبيت الحزم**
```bash
npm install
```

3. **إعداد متغيرات البيئة**
```bash
cp .env.example .env
# عدّل .env بـ بيانات اتصالك
```

4. **تشغيل الخادم**
```bash
npm run dev
```

5. **تشغيل الواجهة الأمامية**
```bash
cd frontend
npm install
npm start
```

## نقاط النهاية (API Endpoints)

### المطاعم
- `GET /api/restaurants` - الحصول على جميع المطاعم
- `GET /api/restaurants/:id` - الحصول على تفاصيل مطعم
- `GET /api/restaurants/search` - البحث عن مطاعم

### القوائم
- `GET /api/menu/:restaurantId` - الحصول على قائمة المطعم
- `POST /api/menu` - إضافة عنصر جديد (للمطاعم)
- `PUT /api/menu/:id` - تحديث عنصر (للمطاعم)

### الطلبات
- `POST /api/orders` - إنشاء طلب جديد
- `GET /api/orders/:id` - الحصول على تفاصيل الطلب
- `GET /api/orders/user/:userId` - الحصول على طلبات المستخدم
- `PUT /api/orders/:id/status` - تحديث حالة الطلب

### الدفع
- `POST /api/payments/checkout` - إنشاء جلسة دفع
- `POST /api/payments/webhook` - معالجة رد الاتصال من Stripe

### المستخدمون
- `POST /api/users/register` - التسجيل
- `POST /api/users/login` - تسجيل الدخول
- `GET /api/users/profile` - الحصول على الملف الشخصي

## الترخيص
MIT License - انظر LICENSE للتفاصيل

## التواصل والدعم
للأسئلة والاقتراحات، يرجى فتح issue أو التواصل عبر البريد الإلكتروني.

---
مع تمنياتي بالتوفيق! 🚀
