data.raw["gui-style"].default["FactorioMaps_button_style"] = {
    type = "button_style",
    parent = "button_style",
    top_padding = 1,
    right_padding = 5,
    bottom_padding = 1,
    left_padding = 5,
    left_click_sound = {{
        filename = "__core__/sound/gui-click.ogg",
        volume = 1
    }}
}

data.raw["gui-style"].default["FactorioMaps_sprite_button"] = {
    type = "button_style",
    parent = "FactorioMaps_button_style",
    width = 32,
    height = 32,
    top_padding = 0,
    right_padding = 0,
    bottom_padding = 0,
    left_padding = 0,
    left_click_sound = {{
        filename = "__core__/sound/gui-click.ogg",
        volume = 1
    }}
}

data:extend({
    {
        type="sprite",
        name="FactorioMaps_menu_sprite",
        filename = "__FactorioMaps__/graphics/menu.png",
        priority = "extra-high-no-scale",
        width = 32,
        height = 32,
    },
    {
        type="sprite",
        name="FactorioMaps_view_sprite",
        filename = "__FactorioMaps__/graphics/view.png",
        priority = "extra-high-no-scale",
        width = 32,
        height = 32,
    },
    {
        type="sprite",
        name="FactorioMaps_return_sprite",
        filename = "__FactorioMaps__/graphics/return.png",
        priority = "extra-high-no-scale",
        width = 32,
        height = 32,
    },
    {
        type="sprite",
        name="FactorioMaps_player_sprite",
        filename = "__FactorioMaps__/graphics/player.png",
        priority = "extra-high-no-scale",
        width = 32,
        height = 32,
    },
});
