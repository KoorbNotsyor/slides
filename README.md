# slides

This is a first venture into using Flutter to develop multi-platform desktop apps.

Why do slideshow apps always go full-screen?

If you find this code useful please buy me a coffee...

<a href="https://www.buymeacoffee.com/azkn" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>

About Page
----------
The file 'assets/about.json' can be used to set certain values in the About screen:

    {
        "emailTo" : "toWhomm@whereareyou.com",
        "emailSubject" : "What is the subject?",
        "emailBody" : "DEFAULT BODY",
        "websiteIntro" : "Visit this website....",
        "website" : "https://whatismywebsite.com",
        "coffeeText" : "Please, please buy me coffee",
        "coffee" : "https://buymeacoffee.com/mickeyid"
    }

If any values are missing then default 'harmless' values are used.

POST 4.2.0

# TODO slide check for webm,mp4,mkv use media-kit video
# TODO add media-kit usage
# TODO add pause on current slide e.g. space bar or button

# Linux Desktop

**slides.desktop file**

    [Desktop Entry]
    Type=Application
    Version=3.0.0+1
    Name=Slides
    GenericName=Slide show
    Icon=slides
    Exec=slides
    Categories=Graphics;Utility;
    Keywords=Slideshow;Flutter;
    StartupNotify=true
    Actions=New;
    
    [Desktop Action New]
    Name=New
    Exec=slides
    

