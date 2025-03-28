# HRoS – Human Resource Operating System

![HRoS Logo](https://hros.rccmaldives.com/assets/logo.png](https://hros.rccmaldives.com/assets/images/logos/dark-logo.svg)

> An all-in-one Human Resource Management System for employee management, leave tracking, document handling, recruitment, and internal communication – developed with Flutter, PHP, MySQL, and Tailwind CSS.

---

## 🚀 Features

### 🎯 Core Modules
- **Employee Management**: Add, update, search, and export employee details.
- **Leave Management**: Apply, approve, and track various leave types (Annual, Medical, Maternity, Paternity, Special, Emergency, No-Pay).
- **Payroll & Allowances**: Manage salaries, allowances, deductions, and generate pay slips.
- **Document Management**: Upload and view employee documents (passport, work permits, entry passes, etc.).
- **Recruitment System**: Create job posts, assign to agents, shortlist and hire candidates.
- **Passport Inventory**: Track passport movement (IN/OUT) with live QR scanner and map logging.
- **Push Notifications**: Real-time updates using OneSignal integration.
- **Role-Based Access Control**: Admin panel to assign module-level access to roles (Admin, HR, Agent, Director, etc.).
- **Mail System**: Automatic and manual internal mailing system with logs and groups.
- **Biometric Login**: Local authentication with fingerprint/face support in the Flutter app.

---

## 🛠️ Tech Stack

| Layer           | Technology                          |
|----------------|--------------------------------------|
| **Frontend**    | Flutter (Mobile), React + Tailwind (Web) |
| **Backend**     | PHP (REST API)                      |
| **Database**    | MySQL                               |
| **Push Alerts** | OneSignal                           |
| **QR Scanning** | Web + Mobile QR Scanner             |
| **Design System**| Tailwind CSS + Catalyst UI + Argon UI |

---

## 📱 Mobile App Features

- Employee dashboard with biometric login
- View leave balances and apply for leave
- Get push notifications
- View personal documents (with image/PDF previews)
- Change username and password
- Scan passports for IN/OUT logging

---

## 🌐 Web Portal Features

- Admin Dashboard
- HR Dashboard
- Agent Panel
- Document & Passport Viewer
- Recruitment & Candidate Management
- Email Composer + Logs
- RBAC Settings Panel
- Fully responsive with dark/light mode support

---

## 📂 Folder Structure

```
/hros
├── /api               # PHP backend API
├── /assets            # Uploaded files & images
├── /email             # Internal mailing system
├── /home              # HRMS main modules (payroll, leave, etc.)
├── /recruit           # Recruitment system
├── /passport_inv      # Passport tracking
├── /employee          # Employee module
├── /flutter-app       # Mobile app source
└── index.php          # Main web entry
```

---

## 🧪 Local Setup

### 🔧 Requirements
- PHP >= 7.4
- MySQL
- Flutter >= 3.10
- Node.js (for Tailwind CLI)
- Apache/Nginx

### 💻 Backend (PHP)
```bash
# Clone repo
git clone https://github.com/yourusername/hros.git
cd hros

# Import MySQL database
mysql -u root -p < db_dump.sql
```

### 🌐 Frontend (Web - React or PHP)
```bash
# Tailwind CLI (optional)
npm install -g tailwindcss
tailwindcss -i ./input.css -o ./output.css --watch
```

### 📱 Mobile (Flutter)
```bash
cd flutter-app
flutter pub get
flutter run
```





---

## 📧 Contact & Support

For issues, suggestions, or contributions, reach out to:

**📩 Email**: support@hros.rccmaldives.com  
**🌍 Website**: [https://hros.rccmaldives.com](https://hros.rccmaldives.com)

---

## 📃 License

MIT License © 2025 RCC Maldives
