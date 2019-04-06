# COMPARISON OF EDGE DETECTION OPERATOR USING CANNY,  KIRSCH & MARR-HILDRETH (LoG) FOR ROAD MARKING DETECTION

![alt text](http://teemstudios.net/wp-content/uploads/2019/04/12.jpg)

## ENGLISH:
Self-driving  or  Autonomous driving, Advanced Driving Assistance System (ADAS) is one of the most popular topics in research related to vehicle safety. One of the most useful technologies in autonomous driving is lane detection that uses longitudinal marks (e.g. straight and dashed lines) as a reference to keep the vehicle running on lane. Various operators on edge detection are proposed to obtain the best accuracy of lane detection. However, the movement of the line marks between frames will vary depending on the speed of the vehicle. If the system fails to detect the line marker at high speed, will cause the autonomous driving system make a wrong decision. In this final task, we will perform a comparison analysis of Canny, Laplacian of Gaussian (Marr-Hildreth) and Kirsch's ability on edge detection methods to detect dashed line marks at varying speeds. The results showed that all operators succeeded in achieving the minimum detection target of 80% and obtained the best operators for line marker detection is Kirsch with the highest  percentage at all speeds 30, 50 and 80 km / h.

## INDONESIA:
Self-driving atau Autonomous driving, Advanced Driving Assistance System (ADAS) merupakan salah satu topik yang banyak digemari dalam berbagai penelitian yang berhubungan dengan keamanan kendaraan. Salah satu teknologi yang sangat berguna pada autonomous driving yaitu deteksi jalur atau lane detection yang menggunakan marka membujur ( e.g . garis putus dan utuh) sebagai acuan agar kendaraan dapat berjalan tetap pada jalurnya. Berbagai operator pada deteksi tepi diajukan untuk mendapatkan hasil akurasi deteksi semaksimal mungkin. Namun, pergerakan marka garis antar frame akan bervariasi tergantung pada kecepatan kendaraan. Jika sistem gagal mendeteksi marka garis pada kecepatan tinggi, akan mengakibatkan sistem autonomous driving salah mengambil keputusan. Pada penelitian ini, akan dilakukan analisis perbandingan kemampuan operator Canny, Laplacian of Gaussian (Marr-Hildreth) dan Kirsch pada metode deteksi tepi untuk mendeteksi marka garis putus – putus pada kecepatan yang bervariasi. Hasil pengujian menunjukan jika seluruh operator berhasil mencapai target minimum pendeteksian yaitu 80% dan didapatkan operator terbaik untuk pendeteksian marka garis yaitu Kirsch dengan persentase tertinggi pada kecepatan 30, 50 dan 80 km / jam.

# PURPOSE
Find the best edge detection operator for road marking/ lane detection.

# METHOD

![alt text](http://teemstudios.net/wp-content/uploads/2019/04/Algoritma-modifikasi.jpg)

Canny, Laplacian of Gaussian (Marr-Hildreth), Kirsch which every operator will do the same process (see block diagram below)
1. Check if image mode RGB,
2. If Yes, Grayscaling, then
3. Image Enhancement,
4. if No, Skip step 2 & 3,
5. Edge Detection,
6. Region of Interest (ROI)
7. Hough Transform
8. Show Detection

# HOW TO USE
This program has 2 function, You can use Edge detection operator with Library or without library.
1. Load folder into MATLAB
2. Run Main.fig
3. Click "i" button for further information (see app screenshot).
Note: **You need to make ROI vertices by clicking  "Buat Simpul ROI" after configuration your Adaptor, Camera, Resolution.**

# RESULTS
![alt-text](http://teemstudios.net/wp-content/uploads/2019/04/results.png)

Further explaination see "Jurnal.pdf"

# MORE
Contact me
