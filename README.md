# 🌍 TourSafe
**Tourist Safety Monitoring & Incident Response System**  
_Smart India Hackathon Project_

![GitHub repo size](https://img.shields.io/github/repo-size/your-username/TourSafe?color=blue)
![GitHub contributors](https://img.shields.io/github/contributors/your-username/TourSafe?color=green)
![GitHub last commit](https://img.shields.io/github/last-commit/your-username/TourSafe?color=yellow)

---

## 🚀 Problem Statement
Tourists often face **safety risks** like medical emergencies, theft, harassment, or getting lost.  
Emergency response is delayed due to **lack of real-time monitoring** and **communication gaps**.

**Our solution**:  
A smart system that enables tourists to **report incidents instantly** and allows responders to **track, monitor, and assist in real-time**.

---

## 🎯 Key Features
- 🗺️ **Real-time location tracking** (opt-in)  
- 🆘 **One-tap SOS button** (medical, theft, harassment, lost, other)  
- 📸 **Upload evidence** (photo/video) with incident report  
- 📍 **Responder dashboard** with live map and incident feed  
- 🔔 **Instant notifications** to responders and guardians  
- 📊 **Analytics & heatmaps** for hotspot areas  

---

## 🏗️ System Architecture
```mermaid
flowchart LR
    TouristApp(Tourist Mobile App) -->|GPS, SOS| BackendAPI
    BackendAPI --> Database[(Postgres + PostGIS)]
    BackendAPI --> MinIO[(MinIO Storage)]
    BackendAPI --> Redis[(Redis Queue)]
    BackendAPI --> Dashboard[Responder Dashboard]
    Dashboard --> BackendAPI
