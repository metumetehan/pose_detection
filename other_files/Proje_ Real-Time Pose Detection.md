# **Proje: Real-Time Pose Detection**

## **1\. Proje Özeti**

Bu görevde, Google ML Kit kullanarak kullanıcının vücut hareketlerini gerçek zamanlı olarak algılayan ve eklem noktalarını (iskelet yapısını) kamera görüntüsü üzerine anlık olarak çizen bir mobil uygulama geliştirmen beklenmektedir.

## **2\. Teknik Gereksinimler**

* **Framework:** Flutter  
* **Paketler:** `google_mlkit_pose_detection`, `camera`, `permission_handler`  
* **Platform:** Android (Kamera izinleri yapılandırılmış olmalı).

## **3\. Mimari Akış ve Task Listesi**

### **Aşama 1: Kamera Entegrasyonu**

* `camera` paketi kullanılarak arka kamera akışı başlatılmalı.  
* Görüntü kalitesi `ResolutionPreset.medium` olarak ayarlanmalı (performans için).  
* **İpucu:** Görüntü akışını `startImageStream` fonksiyonu ile dinleyerek her frame'i yakalamalısın.

### **Aşama 2: Görüntü Dönüştürme (Image Processing)**

* Kameradan gelen `CameraImage` (YUV/BGRA) formatını, ML Kit'in kabul ettiği `InputImage` formatına dönüştüren bir yardımcı sınıf (Util) yazılmalı.  
* **Kritik Nokta:** Kamera sensör oryantasyonu (0, 90, 180, 270 derece) ve cihazın duruşu doğru hesaplanmalıdır.

### **Aşama 3: ML Kit Entegrasyonu**

* `PoseDetector` nesnesi `PoseDetectionMode.stream` modunda başlatılmalı.  
* Modelden dönen `Pose` nesnesinin içindeki `landmarks` (eklem noktaları) listesi yakalanmalı.  
* **Performans Kısıtı:** Bir frame işlenirken gelen yeni frame'ler "isBusy" kontrolü ile atlanmalı (UI donmasını önlemek için).

### **Aşama 4: UI ve Custom Painter (Görselleştirme)**

* `CustomPainter` sınıfı kullanılarak bir katman oluşturulmalı.  
* Dönen koordinatlar ekranda `Canvas.drawCircle` (eklemler için) ve `Canvas.drawLine` (kemikler/bağlantılar için) ile çizilmeli.  
* **Önemli:** ML Kit koordinatları kamera çözünürlüğüne göredir. Bu koordinatları ekran boyutuna (MediaQuery.size) oranlayacak bir `scale` hesaplaması yapmalısın.

---

## **4\. Kabul Kriterleri (Definition of Done)**

1. Uygulama açıldığında kamera izni istemeli.  
2. Kamera görüntüsü tam ekran (aspect ratio korunarak) gösterilmeli.  
3. Vücut eklemleri (omuz, dirsek, diz vb.) üzerinde noktalar gözükmeli.  
4. Kişi hareket ettiğinde çizimler 30 FPS'e yakın bir akıcılıkta güncellenmeli.  
5. Uygulama kapatıldığında veya arka plana alındığında kamera ve detector kaynakları (`dispose`) serbest bırakılmalı.

