# connectinno_task

A new Flutter project.

## Getting Started

# Reflactable edebilmesi için terminalde çalışacak kod

#  dart run build_runner build


 Connectinno Flutter Not Uygulaması Projesi - README 
# Bu proje, Connectinno vaka çalışması gereksinimlerini karşılamak üzere geliştirilmiş, katı Clean Architecture prensipleri, Çevrimdışı Öncelikli (Offline-First) veri yönetimi ve yüksek kod kalitesi standartlarına sahip bir mobil not uygulamasıdır.

  1. Mimari ve Katmanlı Klasörleme Yapısı
# - Proje, sürdürülebilirlik, test edilebilirlik ve Sorumlulukların Tek İlkesi (SRP - Single Responsibility Principle) prensibine uygunluğu için katmanlı bir yapı kullanır:

# - lib/core: Uygulamanın temel, tekrar kullanılabilir ve iş mantığından tamamen bağımsız altyapısını içerir.

# - Constant Kullanımı ve Clean Code: Tüm URL'ler, API anahtarları, Padding, SizedBox vb. hata mesaj kodları gibi sabit değerler,  app_constant içinde merkezileştirilmiştir.   Bu, kodun okunurluğunu ve ilerideki bakımını son derece kolaylaştırır.

#  - Tekrar Kullanılabilir Bileşenler (app_widget): Uygulama genelinde sıkça kullanılan tüm UI bileşenleri dışarıdan alınarak burada tanımlanmıştır. 

# - Merkezi Router (router_navigation): Gezinme kuralları burada tanımlanmıştır.

# - lib/data: Veri Katmanı. Uzak (API servisleri) ve Yerel (Hive veritabanı) veri kaynaklarıyla etkileşimi ve veri modellerini barındırır.

# - lib/features: Özellik (Feature) Katmanı. Uygulamanın ana işlevleri (auth, home vb.) kendi içlerinde kapalı ve bağımsız modüller olarak yer alır. Her modül kendi View, ViewModel/Cubit ve Service katmanına sahiptir.

# - lib/utils: Genel yardımcı fonksiyonlar bu kısımda toplanır.

 2. Durum Yönetimi ve Gezinme
# Bloc/Cubit (İş Mantığının Ayrılması): Durum yönetimi için flutter_bloc paketi tercih edilmiştir. Bu, iş mantığını View katmanından soyutlayarak SRP prensibine uyumu sağlar.

#  - GoRouter (Deklaratif Gezinme): Navigasyon, go_router paketi ile yönetilir.

  3. Gelişmiş Ağ (Network) ve Hata Yönetimi
- Ağ katmanı, SOLID prensiplerinden esinlenerek son derece soyutlanmış ve temizdir:

# - Singleton Tasarım Deseni (Merkezi Servis Erişimi): ApiConstant, NetworkApiService, PaddingConstant gibi kritik altyapı servisleri, uygulama boyunca yalnızca tek bir örneğin varlığını garanti eden Singleton deseni ile tasarlanmıştır. Bu, global hizmetlere güvenli ve tutarlı erişim sağlar.

# - Jenerik API Servisi: Tüm HTTP metotları jenerik (<T extends BaseResultModel>) yapıda tasarlanmıştır. Bu jenerik yapı, kod tekrarını önleyerek DRY prensibine uyar.

# -  (Reflection) Kullanımı: reflectable paketi ile, alınan JSON yanıtları dinamik olarak istenen Dart modeline dönüştürülür. Bu esneklik, veri modelleri ile servis katmanı arasındaki bağı minimuma indirir.

# - Detaylı Hata Normalizasyonu: HTTP durum kodları (400, 401, 500 vb.) ve Firebase hata kodları, son kullanıcıya hitap eden Türkçe, anlaşılır mesajlara dönüştürülerek kullanıcı deneyimi iyileştirilmiştir.

 4. Çevrimdışı Öncelikli Davranış (Offline-First)
# - Yerel Kalıcılık: Tüm notlar, hafif ve hızlı olan Hive veritabanı kullanılarak çevrimdışı erişilebilir durumdadır.

# - Senkronizasyon: Ağ bağlantısı kesikken yapılan güncellemeler, bağlantı geri geldiğinde arka uca otomatik olarak senkronize edilir.

# - UX (Geri Al İşlevi): Silme işleminden sonra, kullanıcıya geri alma imkanı sunan bir atıştırmalık çubuğu gösterilir.
