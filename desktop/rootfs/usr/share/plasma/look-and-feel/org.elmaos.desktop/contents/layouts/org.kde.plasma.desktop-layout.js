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
topBar.addWidget("org.elmaos.findermenu");
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
dock.height = 76;
dock.floating = true;
dock.alignment = "center";
dock.lengthMode = "fit";
dock.opacity = "translucent";
dock.addWidget("org.elmaos.dock");
dock.addWidget("org.kde.plasma.trash");
