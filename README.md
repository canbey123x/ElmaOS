# ElmaOS 1.0

Debian 13 (Trixie), amd64 ve KDE Plasma 6 tabanlı canlı sistem kaynakları. Grafik kurulum, ISO önyükleme menüsündeki Debian Installer üzerinden tasarlanmıştır.

## ISO derleme

Bir Debian 13 amd64 sanal makinesi kullanın. Projeyi Linux dosya sistemine çıkarın. Derleme için ağ erişimi, yaklaşık 30 GB boş alan ve 4 GB RAM ayırın.

```bash
sudo apt update
sudo apt install live-build debootstrap xorriso squashfs-tools isolinux syslinux-common grub-pc-bin grub-efi-amd64-bin mtools
sudo bash build.sh base
sudo bash build.sh desktop
```

Temel profil `dist/ElmaOS-base-amd64.iso`, masaüstü profili `dist/ElmaOS-1.0-amd64.iso` üretmeyi hedefler. Betik yalnızca live-build başarıyla bitince çıktı ve SHA-256 dosyasını yazar. Tam günlük `build/` altında bulunur.

## VirtualBox kabul kontrolü

Linux / Debian (64-bit) misafir, 2 işlemci, 4 GB RAM, 30 GB dinamik disk, VMSVGA, 128 MB video belleği, NAT ve etkin ses aygıtı ile başlayın. ISO’yu optik sürücüye takın. Önce temel ISO’da canlı oturumu ve grafik kurulumu deneyin, ardından tam ISO’da tekrarlayın.

1. Canlı menüyü açın, klavye ve fareyi deneyin. Ekran ayarlarında 1920×1080 modunu seçin. Modun görünmesi misafir grafik sürücüsüne ve VM yapılandırmasına bağlıdır.
2. Firefox ile bir sayfa açın, ses ayarlarında test sesi çalın.
3. Tam profilde Dock, üst panel, pencere düğmeleri ve açık/koyu temayı deneyin. Dosyalar, Terminal, Tarayıcı, Notlar ve Mağaza kısayollarını açın.
4. Grafik kurulumla boş sanal diske kurun. ISO’yu çıkarıp yeniden başlatın.
5. Kurulu sistemde Atla, hesap oluşturma, oturum kapatma, yanlış parola, yeniden giriş, profil ve parola değiştirme akışlarını deneyin. Bir kez daha yeniden başlatıp profili doğrulayın.
6. Discover üzerinden Debian deposundan küçük bir paket kurup kaldırın. İşlem yönetici yetkisi gerektirir.

## Hesap ve uygulamalar

Elma Hesabı, Linux oturumunun altında çalışan yerel uygulama profilidir. SQLite veritabanı kullanıcıya özel bir dizindedir ve parolalar benzersiz tuzlu Argon2id özetleri olarak tutulur. Profil oturumu yeniden başlatmalar arasında tutulur. Linux hesabının sahibi profil dosyalarını yönetebilir. Canlı oturumun verileri kalıcı depolama yapılandırılmadığında kapanışta silinir. Elma Ayarlar içinden hesap yönetimi açılır.

Dosyalar için Dolphin, Terminal için Konsole, Tarayıcı için Firefox ESR, Notlar için Kate ve Mağaza için Discover/PackageKit kullanılır. Uygulama başlatıcıları Elma adlarını taşır. Uygulamaların kendi iç başlıkları, kurulum ekranları ve bazı paket metinleri özgün Debian/KDE markalarını gösterebilir.

## Doğrulama durumu

Windows çalışma ortamında Debian derleme ortamı bulunmadığı için ISO derlenmedi. Canlı önyükleme, disk kurulumu, KDE görünümü, 1080p, ses ve ağ doğrulanmadı. Bu paket kaynak teslimidir. Dock, Plasma’nın simge görev yöneticisinin yerleşik animasyonlarını kullanır. Ventura tarzı imleçle büyütme eklenmemiştir.
