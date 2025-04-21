local colors = {
    { rgb = {0.69, 0.337, 0.671}, hex = "#B056AB" },
    { rgb = {0.412, 0.949, 0.427}, hex = "#69F26D" },
    { rgb = {0.847, 0.953, 0.973}, hex = "#D8F3F8" },
    { rgb = {0.0, 0.0, 0.278}, hex = "#000047" },
    { rgb = {0.541, 1.0, 0.863}, hex = "#8AFFDC" },
    { rgb = {0.408, 0.824, 0.89}, hex = "#68D2E3" },
    { rgb = {0.933, 0.365, 0.424}, hex = "#EE5D6C" },
    { rgb = {0.694, 0.694, 0.463}, hex = "#B1B176" },
    { rgb = {0.0, 0.761, 0.537}, hex = "#00C289" },
    { rgb = {0.914, 0.545, 0.706}, hex = "#E98BB4" },
    { rgb = {0.427, 0.427, 0.212}, hex = "#6D6D36" },
    { rgb = {0.0, 0.902, 0.557}, hex = "#00E68E" },
    { rgb = {0.859, 0.859, 0.859}, hex = "#DBDBDB" },
    { rgb = {0.8, 0.8, 0.859}, hex = "#CCCCDB" },
    { rgb = {0.0, 1.0, 0.706}, hex = "#00FFB4" },
    { rgb = {0.6, 0.6, 0.722}, hex = "#9999B8" },
    { rgb = {0.169, 0.0, 1.0}, hex = "#2B00FF" },
    { rgb = {0.4, 0.4, 0.4}, hex = "#666666" },
    { rgb = {0.957, 1.0, 0.639}, hex = "#F4FFA3" },
    { rgb = {0.851, 0.541, 0.188}, hex = "#D98A30" },
    { rgb = {0.894, 1.0, 0.078}, hex = "#E4FF14" },
    { rgb = {0.333, 0.635, 0.69}, hex = "#55A2B0" },
    { rgb = {0.976, 0.925, 0.867}, hex = "#F9ECDD" },
    { rgb = {0.894, 0.416, 0.875}, hex = "#E46ADF" },
    { rgb = {0.62, 0.0, 0.0}, hex = "#9E0000" },
    { rgb = {0.369, 0.729, 0.788}, hex = "#5EBAC9" },
    { rgb = {0.922, 0.576, 0.91}, hex = "#EB93E8" },
    { rgb = {0.361, 0.0, 0.361}, hex = "#5C005C" },
    { rgb = {0.243, 0.937, 0.275}, hex = "#3EEF46" },
    { rgb = {0.796, 0.902, 0.0}, hex = "#CBE600" },
    { rgb = {0.616, 0.004, 0.616}, hex = "#9D019D" },
    { rgb = {0.902, 0.902, 0.902}, hex = "#E6E6E6" },
    { rgb = {0.788, 0.788, 0.788}, hex = "#C9C9C9" },
    { rgb = {0.137, 0.212, 0.341}, hex = "#233657" },
    { rgb = {0.008, 0.008, 0.008}, hex = "#020202" },
    { rgb = {0.918, 0.204, 0.286}, hex = "#EA3449" },
    { rgb = {0.89, 0.408, 0.612}, hex = "#E3689C" },
    { rgb = {0.702, 0.702, 0.702}, hex = "#B3B3B3" },
    { rgb = {1.0, 1.0, 1.0}, hex = "#FFFFFF" },
    { rgb = {0.157, 0.157, 0.0}, hex = "#282800" },
    { rgb = {0.992, 0.894, 0.745}, hex = "#FDE4BE" },
    { rgb = {0.937, 0.663, 0.78}, hex = "#EFA9C7" },
    { rgb = {0.11, 0.851, 0.149}, hex = "#1CD926" },
    { rgb = {0.098, 0.745, 0.129}, hex = "#19BE21" },
    { rgb = {0.686, 0.333, 0.482}, hex = "#AF557B" },
    { rgb = {0.671, 0.408, 0.129}, hex = "#AB6821" },
    { rgb = {0.522, 0.58, 0.0}, hex = "#859400" },
    { rgb = {0.302, 1.0, 0.788}, hex = "#4DFFC9" },
    { rgb = {0.118, 0.541, 0.059}, hex = "#1E8A0F" },
    { rgb = {0.976, 0.867, 0.973}, hex = "#F9DDF8" },
    { rgb = {0.886, 0.925, 0.357}, hex = "#E2EC5B" },
    { rgb = {0.149, 0.392, 0.047}, hex = "#26640C" },
    { rgb = {0.557, 0.263, 0.392}, hex = "#8E4364" },
    { rgb = {0.408, 0.408, 0.694}, hex = "#6868B1" },
    { rgb = {0.525, 0.643, 0.792}, hex = "#86A4CA" },
    { rgb = {0.741, 0.976, 0.749}, hex = "#BDF9BF" },
    { rgb = {0.294, 0.455, 0.667}, hex = "#4B74AA" },
    { rgb = {1.0, 0.447, 0.0}, hex = "#FF7200" },
    { rgb = {0.533, 0.863, 0.925}, hex = "#88DCEC" },
    { rgb = {0.145, 0.239, 0.357}, hex = "#253D5B" },
    { rgb = {0.702, 0.0, 0.0}, hex = "#B30000" },
    { rgb = {0.973, 0.847, 0.902}, hex = "#F8D8E6" },
    { rgb = {0.984, 0.749, 0.396}, hex = "#FBBF65" },
    { rgb = {0.894, 0.675, 0.416}, hex = "#E4AC6A" },
    { rgb = {0.0, 0.0, 0.541}, hex = "#00008A" },
    { rgb = {0.871, 0.871, 0.871}, hex = "#DEDEDE" },
    { rgb = {0.086, 0.133, 0.216}, hex = "#162237" },
    { rgb = {0.933, 1.0, 0.439}, hex = "#EEFF70" },
    { rgb = {0.243, 0.373, 0.596}, hex = "#3E5F98" },
    { rgb = {0.678, 0.678, 0.678}, hex = "#ADADAD" },
    { rgb = {0.8, 0.8, 0.8}, hex = "#CCCCCC" },
    { rgb = {0.941, 0.82, 0.678}, hex = "#F0D1AD" },
    { rgb = {0.98, 0.839, 0.859}, hex = "#FAD6DB" },
    { rgb = {0.882, 0.882, 0.918}, hex = "#E1E1EA" },
    { rgb = {0.918, 0.753, 0.561}, hex = "#EAC08F" },
    { rgb = {0.988, 0.804, 0.533}, hex = "#FCCD88" },
    { rgb = {0.749, 0.02, 0.82}, hex = "#BF05D1" },
    { rgb = {0.369, 0.369, 0.369}, hex = "#5E5E5E" },
    { rgb = {0.541, 0.961, 0.553}, hex = "#8AF58D" },
    { rgb = {0.6, 0.6, 0.6}, hex = "#999999" },
    { rgb = {0.91, 1.0, 0.22}, hex = "#E8FF38" },
    { rgb = {0.2, 0.2, 0.2}, hex = "#333333" },
    { rgb = {0.635, 0.722, 0.0}, hex = "#A2B800" },
    { rgb = {0.984, 0.69, 0.231}, hex = "#FBB03B" },
    { rgb = {0.953, 0.565, 0.612}, hex = "#F3909C" },
    { rgb = {0.98, 0.98, 0.98}, hex = "#FAFAFA" },
    { rgb = {0.18, 1.0, 0.753}, hex = "#2EFFC0" },
    { rgb = {0.792, 0.373, 0.78}, hex = "#CA5FC7" },
    { rgb = {0.004, 0.004, 0.004}, hex = "#010101" },
    { rgb = {0.82, 0.98, 0.835}, hex = "#D1FAD5" },
    { rgb = {0.282, 0.282, 0.098}, hex = "#484819" },
    { rgb = {0.643, 0.643, 0.776}, hex = "#A4A4C6" },
    { rgb = {0.302, 0.302, 0.302}, hex = "#4D4D4D" },
    { rgb = {0.188, 0.188, 0.188}, hex = "#303030" },
    { rgb = {0.18, 0.275, 0.439}, hex = "#2E4670" },
    { rgb = {0.502, 0.502, 0.502}, hex = "#808080" },
    { rgb = {0.584, 0.275, 0.569}, hex = "#954691" },
    { rgb = {0.969, 0.969, 0.969}, hex = "#F7F7F7" },
    { rgb = {0.035, 0.055, 0.086}, hex = "#090E16" },
    { rgb = {0.094, 0.149, 0.384}, hex = "#182662" },
    { rgb = {0.878, 0.537, 0.024}, hex = "#E08906" },
    { rgb = {0.373, 0.525, 0.725}, hex = "#5F86B9" },
    { rgb = {0.102, 0.102, 0.102}, hex = "#1A1A1A" },
    { rgb = {0.702, 0.702, 0.796}, hex = "#B3B3CB" },
    { rgb = {0.969, 0.714, 0.745}, hex = "#F7B6BE" },
    { rgb = {0.145, 0.227, 0.369}, hex = "#253A5E" },
    { rgb = {0.945, 0.694, 0.937}, hex = "#F1B1EF" },
    { rgb = {0.235, 0.369, 0.545}, hex = "#3C5E8B" },
    { rgb = {0.663, 0.898, 0.937}, hex = "#A9E5EF" },
    { rgb = {0.729, 0.969, 0.749}, hex = "#BAF7BF" },
    { rgb = {0.259, 0.259, 0.259}, hex = "#424242" },
    { rgb = {0.878, 0.0, 0.0}, hex = "#E00000" },
    { rgb = {0.878, 1.0, 0.0}, hex = "#E0FF00" },
    { rgb = {0.498, 0.498, 0.741}, hex = "#7F7FBD" },
    { rgb = {0.788, 0.369, 0.545}, hex = "#C95E8B" },
    { rgb = {0.976, 0.62, 0.082}, hex = "#F99E15" },
    { rgb = {1.0, 0.0, 0.0}, hex = "#FF0000" },
    { rgb = {0.0, 1.0, 0.0}, hex = "#00FF00" },
    { rgb = {0.0, 0.0, 1.0}, hex = "#0000FF" },
    { rgb = {1.0, 0.0, 1.0}, hex = "#FF00FF" },
    { rgb = {0.0, 1.0, 1.0}, hex = "#00FFFF" },
    { rgb = {1.0, 1.0, 0.0}, hex = "#FFFF00" },
    { rgb = {0.502, 0.0, 0.502}, hex = "#800080" },
    { rgb = {1.0, 0.647, 0.0}, hex = "#FFA500" },
    { rgb = {0.0, 0.502, 1.0}, hex = "#0080FF" },
    { rgb = {0.0, 1.0, 0.502}, hex = "#00FF80" },
    { rgb = {0.831, 0.686, 0.216}, hex = "#D4AF37" },
    { rgb = {0.753, 0.753, 0.753}, hex = "#C0C0C0" },
    { rgb = {0.722, 0.451, 0.2}, hex = "#B87333" },
    { rgb = {0.333, 0.42, 0.184}, hex = "#556B2F" },
    { rgb = {0.42, 0.557, 0.137}, hex = "#6B8E23" },
    { rgb = {0.804, 0.522, 0.247}, hex = "#CD853F" },
    { rgb = {0.18, 0.545, 0.341}, hex = "#2E8B57" },
    { rgb = {1.0, 0.714, 0.757}, hex = "#FFB6C1" },
    { rgb = {0.867, 0.627, 0.867}, hex = "#DDA0DD" },
    { rgb = {0.69, 0.878, 0.902}, hex = "#B0E0E6" }
  }
  colors.celestial_gold = colors[1]
  colors.hud_cyan = colors[2]
  colors.plasma_red = colors[3]
  colors.data_green = colors[4]
  colors.infra_black = colors[5]
  colors.tech_amber = colors[6]
  colors.rift_green = colors[7]
  colors.comms_orange = colors[8]
  colors.ion_blue = colors[9]
  colors.quantum_grey = colors[10]
  colors.nebula_pink = colors[11]
  colors.oxide_rust = colors[12]
  colors.proto_white = colors[13]
  colors.signal_white = colors[14]
  colors.gravity_purple = colors[15]
  colors.asteroid_brown = colors[16]
  colors.light_bright_blue = colors[17]
  colors.muted_grey = colors[18]
  colors.light_muted_yellow = colors[19]
  colors.light_bright_orange = colors[20]
  colors.light_bright_yellow = colors[21]
  colors.cyan = colors[22]
  colors.light_muted_orange = colors[23]
  colors.light_purple = colors[24]
  colors.red = colors[25]
  colors.tea = colors[26]
  colors.light_muted_purple = colors[27]
  colors.purple = colors[28]
  colors.light_green = colors[29]
  colors.electric_lime = colors[30]
  colors.light_eggplant = colors[31]
  colors.light_muted_grey = colors[32]
  colors.cloudy_blue = colors[33]
  colors.blue = colors[34]
  colors.dark_muted_grey = colors[35]
  colors.light_bright_red = colors[36]
  colors.light_pink = colors[37]
  colors.grey_concrete = colors[38]
  colors.really_light_blue = colors[39]
  colors.dark_yellow = colors[40]
  colors.orangey_leather = colors[41]
  colors.light_muted_pink = colors[42]
  colors.light_bright_green = colors[43]
  colors.bright_green = colors[44]
  colors.pink = colors[45]
  colors.orange = colors[46]
  colors.yellow = colors[47]
  colors.light_cyan = colors[48]
  colors.green = colors[49]
  colors.nebula_blue = colors[50]
  colors.light_yellow = colors[51]
  colors.DOS_green = colors[52]
  colors.plum = colors[53]
  colors.nebula_red = colors[54]
  colors.muted_blue = colors[55]
  colors.light_muted_green = colors[56]
  colors.blue_jeans = colors[57]
  colors.dust = colors[58]
  colors.nebula_green = colors[59]
  colors.nebula_purple = colors[60]
  colors.bright_red = colors[61]
  colors.nebula_grey = colors[62]
  colors.light_orange = colors[63]
  colors.orange_adobo = colors[64]
  colors.nebula_aqua = colors[65]
  colors.nebula_yellow = colors[66]
  colors.dark_blue = colors[67]
  colors.nebula_teal = colors[68]
  colors.nebula_orange = colors[69]
  colors.quantum_blue = colors[70]
  colors.quantum_red = colors[71]
  colors.quantum_green = colors[72]
  colors.light_muted_red = colors[73]
  colors.quantum_purple = colors[74]
  colors.quantum_pink = colors[75]
  colors.quantum_aqua = colors[76]
  colors.light_bright_purple = colors[77]
  colors.quantum_yellow = colors[78]
  colors.fresh_green = colors[79]
  colors.quantum_teal = colors[80]
  colors.green_safety_vest = colors[81]
  colors.quantum_orange = colors[82]
  colors.bright_yellow = colors[83]
  colors.pixel_blue = colors[84]
  colors.light_red = colors[85]
  colors.pixel_red = colors[86]
  colors.light_bright_cyan = colors[87]
  colors.pixel_green = colors[88]
  colors.black_almost = colors[89]
  colors.pixel_purple = colors[90]
  colors.nasty_green = colors[91]
  colors.pixel_pink = colors[92]
  colors.pixel_grey = colors[93]
  colors.pixel_aqua = colors[94]
  colors.pixel_yellow = colors[95]
  colors.pixel_teal = colors[96]
  colors.pixel_orange = colors[97]
  colors.laser_blue = colors[98]
  colors.laser_red = colors[99]
  colors.laser_purple = colors[100]
  colors.laser_pink = colors[101]
  colors.laser_grey = colors[102]
  colors.laser_aqua = colors[103]
  colors.laser_yellow = colors[104]
  colors.laser_teal = colors[105]
  colors.denim_blue = colors[106]
  colors.laser_orange = colors[107]
  colors.radar_blue = colors[108]
  colors.light_muted_cyan = colors[109]
  colors.radar_red = colors[110]
  colors.radar_green = colors[111]
  colors.radar_purple = colors[112]
  colors.radar_pink = colors[113]
  colors.radar_grey = colors[114]
  colors.radar_aqua = colors[115]
  colors.radar_yellow = colors[116]
  colors.warning_red = colors[117]
  colors.laser_green = colors[118]
  colors.signal_blue = colors[119]
  colors.neon_magenta = colors[120]
  colors.glow_cyan = colors[121]
  colors.alert_yellow = colors[122]
  colors.deep_space_purple = colors[123]
  colors.hazard_orange = colors[124]
  colors.pulse_blue = colors[125]
  colors.cyber_lime = colors[126]
  colors.golden_alloy = colors[127]
  colors.chrome_silver = colors[128]
  colors.burnished_copper = colors[129]
  colors.moss_forest = colors[130]
  colors.alien_olive = colors[131]
  colors.mars_soil = colors[132]
  colors.plasma_fern = colors[133]
  colors.soft_blush = colors[134]
  colors.dusty_lavender = colors[135]
  colors.sky_interface = colors[136]
  
  colors.color_names = {
  "celestial_gold",
  "hud_cyan",
  "plasma_red",
  "data_green",
  "infra_black",
  "tech_amber",
  "rift_green",
  "comms_orange",
  "ion_blue",
  "quantum_grey",
  "nebula_pink",
  "oxide_rust",
  "proto_white",
  "signal_white",
  "gravity_purple",
  "asteroid_brown",
  "light_bright_blue",
  "muted_grey",
  "light_muted_yellow",
  "light_bright_orange",
  "light_bright_yellow",
  "cyan",
  "light_muted_orange",
  "light_purple",
  "red",
  "tea",
  "light_muted_purple",
  "purple",
  "light_green",
  "electric_lime",
  "light_eggplant",
  "light_muted_grey",
  "cloudy_blue",
  "blue",
  "dark_muted_grey",
  "light_bright_red",
  "light_pink",
  "grey_concrete",
  "really_light_blue",
  "dark_yellow",
  "orangey_leather",
  "light_muted_pink",
  "light_bright_green",
  "bright_green",
  "pink",
  "orange",
  "yellow",
  "light_cyan",
  "green",
  "nebula_blue",
  "light_yellow",
  "DOS_green",
  "plum",
  "nebula_red",
  "muted_blue",
  "light_muted_green",
  "blue_jeans",
  "dust",
  "nebula_green",
  "nebula_purple",
  "bright_red",
  "nebula_grey",
  "light_orange",
  "orange_adobo",
  "nebula_aqua",
  "nebula_yellow",
  "dark_blue",
  "nebula_teal",
  "nebula_orange",
  "quantum_blue",
  "quantum_red",
  "quantum_green",
  "light_muted_red",
  "quantum_purple",
  "quantum_pink",
  "quantum_aqua",
  "light_bright_purple",
  "quantum_yellow",
  "fresh_green",
  "quantum_teal",
  "green_safety_vest",
  "quantum_orange",
  "bright_yellow",
  "pixel_blue",
  "light_red",
  "pixel_red",
  "light_bright_cyan",
  "pixel_green",
  "black_almost",
  "pixel_purple",
  "nasty_green",
  "pixel_pink",
  "pixel_grey",
  "pixel_aqua",
  "pixel_yellow",
  "pixel_teal",
  "pixel_orange",
  "laser_blue",
  "laser_red",
  "laser_purple",
  "laser_pink",
  "laser_grey",
  "laser_aqua",
  "laser_yellow",
  "laser_teal",
  "denim_blue",
  "laser_orange",
  "radar_blue",
  "light_muted_cyan",
  "radar_red",
  "radar_green",
  "radar_purple",
  "radar_pink",
  "radar_grey",
  "radar_aqua",
  "radar_yellow",
  "warning_red",
  "laser_green",
  "signal_blue",
  "neon_magenta",
  "glow_cyan",
  "alert_yellow",
  "deep_space_purple",
  "hazard_orange",
  "pulse_blue",
  "cyber_lime",
  "golden_alloy",
  "chrome_silver",
  "burnished_copper",
  "moss_forest",
  "alien_olive",
  "mars_soil",
  "plasma_fern",
  "soft_blush",
  "dusty_lavender",
  "sky_interface"
  }

function colors:random()
    return self[math.random(#self)]
end
local rainbow = {"\x1B[31m","\x1b[33m","\x1B[32m","\x1b[94m","\x1b[35m","\x1b[36m"}
local function colorword()
    local r = rainbow
    return "c"..r[1].."o"..r[2].."l"..r[3].."o"..r[4].."r"..r[5].."s".."\x1B[m"

end


print(colorword().." v.2.0 library Configured. TODO: still need to arrange names and order. Number of colors: "..tostring(#colors))

return colors