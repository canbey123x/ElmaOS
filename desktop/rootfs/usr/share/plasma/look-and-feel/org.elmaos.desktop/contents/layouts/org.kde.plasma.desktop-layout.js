var screens = desktops();
for (var i = 0; i < screens.length; i++) {
    var screen = screens[i];
    screen.wallpaperPlugin = "org.kde.image";
    screen.currentConfigGroup = ["Wallpaper", "org.kde.image", "General"];
    screen.writeConfig("Image", "file:///usr/share/wallpapers/ElmaVentura/contents/images/1920x1080.svg");
}

var topBar = new Panel;
topBar.location = "top";
topBar.height = 28;
topBar.opacity = "translucent";
var launcher = topBar.addWidget("org.kde.plasma.kickoff");
launcher.currentConfigGroup = ["General"];
launcher.writeConfig("icon", "/usr/share/pixmaps/elma-mark.svg");
launcher.writeConfig("customButtonImage", "/usr/share/pixmaps/elma-mark.svg");
topBar.addWidget("org.kde.plasma.appmenu");
var space = topBar.addWidget("org.kde.plasma.panelspacer");
space.currentConfigGroup = ["Configuration", "General"];
space.writeConfig("expanding", true);
topBar.addWidget("org.kde.plasma.systemtray");
var clock = topBar.addWidget("org.kde.plasma.digitalclock");
clock.currentConfigGroup = ["Appearance"];
clock.writeConfig("showDate", true);

var dock = new Panel;
dock.location = "bottom";
dock.height = 72;
dock.floating = true;
dock.alignment = "center";
dock.lengthMode = "fit";
dock.opacity = "translucent";
var tasks = dock.addWidget("org.kde.plasma.icontasks");
tasks.currentConfigGroup = ["General"];
tasks.writeConfig("launchers", [
    "applications:elma-dosyalar.desktop",
    "applications:elma-tarayici.desktop",
    "applications:elma-terminal.desktop",
    "applications:elma-notlar.desktop",
    "applications:elma-magaza.desktop",
    "applications:elma-ayarlar.desktop",
    "applications:elma-hesap.desktop"
].join(","));
dock.addWidget("org.kde.plasma.trash");
