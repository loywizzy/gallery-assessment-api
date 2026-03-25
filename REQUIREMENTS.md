# Project Requirements & Architecture Design

**Project Name:** Full-Stack Image Gallery Assessment
**Position:** Full-Stack Developer
**Architecture Approach:** Polyrepo (Separated Frontend and Backend)

---

## 1. Project Overview
ระบบเว็บแอปพลิเคชันแบบ Single-Page Application (SPA) สำหรับแสดงผล Gallery รูปภาพ โดยรูปภาพจะมีขนาดที่แตกต่างกัน (Masonry Layout) ผู้ใช้งานสามารถเลื่อนดูรูปภาพได้อย่างต่อเนื่อง (Infinite Scroll) และสามารถคลิกที่ Hashtag เพื่อกรองเฉพาะรูปภาพที่เกี่ยวข้องได้

---

## 2. Technology Stack

### Frontend (Client-Side)
* **Framework/Library:** React.js + Vite
* **Language:** TypeScript
* **Styling:** Tailwind CSS (สำหรับจัดการ UI และ Responsive design)
* **Key Libraries:** 
  * `react-masonry-css`: สำหรับจัด Layout รูปภาพขนาดไม่เท่ากัน
  * `axios`: สำหรับเรียกใช้งาน Backend API
  * `IntersectionObserver` API (Custom Hook): สำหรับตรวจจับการ Scroll หน้าจอ (Infinite Scroll)

### Backend (Server-Side)
* **Language:** Go (Golang)
* **Framework:** Gin (จัดการ Routing และ Middleware อย่างมีประสิทธิภาพ)
* **Database Driver:** `database/sql` ร่วมกับ `lib/pq` (Native PostgreSQL driver)

### Database
* **Database Engine:** PostgreSQL (จัดการ Relational Data ระหว่าง Image และ Hashtag)

---

## 3. System Architecture & Deployment Plan

เพื่อให้ระบบสามารถทำงานบน Production ได้จริงและประหยัดค่าใช้จ่าย ระบบจะถูก Deploy โดยแยกส่วน (Microservices Concept) ดังนี้:

### 3.1 Frontend Hosting
* **Provider:** Vercel หรือ Netlify
* **OS/Software:** Serverless Platform, Node.js Environment (สำหรับการ Build)
* **Specifications:** Auto-scaling (Free Tier)
* **Deployment Method:** CI/CD เชื่อมต่อกับ GitHub Repository (Build & Deploy อัตโนมัติเมื่อมีการ Push โค้ด)

### 3.2 Backend Server
* **Provider:** Render หรือ Koyeb
* **OS/Software:** Linux (Ubuntu/Debian based via Docker container), Go Runtime
* **Specifications:** 0.1 CPU, 512MB RAM (Free Tier)
* **Deployment Method:** Deploy ผ่าน Dockerfile หรือ Build จาก Source Code บน GitHub โดยตรง

### 3.3 Database Server
* **Provider:** Supabase หรือ Neon (Managed PostgreSQL Server)
* **Specifications:** 0.25 vCPU, 1GB RAM, 500MB Storage (Free Tier)
* **Connection:** เชื่อมต่อกับ Backend ผ่าน PostgreSQL Connection String (URI)

---

## 4. Features & Acceptance Criteria (ตาม Requirement)

1. **Gallery Display:** หน้าเว็บเพจแสดงรูปภาพ พร้อม Hashtag คำสำคัญใต้รูปภาพแต่ละรูป
2. **Infinite Scroll:** * โหลดรูปภาพเริ่มต้นจำนวน `X` รูป (เช่น 15 รูป)
   * เมื่อผู้ใช้ Scroll ลงมาถึงด้านล่างของหน้าจอ ระบบจะเรียก API โหลดรูปภาพชุดต่อไปมาแสดงเพิ่มอัตโนมัติ (Pagination: Page, Limit)
3. **Masonry Layout:** รูปภาพที่แสดงมีขนาด กว้าง/ยาว ไม่เท่ากัน (Dynamic Aspect Ratio)
4. **Hashtag Filtering:** เมื่อคลิกที่ Hashtag ใดๆ ระบบจะเคลียร์รูปภาพเก่า และดึงเฉพาะรูปภาพที่มี Hashtag นั้นๆ มาแสดงผล
5. **Mock Data Integration:**
   * ใช้บริการจาก `placehold.co` ในการจำลองรูปภาพ (เช่น `https://placehold.co/600x400`)
   * ใช้ไฟล์ `seed.sql` ในการ Generate ข้อมูลรูปภาพ 200 รูป และสุ่ม Hashtag มากกว่า 10 หมวดหมู่ลงฐานข้อมูล PostgreSQL
6. **Documentation:** มี System Architecture Diagram และคำอธิบายวิธีการ Deploy ชัดเจน (ระบุใน `README.md` ของทั้ง frontend และ backend)