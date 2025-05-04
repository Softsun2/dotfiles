# TODO:
# keyboard profile settings
# corner actions
# mouse speed
{
  CustomUserPreferences = {
    # set menu bar clock format, lol this is the most complete docs I could find for the format https://www.manageengine.com/au/products/desktop-central/script-templates/scripts/SetDateFormat.txt
    # "com.apple.menuextra.clock".DateFormat = "EEE d MMM h:mm a";
    # show battery percentage
    "com.apple.menuextra.battery".ShowPercent = true;
    # enabled menu bar icons
    "com.apple.controlcenter"."NSStatusItem Visible Sound" = 1;
    "com.apple.controlcenter"."NSStatusItem Visible Battery" = 1;
    "com.apple.controlcenter"."NSStatusItem Visible Bluetooth" = 1;
    "com.apple.controlcenter"."NSStatusItem Visible FocusModes" = 1;
    "com.apple.controlcenter"."NSStatusItem Visible UserSwitcher" = 1;
    # disabled menu bar icons
    "com.apple.controlcenter"."NSStatusItem Visible NowPlaying" = 0;
    "com.apple.controlcenter"."NSStatusItem Visible BentoBox" = 0;
    "com.apple.Spotlight"."NSStatusItem Visible Item-0" = 0;
    # grey accent color
    NSGlobalDomain.AppleAccentColor = -1;
    NSGlobalDomain.AppleAquaColorVariant = 6;
    # graphite highlight color
    NSGlobalDomain.AppleHighlightColor = "0.847059 0.847059 0.862745 Graphite";
    NSGlobalDomain.CGDisableCursorLocationMagnification = 1;
  };

  # menu bar clock
  menuExtraClock.IsAnalog = false;
  menuExtraClock.Show24Hour = false;
  menuExtraClock.ShowAMPM = true;
  menuExtraClock.ShowDayOfMonth = true;
  menuExtraClock.ShowDayOfWeek = true;
  menuExtraClock.ShowSeconds = false;

  ".GlobalPreferences"."com.apple.mouse.scaling" = -1.0;    # disable mouse acceleration
  NSGlobalDomain = {
    ApplePressAndHoldEnabled = false;               # enable key repeating
    InitialKeyRepeat = 15;                          # delay before repeats begin
    KeyRepeat = 3;                                  # delay between repeats
    NSAutomaticCapitalizationEnabled = false;
    NSAutomaticDashSubstitutionEnabled = false;
    NSAutomaticPeriodSubstitutionEnabled = false;
    NSAutomaticQuoteSubstitutionEnabled = false;
    NSAutomaticSpellingCorrectionEnabled = false;

    "com.apple.swipescrolldirection" = false;     # mouse-wheel-like scrolling
    AppleEnableSwipeNavigateWithScrolls = false;  # disable two finger navigation gesture

    "com.apple.sound.beep.feedback" = 0;                # enable audio feedback when adjusting volume
  };

  trackpad = {
    Clicking = true;                 # enable tap to click
  };

  dock = {
    autohide = true;
    mru-spaces = false;              # disable rearranging spaces based on most recent use
    show-recents = false;            # hide recent applications
    launchanim = false;              # disable opening application animations
    tilesize = 50;                   # default is 64
  };

  finder = {
    AppleShowAllExtensions = true;   # show all file extensions
    AppleShowAllFiles = true;        # show hidden files
    QuitMenuItem = true;             # enable quitting finder
    _FXShowPosixPathInTitle = true;  # show the full POSIX filepath in the window title
    FXPreferredViewStyle = "clmv";   # set the default view to column view
  };

  loginwindow = {
    GuestEnabled = false;   # no guests on my watch
    SHOWFULLNAME = false;    # display name and password field instead of userlist
  };
}
