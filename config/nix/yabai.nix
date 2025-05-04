{enable, package}:
{
  enable = enable;
  package = package;
  enableScriptingAddition = false;

  config = {
    # https://github.com/koekeishiya/yabai/blob/master/doc/yabai.asciidoc#config

    # global settings
    mouse_follows_focus = "off";
    focus_follows_mouse = "off";
    window_origin_display = "default";
    window_placement = "second_child";
    window_topmost = "on";
    window_shadow  = "on";
    window_opacity = "off";
    window_opacity_duration = 0.0;
    active_window_opacity = 1.0;
    normal_window_opacity = 1.0;

    split_ratio = 0.50;
    auto_balance = "off";
    mouse_modifier = "fn";
    mouse_action1 = "move";
    mouse_action2 = "resize";
    mouse_drop_action = "swap";

    # space settings
    layout = "bsp";
    top_padding = 10;
    bottom_padding = 10;
    left_padding = 10;
    right_padding = 10;
    window_gap = 10;

  };
}
