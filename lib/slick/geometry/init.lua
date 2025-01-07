--- @alias slick.geometry.shape slick.geometry.point | slick.geometry.ray | slick.geometry.rectangle | slick.geometry.segment

local geometry = {
    triangulation = require("slick.geometry.triangulation"),
    point = require("slick.geometry.point"),
    ray = require("slick.geometry.ray"),
    rectangle = require("slick.geometry.rectangle"),
    segment = require("slick.geometry.segment"),
    transform = require("slick.geometry.transform"),
}

return geometry
